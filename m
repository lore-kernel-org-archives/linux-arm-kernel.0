From: dvyukov@google.com (Dmitry Vyukov)
Date: Wed, 29 Nov 2017 19:57:15 +0100
Subject: kasan: false use-after-scope warnings with KCOV
In-Reply-To: <5a431b68-8340-cc9c-53ed-918f677a3f60@virtuozzo.com>
References: <20171128123555.mo4ikj2ru6mkibwo@lakrids.cambridge.arm.com>
 <CACT4Y+Z2VhaDiFdg3aoi5uEsX7M+5-XMGH4PApys=qXKSMVUFg@mail.gmail.com>
 <20171128141355.3pwgzfhji32lehf2@lakrids.cambridge.arm.com>
 <20171128152405.vkwxdbkbuokjt2hv@lakrids.cambridge.arm.com>
 <CACT4Y+YTeLeUPRF=nsJFn-1wXux+yWCcbjmdcVQQFhXHXdY9YQ@mail.gmail.com>
 <5a431b68-8340-cc9c-53ed-918f677a3f60@virtuozzo.com>
Message-ID: <CACT4Y+ZG1sX0xpXZiuvh9XioqzdnsH65RyCuSJR4OkTd5njZfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 29, 2017 at 5:54 PM, Andrey Ryabinin
<aryabinin@virtuozzo.com> wrote:
> On 11/28/2017 08:52 PM, Dmitry Vyukov wrote:
>> On Tue, Nov 28, 2017 at 4:24 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>>>>>> As a heads-up, I'm seeing a number of what appear to be false-positive
>>>>>> use-after-scope warnings when I enable both KCOV and KASAN (inline or outline),
>>>>>> when using the Linaro 17.08 GCC7.1.1 for arm64. So far I haven't spotted these
>>>>>> without KCOV selected, and I'm only seeing these for sanitize-use-after-scope.
>>>>>>
>>>>>> The reports vary depending on configuration even with the same trigger. I'm not
>>>>>> sure if it's the reporting that's misleading, or whether the detection is going
>>>>>> wrong.
>>>
>>>> ... it looks suspiciously like something is setting up non-zero shadow
>>>> bytes, but not zeroing them upon return.
>>>
>>> It looks like this is the case.
>>>
>>> The hack below detects leftover poison on an exception return *before*
>>> the false-positive warning (example splat at the end of the email). With
>>> scripts/Makefile.kasan hacked to not pass
>>> -fsanitize-address-use-after-scope, I see no leftover poison.
>>>
>>> Unfortunately, there's not enough information left to say where exactly
>>> that happened.
>>>
>>> Given the report that Andrey linked to [1], it looks like the compiler
>>> is doing something wrong, and failing to clear some poison in some
>>> cases. Dennis noted [2] that this appears to be the case where inline
>>> functions are called in a loop.
>>>
>>> It sounds like this is a general GCC 7.x problem, on both x86_64 and
>>> arm64. As we don't have a smoking gun, it's still possible that
>>> something else is corrupting the shadow, but it seems unlikely.
>>
>>
>>
>> We use gcc 7.1 extensively on x86_64 and have not seen any problems.
>>
>
> Yeah, it's probably two different problems.
>
> Today kbuild reported another use-after-scope - http://lkml.kernel.org/r/<20171129052106.rhgbjhhis53hkgfn@wfg-t540p.sh.intel.com>
> No struct leak plugin and kcov instrumentation is also off. It's hard to tell whether it's false-positive or not, the code is a mess.
> So until proven otherwise, I tend to think that this time it's a real bug.
> .config attached, if someone want to look. It's easy reproducible, just boot qemu and wait.


I hacked a quick prototype for printing frame info:

--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -289,6 +289,7 @@ static void print_shadow_for_address(const void *addr)
        int i;
        const void *shadow = kasan_mem_to_shadow(addr);
        const void *shadow_row;
+       unsigned long *ptr;

        shadow_row = (void *)round_down((unsigned long)shadow,
                                        SHADOW_BYTES_PER_ROW)
@@ -320,6 +321,18 @@ static void print_shadow_for_address(const void *addr)

                shadow_row += SHADOW_BYTES_PER_ROW;
        }
+
+
+       ptr = (unsigned long *)((unsigned long)addr & ~7);
+       for (i = 0; i < 1000; i++, ptr--) {
+               if (*ptr == 0x41b58ab3) {
+                       pr_err("\n");
+                       pr_err("frame offset: %lu\n", (unsigned
long)addr - (unsigned long)ptr);
+                       pr_err("desc: '%s'\n", (const char*)*(ptr+1));
+                       pr_err("func: %pS\n", (void*)*(ptr+2));
+                       break;
+               }
+       }
 }



And this gave me:


