From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 3 Nov 2017 19:26:35 +0000
Subject: [PATCH 00/15] Add support for clang LTO
In-Reply-To: <CAKwvOd=5CCMAA9n7=ocPO5UYmCmkNs8GLYrxXVZVZEeYCyisyA@mail.gmail.com>
References: <20171103171203.107569-1-samitolvanen@google.com>
 <20171103175156.f44o7kuxgzym3pbt@lakrids.cambridge.arm.com>
 <20171103180913.whp2tdjjvs32f4lz@lakrids.cambridge.arm.com>
 <CAKwvOd=5CCMAA9n7=ocPO5UYmCmkNs8GLYrxXVZVZEeYCyisyA@mail.gmail.com>
Message-ID: <20171103192634.u25go4tu7lgzl6ja@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 03, 2017 at 11:11:45AM -0700, Nick Desaulniers wrote:
> On Fri, Nov 3, 2017 at 11:09 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> ently compile
> > What's the minimum set of patches necessary to work with clang (ignoring
> > LTO)?
> 
> If you have a build of clang-5, then just patch 7 in this series to
> work around the last compiler bug.  If you build clang from source
> from master, ToT, for arm64, then none. :)

Thanks for the pointers.

With patch 7 I can build a defconfig from the arm64 for-next/core
branch, but it panics (in hyp) on my Juno R1 when initialising hyp.

If I build that branch with the Linaro 17.05 GCC 6.3.1 toolchain, I get
all the way to userspace.

The same is true (for both compilers) with v4.14-rc7.

I guess that in Google you haven't tested on a platform with EL2
available?

[    1.301280] kvm [1]: 8-bit VMID
[    1.304416] kvm [1]: IDMAP page: 809e2000
[    1.308406] kvm [1]: HYP VA range: 800000000000:ffffffffffff
[    1.315077] kvm [1]: Hyp mode initialized successfully
[    1.320211] Kernel panic - not syncing: HYP panic:
[    1.320211] PS:800003c9 PC:ffff0000089e6fd8 ESR:86000004
[    1.320211] FAR:ffff0000089e6fd8 HPFAR:0000000009825000 PAR:0000000000000000
[    1.320211] VCPU:000804fc20001221
[    1.320211]
[    1.341947] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.14.0-rc7-dirty #3
[    1.348675] Hardware name: ARM Juno development board (r1) (DT)
[    1.354543] Call trace:
[    1.356977] [<ffff000008088ea4>] dump_backtrace+0x0/0x34c
[    1.362333] [<ffff000008089208>] show_stack+0x18/0x20
[    1.367345] [<ffff0000089c73ec>] dump_stack+0xc4/0xfc
[    1.372357] [<ffff0000080c8e1c>] panic+0x138/0x2b4
[    1.377109] [<ffff0000080c8ce4>] panic+0x0/0x2b4
[    1.381692] SMP: stopping secondary CPUs
[    2.571295] SMP: failed to stop secondary CPUs 0-3,5
[    2.576214] Kernel Offset: disabled
[    2.579670] CPU features: 0x002086
[    2.583039] Memory Limit: none
[    2.586073] ---[ end Kernel panic - not syncing: HYP panic:
[    2.586073] PS:800003c9 PC:ffff0000089e6fd8 ESR:86000004
[    2.586073] FAR:ffff0000089e6fd8 HPFAR:0000000009825000 PAR:0000000000000000
[    2.586073] VCPU:000804fc20001221

The PC in question is:

[mark at lakrids:~/src/linux]% uselinaro 17.05 aarch64-linux-gnu-addr2line -ife vmlinux ffff0000089e6fd8
__init_stage2_translation
/home/mark/src/linux/arch/arm64/kvm/hyp/s2-setup.c:38

AFAICT, the generated assembly is only using PC-relative branches, and
no absolute relocations:

0000000000000000 <__init_stage2_translation>:
   0:	d5380709 	mrs	x9, id_aa64mmfr0_el1
   4:	12000928 	and	w8, w9, #0x7
   8:	7100111f 	cmp	w8, #0x4
   c:	d3700928 	ubfiz	x8, x9, #16, #3
  10:	54000188 	b.hi	40 <__init_stage2_translation+0x40>
  14:	9000000a 	adrp	x10, 0 <__init_stage2_translation>
  18:	92400929 	and	x9, x9, #0x7
  1c:	9100014a 	add	x10, x10, #0x0
  20:	f869794b 	ldr	x11, [x10,x9,lsl #3]
  24:	52800509 	mov	w9, #0x28                  	// #40
  28:	321b03e0 	orr	w0, wzr, #0x20
  2c:	321b03ea 	orr	w10, wzr, #0x20
  30:	d61f0160 	br	x11
  34:	52800480 	mov	w0, #0x24                  	// #36
  38:	321e0bea 	orr	w10, wzr, #0x1c
  3c:	14000008 	b	5c <__init_stage2_translation+0x5c>
  40:	321c07e9 	orr	w9, wzr, #0x30
  44:	14000004 	b	54 <__init_stage2_translation+0x54>
  48:	52800549 	mov	w9, #0x2a                  	// #42
  4c:	14000002 	b	54 <__init_stage2_translation+0x54>
  50:	52800589 	mov	w9, #0x2c                  	// #44
  54:	321d07ea 	orr	w10, wzr, #0x18
  58:	2a0903e0 	mov	w0, w9
  5c:	aa080148 	orr	x8, x10, x8
  60:	929957ea 	mov	x10, #0xffffffffffff3540    	// #-51904
  64:	d5380729 	mrs	x9, id_aa64mmfr1_el1
  68:	f2b0000a 	movk	x10, #0x8000, lsl #16
  6c:	d538072b 	mrs	x11, id_aa64mmfr1_el1
  70:	9148014c 	add	x12, x10, #0x200, lsl #12
  74:	f2400d3f 	tst	x9, #0xf
  78:	927c0d69 	and	x9, x11, #0xf0
  7c:	9a8c014a 	csel	x10, x10, x12, eq
  80:	f100813f 	cmp	x9, #0x20
  84:	aa0a0108 	orr	x8, x8, x10
  88:	1a9f17e9 	cset	w9, eq
  8c:	aa094d08 	orr	x8, x8, x9, lsl #19
  90:	d51c2148 	msr	vtcr_el2, x8
  94:	d65f03c0 	ret

... so I guess something is going wrong around kvm_call_hyp() where this
is called from EL1.

Thanks,
Mark.
