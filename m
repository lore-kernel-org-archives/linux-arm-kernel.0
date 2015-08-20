From: stripathi@apm.com (Suman Tripathi)
Date: Thu, 20 Aug 2015 14:37:13 +0530
Subject: arch/arm/kernel/setup.c does not compile at -O0
In-Reply-To: <20150730155048.GS7557@n2100.arm.linux.org.uk>
References: <55BA1E62.9080103@free.fr>
 <CAOHikRBW+OnYvduFMVnssYAxDP4u+E+Q9NJ+5iDhnc21OvFRpg@mail.gmail.com>
 <20150730155048.GS7557@n2100.arm.linux.org.uk>
Message-ID: <CAOHikRASXDj2DWubjrQsy-BvAM7oGW06ddUcuRSGbM__gMYwPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Thu, Jul 30, 2015 at 9:20 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Jul 30, 2015 at 08:53:45PM +0530, Suman Tripathi wrote:
>> Hi,
>>
>> On Thu, Jul 30, 2015 at 6:23 PM, Mason <slash.tmp@free.fr> wrote:
>> >
>> > Hello everyone,
>> >
>> > I'm trying to debug a live kernel (v3.14) using a DS-5 JTAG probe.
>> >
>> > In order to make the control flow easier to follow, I disabled
>> > optimizations by adding
>> >
>> >   subdir-ccflags-y := -O0
>> >
>> > to arch/arm/kernel/Makefile
>> >
>> > With that change, linking fails:
>> >
>> > arch/arm/kernel/setup.c:924: undefined reference to `psci_smp_ops'
>> >
>> >       if (psci_smp_available())
>> >         smp_set_ops(&psci_smp_ops);
>> >
>> > #ifdef CONFIG_ARM_PSCI
>> > void psci_init(void);
>> > bool psci_smp_available(void);
>> > #else
>> > static inline void psci_init(void) { }
>> > static inline bool psci_smp_available(void) { return false; }
>> > #endif
>> >
>> > The optimizer is able to remove the entire block, but this
>> > does not happen when optimizations are disabled.
>> >
>> > Is compiling at -O0 not supported?
>>
>> If you have inline functions, it won't compile at -O0
>
> That's incorrect.
>
> If you have static inline functions, there isn't a problem irrespective
> of optimisation level - they'll become merely static functions which
> won't be inlined, and you'll end up with a copy of the function per
> compilation unit.
>
> If you have extern inline functions, they also won't be inlined, but
> unlike static inline, the compiler won't emit a static function.
> Instead, the compiler expects the function to be provided via another
> compilation unit or library (which won't happen in the Linux kernel.)
> However, Linux kernel coding style does not allow the use of extern
> inline functions.
>
> The problem which the Linux kernel has is that we rely on the compiler
> performing optimisations in multiple places - such as eliminating code
> which can't be reached.  Disabling the optimiser prevents such
> eliminations from happening, and ends up leaving symbols behind which
> are purposely not-defined (which are so in order to detect errors for
> accessors like get_user(), etc. which are only defined to operate on
> 1, 2, 4 and maybe 8 byte values.)
>
> For example:
>
> #define __put_user_check(x, p)                                          \
>         ({                                                              \
>                 unsigned long __limit = current_thread_info()->addr_limit - 1; \                const typeof(*(p)) __user *__tmp_p = (p);               \
>                 register const typeof(*(p)) __r2 asm("r2") = (x);       \
>                 register const typeof(*(p)) __user *__p asm("r0") = __tmp_p; \
>                 register unsigned long __l asm("r1") = __limit;         \
>                 register int __e asm("r0");                             \
>                 switch (sizeof(*(__p))) {                               \
>                 case 1:                                                 \
>                         __put_user_x(__r2, __p, __e, __l, 1);           \
>                         break;                                          \
>                 case 2:                                                 \
>                         __put_user_x(__r2, __p, __e, __l, 2);           \
>                         break;                                          \
>                 case 4:                                                 \
>                         __put_user_x(__r2, __p, __e, __l, 4);           \
>                         break;                                          \
>                 case 8:                                                 \
>                         __put_user_x(__r2, __p, __e, __l, 8);           \
>                         break;                                          \
>                 default: __e = __put_user_bad(); break;                 \
>                 }                                                       \
>                 __e;                                                    \
>         })
>
> which relies on the optimiser removing all the cases which don't apply to
> the access size.  Disabling optimisation prevents that happening, so you
> end up with the entire switch() statement coded in the output assembly
> for every invocation of this macro - which includes a call to
> __put_user_bad() just in case sizeof(*__p) changes unexpectedly.
>
> Building the kernel with optimisation disabled is not supported.

After some analysis found that :

1. with -O0 compiletime assertion's kick off and results in build failures

2. with -O1 or more it's doesn't kick off.

why this is so ?

For example below , the smp_store_release kicks calls
compiletime_assert_atomic_type  and build fails at O0 but passes at O1
.Point is this happens at preprocessing stage and cases for size of *p
afterwards which can be optimized when optimiser is enabled.

Snippet of smp_store_release :

#define smp_store_release(p, v) \
do { \
compiletime_assert_atomic_type(*p); \
switch (sizeof(*p)) { \
case 1: \
asm volatile ("stlrb %w1, %0" \
: "=Q" (*p) : "r" (v) : "memory"); \
break; \
case 2: \
asm volatile ("stlrh %w1, %0" \
: "=Q" (*p) : "r" (v) : "memory"); \
break; \
case 4: \
asm volatile ("stlr %w1, %0" \
: "=Q" (*p) : "r" (v) : "memory"); \
break; \
case 8: \
asm volatile ("stlr %1, %0" \
: "=Q" (*p) : "r" (v) : "memory"); \
break; \
} \
} while (0)

build output :

/projects/pnq/P4sbSW/stripath/open_source_sata/processor/shadowcat/linux/arch/arm64/kvm/../../../virt/kvm/kvm_main.c:
In function \u2018kvm_io_bus_register_dev\u2019:
/projects/pnq/P4sbSW/stripath/open_source_sata/processor/shadowcat/linux/include/linux/compiler.h:429:38:
error: call to \u2018__compiletime_assert_3113\u2019 declared with
attribute error: Need native word sized stores/loads for atomicity.
  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                      ^
/projects/pnq/P4sbSW/stripath/open_source_sata/processor/shadowcat/linux/include/linux/compiler.h:412:4:
note: in definition of macro \u2018__compiletime_assert\u2019
    prefix ## suffix();    \
    ^
/projects/pnq/P4sbSW/stripath/open_source_sata/processor/shadowcat/linux/include/linux/compiler.h:429:2:
note: in expansion of macro \u2018_compiletime_assert\u2019
  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
  ^
/projects/pnq/P4sbSW/stripath/open_source_sata/processor/shadowcat/linux/include/linux/compiler.h:432:2:
note: in expansion of macro \u2018compiletime_assert\u2019
  compiletime_assert(__native_word(t),    \
  ^
/projects/pnq/P4sbSW/stripath/open_source_sata/processor/shadowcat/linux/arch/arm64/include/asm/barrier.h:66:2:
note: in expansion of macro \u2018compiletime_assert_atomic_type\u2019
  compiletime_assert_atomic_type(*p);    \
  ^
/projects/pnq/P4sbSW/stripath/open_source_sata/processor/shadowcat/linux/include/linux/rcupdate.h:698:34:
note: in expansion of macro \u2018smp_store_release\u2019
 #define rcu_assign_pointer(p, v) smp_store_release(&p, RCU_INITIALIZER(v))
                                  ^
/projects/pnq/P4sbSW/stripath/open_source_sata/processor/shadowcat/linux/arch/arm64/kvm/../../../virt/kvm/kvm_main.c:3113:2:
note: in expansion of macro \u2018rcu_assign_pointer\u2019
  rcu_assign_pointer(kvm->buses[bus_idx], new_bus);
  ^
/projects/pnq/P4sbSW/stripath/open_source_sata/processor/shadowcat/linux/arch/arm64/kvm/../../../virt/kvm/kvm_main.c:
In function \u2018kvm_io_bus_unregister_dev\u2019:
/projects/pnq/P4sbSW/stripath/open_source_sata/processor/shadowcat/linux/include/linux/compiler.h:429:38:
error: call to \u2018__compiletime_assert_3148\u2019 declared with
attribute error: Need native word sized stores/loads for atomicity.
  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                      ^


>
> --
> FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
> according to speedtest.net.



-- 
Thanks,
with regards,
Suman Tripathi
