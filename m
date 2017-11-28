From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 28 Nov 2017 14:13:55 +0000
Subject: kasan: false use-after-scope warnings with KCOV
In-Reply-To: <CACT4Y+Z2VhaDiFdg3aoi5uEsX7M+5-XMGH4PApys=qXKSMVUFg@mail.gmail.com>
References: <20171128123555.mo4ikj2ru6mkibwo@lakrids.cambridge.arm.com>
 <CACT4Y+Z2VhaDiFdg3aoi5uEsX7M+5-XMGH4PApys=qXKSMVUFg@mail.gmail.com>
Message-ID: <20171128141355.3pwgzfhji32lehf2@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 28, 2017 at 01:57:49PM +0100, Dmitry Vyukov wrote:
> On Tue, Nov 28, 2017 at 1:35 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> > As a heads-up, I'm seeing a number of what appear to be false-positive
> > use-after-scope warnings when I enable both KCOV and KASAN (inline or outline),
> > when using the Linaro 17.08 GCC7.1.1 for arm64. So far I haven't spotted these
> > without KCOV selected, and I'm only seeing these for sanitize-use-after-scope.
> >
> > The reports vary depending on configuration even with the same trigger. I'm not
> > sure if it's the reporting that's misleading, or whether the detection is going
> > wrong.

> > For example, with v4.15-rc1, defconfig + KCOV + KASAN_OUTLINE, I can trigger a
> > splat:
> >
> > $ perf record true

> > [   37.584702] BUG: KASAN: use-after-scope in __alloc_pages_nodemask+0x104/0x1608

> > $ ./scripts/faddr2line vmlinux __alloc_pages_nodemask+0x104/0x1608
> > __alloc_pages_nodemask+0x104/0x1608:
> > __alloc_pages_nodemask at mm/page_alloc.c:4215
> >
> > ... which is the declaration+initialisation of a local variable in
> > __alloc_pages_nodemask:

> > 4215         struct alloc_context ac = { };
> >
> > ... which is clearly not a use-after-scope bug.

> Has anything changed in your environment? Kernel? Compiler? Configs?

This is the first time I've used the Linaro 17.08 GCC 7.1.1
toolchain.

This is also the first time I've tested v4.15-rc1. I had a go with v4.14
(same toolchain, same config), and I saw the same problem.

Previously I was using the Linaro 17.05 GCC 6.3.1 toolchain, which did
not support -fsanitize-use-after-scope.

> The last one that I debugged related to stack false positives was due
> to incorrect DTLB flush after KASAN shadow initialization. But that
> was on x86 and due to a missed backport to 4.4.

The arm64 shadow initialization was recently reworked in v4.15-rc1, but
given I can trigger the same issue on v4.14, it doesn't seem likely
that's the problem.

> Please post disasm of the function. Instrumentation should have been
> cleared shadow for ac in prologue.

The function is 1400+ instructions, so I've just included the prologue
below at the end of the mail.

IIUC the relevant call to __asan_storeN is on line ffff200008293230.

AFAICT, the prologue doesn't zero the shadow at all -- it only
initialises the non-zero bytes. IIRC, functions are meant to clean up
when they return, as we had to fix up for idle in commit:

  0d97e6d8024c71cc ("arm64: kasan: clear stale stack poison")

I tested with idle disabled, which made no difference.

I hacked a kasan_clear_task_stack(current) immediately before the call
to __alloc_pages_nodemask(), and I get a splat later in
__save_stack_trace() instead. So it looks like the shadow placed by
__alloc_pages_nodemask() isn't overlapping its stack variables.

... it looks suspiciously like something is setting up non-zero shadow
bytes, but not zeroing them upon return.

Thanks,
Mark.