[   26.763495] ==================================================================
[   26.764454] BUG: KASAN: use-after-scope in __drm_mm_interval_first+0xc0/0x1e2
[   26.765297] Read of size 8@addr ffff88006cb3fbe0 by task swapper/0/1
[   26.766081]
[   26.766278] CPU: 1 PID: 1 Comm: swapper/0 Not tainted
4.14.0-04319-gd17a1d97dc20-dirty #12
[   26.767760] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS Bochs 01/01/2011
[   26.769419] Call Trace:
[   26.769895]  dump_stack+0xdb/0x17a
[   26.770152]  ? _atomic_dec_and_lock+0x12f/0x12f
[   26.770152]  ? show_regs_print_info+0x5b/0x5b
[   26.770152]  ? kasan_report+0x4d/0x247
[   26.770152]  ? __drm_mm_interval_first+0xc0/0x1e2
[   26.770152]  print_address_description+0x9a/0x232
[   26.770152]  ? __drm_mm_interval_first+0xc0/0x1e2
[   26.770152]  kasan_report+0x21e/0x247
[   26.770152]  __asan_report_load8_noabort+0x14/0x16
[   26.770152]  __drm_mm_interval_first+0xc0/0x1e2
[   26.770152]  assert_continuous+0x13e/0x22f
[   26.770152]  __igt_insert+0x665/0xc87
[   26.770152]  ? igt_bottomup+0xaa0/0xaa0
[   26.770152]  ? sched_clock_local+0x3c/0xfb
[   26.770152]  ? find_held_lock+0x33/0x103
[   26.770152]  ? next_prime_number+0x318/0x362
[   26.770152]  ? rcu_irq_enter_disabled+0xd/0xd
[   26.770152]  ? next_prime_number+0x337/0x362
[   26.770152]  igt_replace+0x4b/0xb3
[   26.770152]  test_drm_mm_init+0x118/0x172
[   26.770152]  ? drm_kms_helper_init+0xb/0xb
[   26.770152]  do_one_initcall+0x10f/0x21f
[   26.770152]  ? initcall_blacklisted+0x185/0x185
[   26.770152]  ? down_write_nested+0xa1/0x164
[   26.770152]  ? kasan_poison_shadow+0x2f/0x31
[   26.770152]  ? kasan_unpoison_shadow+0x14/0x35
[   26.770152]  kernel_init_freeable+0x2ae/0x339
[   26.770152]  ? rest_init+0x250/0x250
[   26.770152]  kernel_init+0xc/0x105
[   26.770152]  ? rest_init+0x250/0x250
[   26.770152]  ret_from_fork+0x24/0x30
[   26.770152]
[   26.770152] The buggy address belongs to the page:
[   26.770152] page:ffff88007f39c5c8 count:0 mapcount:0 mapping:
   (null) index:0x0
[   26.770152] flags: 0x1a01fff800000()
[   26.770152] raw: 0001a01fff800000 0000000000000000 0000000000000000
00000000ffffffff
[   26.770152] raw: ffff88007f39c5e8 ffff88007f39c5e8 0000000000000000
[   26.770152] page dumped because: kasan: bad access detected
[   26.790299]
[   26.790299] Memory state around the buggy address:
[   26.790299]  ffff88006cb3fa80: 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 f1
[   26.790299]  ffff88006cb3fb00: f1 f1 f1 00 f2 f2 f2 f2 f2 f2 f2 00
00 f2 f2 f2
[   26.790299] >ffff88006cb3fb80: f2 f2 f2 f8 f8 f2 f2 f2 f2 f2 f2 f8
f8 f8 f8 f8
[   26.790299]                                                        ^
[   26.790299]  ffff88006cb3fc00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
f8 f8 f8 f2
[   26.790299]  ffff88006cb3fc80: f2 f2 f2 00 00 00 00 00 00 00 00 00
00 00 00 00
[   26.790299]
[   26.790299] frame offset: 232
[   26.790299] desc: '5 32 8 3 __u 96 16 4 prng 160 16 7 state__ 224
160 3 tmp 416 224 2 mm '
[   26.790299] func: __igt_insert+0x0/0xc87
[   26.790299] ==================================================================


That desc string is: number of local objects, then for each object:
offset, size, name length, name.

So that's variable tmp in __igt_insert. Not too surprising looking at the code:


    for (mode = insert_modes; mode->name; mode++) {
        for (n = 0; n < count; n++) {
            struct drm_mm_node tmp;

            node = replace ? &tmp : &nodes[n];
            memset(node, 0, sizeof(*node));
            if (!expect_insert(&mm, node, size, 0, n, mode)) {
                pr_err("%s insert failed, size %llu step %d\n",
                       mode->name, size, n);
                goto out;
            }

            if (replace) {
                drm_mm_replace_node(&tmp, &nodes[n]);
                if (drm_mm_node_allocated(&tmp)) {
                    pr_err("replaced old-node still allocated! step %d\n",
                           n);
                    goto out;
                }

                if (!assert_node(&nodes[n], &mm, size, 0, n)) {
                    pr_err("replaced node did not inherit parameters,
size %llu step %d\n",
                           size, n);
                    goto out;
                }

                if (tmp.start != nodes[n].start) {
                    pr_err("replaced node mismatch location expected
[%llx + %llx], found [%llx + %llx]\n",
                           tmp.start, size,
                           nodes[n].start, nodes[n].size);
                    goto out;
                }
            }
        }



I guess we need to finally do this for real. Also print global names.