---->8----
ffff200008293130 <__alloc_pages_nodemask>:
ffff200008293130:	d116c3ff 	sub	sp, sp, #0x5b0
ffff200008293134:	d2915665 	mov	x5, #0x8ab3                	// #35507
ffff200008293138:	f2a836a5 	movk	x5, #0x41b5, lsl #16
ffff20000829313c:	d2c40007 	mov	x7, #0x200000000000        	// #35184372088832
ffff200008293140:	f2fbffe7 	movk	x7, #0xdfff, lsl #48
ffff200008293144:	f000b666 	adrp	x6, ffff200009962000 <kallsyms_token_index+0x13d00>
ffff200008293148:	a9007bfd 	stp	x29, x30, [sp]
ffff20000829314c:	910003fd 	mov	x29, sp
ffff200008293150:	910543a4 	add	x4, x29, #0x150
ffff200008293154:	910560c6 	add	x6, x6, #0x158
ffff200008293158:	d343fc88 	lsr	x8, x4, #3
ffff20000829315c:	8b070104 	add	x4, x8, x7
ffff200008293160:	a9151ba5 	stp	x5, x6, [x29, #336]
ffff200008293164:	90000005 	adrp	x5, ffff200008293000 <gfp_pfmemalloc_allowed+0x80>
ffff200008293168:	9104c0a5 	add	x5, x5, #0x130
ffff20000829316c:	f90087a8 	str	x8, [x29, #264]
ffff200008293170:	529e4086 	mov	w6, #0xf204                	// #61956
ffff200008293174:	a90153f3 	stp	x19, x20, [sp, #16]
ffff200008293178:	72be5e46 	movk	w6, #0xf2f2, lsl #16
ffff20000829317c:	a9025bf5 	stp	x21, x22, [sp, #32]
ffff200008293180:	aa0303f6 	mov	x22, x3
ffff200008293184:	a90363f7 	stp	x23, x24, [sp, #48]
ffff200008293188:	93407c55 	sxtw	x21, w2
ffff20000829318c:	f90023f9 	str	x25, [sp, #64]
ffff200008293190:	52802234 	mov	w20, #0x111                 	// #273
ffff200008293194:	a90573fb 	stp	x27, x28, [sp, #80]
ffff200008293198:	2a0003fb 	mov	w27, w0
ffff20000829319c:	f900b3a5 	str	x5, [x29, #352]
ffff2000082931a0:	3204d3e5 	mov	w5, #0xf1f1f1f1            	// #-235802127
ffff2000082931a4:	b8276905 	str	w5, [x8, x7]
ffff2000082931a8:	529e5e45 	mov	w5, #0xf2f2                	// #62194
ffff2000082931ac:	72be5e45 	movk	w5, #0xf2f2, lsl #16
ffff2000082931b0:	529e4007 	mov	w7, #0xf200                	// #61952
ffff2000082931b4:	29009486 	stp	w6, w5, [x4, #4]
ffff2000082931b8:	72be5e47 	movk	w7, #0xf2f2, lsl #16
ffff2000082931bc:	29019486 	stp	w6, w5, [x4, #12]
ffff2000082931c0:	9105c3a0 	add	x0, x29, #0x170
ffff2000082931c4:	29029486 	stp	w6, w5, [x4, #20]
ffff2000082931c8:	9113c3bc 	add	x28, x29, #0x4f0
ffff2000082931cc:	29039486 	stp	w6, w5, [x4, #28]
ffff2000082931d0:	91004393 	add	x19, x28, #0x10
ffff2000082931d4:	29049486 	stp	w6, w5, [x4, #36]
ffff2000082931d8:	72a02434 	movk	w20, #0x121, lsl #16
ffff2000082931dc:	29059486 	stp	w6, w5, [x4, #44]
ffff2000082931e0:	29069486 	stp	w6, w5, [x4, #52]
ffff2000082931e4:	29079486 	stp	w6, w5, [x4, #60]
ffff2000082931e8:	29089486 	stp	w6, w5, [x4, #68]
ffff2000082931ec:	29099486 	stp	w6, w5, [x4, #76]
ffff2000082931f0:	52be4006 	mov	w6, #0xf2000000            	// #-234881024
ffff2000082931f4:	290a9487 	stp	w7, w5, [x4, #84]
ffff2000082931f8:	290b9487 	stp	w7, w5, [x4, #92]
ffff2000082931fc:	290c9487 	stp	w7, w5, [x4, #100]
ffff200008293200:	290d9487 	stp	w7, w5, [x4, #108]
ffff200008293204:	290f1487 	stp	w7, w5, [x4, #120]
ffff200008293208:	3204d7e5 	mov	w5, #0xf3f3f3f3            	// #-202116109
ffff20000829320c:	29109486 	stp	w6, w5, [x4, #132]
ffff200008293210:	d000cac4 	adrp	x4, ffff200009bed000 <page_wait_table+0x1280>
ffff200008293214:	b9014fa1 	str	w1, [x29, #332]
ffff200008293218:	913ea099 	add	x25, x4, #0xfa8
ffff20000829321c:	9402f069 	bl	ffff20000834f3c0 <__asan_store4>
ffff200008293220:	52800022 	mov	w2, #0x1                   	// #1
ffff200008293224:	aa1303e0 	mov	x0, x19
ffff200008293228:	d2800301 	mov	x1, #0x18                  	// #24
ffff20000829322c:	b90173a2 	str	w2, [x29, #368]
ffff200008293230:	9402f1ac 	bl	ffff20000834f8e0 <__asan_storeN>
ffff200008293234:	9113c3a2 	add	x2, x29, #0x4f0
