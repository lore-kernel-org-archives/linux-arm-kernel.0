From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 25 Mar 2014 16:17:18 +0100
Subject: [PATCH 3/3] ARM: kprobes: Fix test code compilation errors for
 ARMv4 targets
In-Reply-To: <1395759284.3478.88.camel@linaro1.home>
References: <1394556894-18592-1-git-send-email-tixy@linaro.org>
 <6485768.fvJS4nr3cP@wuerfel> <1395759284.3478.88.camel@linaro1.home>
Message-ID: <4547839.aLXsq7v8z4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 25 March 2014 14:54:44 Jon Medhurst wrote:
> On Tue, 2014-03-25 at 14:42 +0100, Arnd Bergmann wrote:
> > On Tuesday 25 March 2014 09:27:29 David Long wrote:
> > > On 03/11/14 12:54, Jon Medhurst wrote:
> > > > Conditionally compile kprobes test cases for ARMv5 instructions to avoid
> > > > compilation errors with ARMv4 targets like:
> > > >
> > > > /tmp/cc7Tx8ST.s:16740: Error: selected processor does not support ARM mode `clz r0,r0'
> > > >
> > > > Signed-off-by: Jon Medhurst <tixy@linaro.org>
> > > 
> > > This looks OK to me.  Feel free to add my ack.
> > 
> > Ah, I had a similar patch in my 'randconfig-fixes' series.
> 
> Where's that?

http://git.kernel.org/cgit/linux/kernel/git/arnd/playground.git/commit/?h=arm-randconfig

> >  I noticed three
> > other configurations that are broken with kprobes-test:
> > 
> > - ARMv3 (enabled by ARCH_RPC)
> 
> Didn't know we support < ARMv4!

We don't really (any more). RPC is a v4 CPU, but we build the kernel
pretending it is v3 to work around some issue I don't remember.

> > - ARMv7-M (enabled by ARCH_EFM32)
> 
> I guess that problem is because randconfig is enabling HAVE_KPROBES,
> even though it wouldn't normally be selected, because we have
> 
>    config ARCH_ARM
> 	select HAVE_KPROBES if !XIP_KERNEL
> 
> and ARCH_EFM32 is XIP_KERNEL.

Right. EFM32 can in theory run without XIP_KERNEL, but the only
board we support doesn't have enough RAM for that.

> I think this problem goes all the way back to the commit which added
> HAVE_KPROBES to all arches (3f550096dede4430f83b16457da83bf429155ac2)
> That replaced 
> 
>    config KPROBES
> 	depends on ... (ARM && !XIP_KERNEL)
> 
> with the current select if !XIP_KERNEL, which made it possible to enable
> kprobes for XIP when before we couldn't. And presumably that was for a
> good reason like it doesn't work on XIP?

The text segment is very read-only in XIP_KERNEL, so anything that tries
to overwrite instructions can't work.

> Not sure at the moment how best to fix that. (Making ARM_KPROBES_TEST
> depend on !XIP_KERNEL doesn't solve the underlying problem of KPROBES
> feature still being enabled for XIP kernels.)

Regardless of XIP, there is the other problem of ARMv7-M support, which
in particular only has THUMB2 instructions:

  CC      arch/arm/kernel/kprobes.o
/tmp/cclbjgU2.s: Assembler messages:
	/tmp/cclbjgU2.s:701: Error: selected processor does not support Thumb mode `rfeia sp!'
make[3]: *** [arch/arm/kernel/kprobes.o] Error 1
  CC      arch/arm/kernel/kprobes-thumb.o
/tmp/ccwlnR1o.s: Assembler messages:
/tmp/ccwlnR1o.s:315: Error: selected processor does not support requested special purpose register -- `msr cpsr_fs,r0'
/tmp/ccwlnR1o.s:317: Error: selected processor does not support requested special purpose register -- `mrs r0,cpsr'
/tmp/ccwlnR1o.s:673: Error: selected processor does not support requested special purpose register -- `msr cpsr_fs,r3'
/tmp/ccwlnR1o.s:675: Error: selected processor does not support requested special purpose register -- `mrs r3,cpsr'
/tmp/ccwlnR1o.s:919: Error: selected processor does not support requested special purpose register -- `msr cpsr_fs,r8'
/tmp/ccwlnR1o.s:923: Error: selected processor does not support requested special purpose register -- `mrs r9,cpsr'
/tmp/ccwlnR1o.s:960: Error: selected processor does not support requested special purpose register -- `msr cpsr_fs,r8'
/tmp/ccwlnR1o.s:964: Error: selected processor does not support requested special purpose register -- `mrs r9,cpsr'
make[3]: *** [arch/arm/kernel/kprobes-thumb.o] Error 1
  CC      arch/arm/kernel/kprobes-test.o
/tmp/ccVIP6jA.s: Assembler messages:
/tmp/ccVIP6jA.s:1354: Error: selected processor does not support ARM opcodes
/tmp/ccVIP6jA.s:1355: Error: attempt to use an ARM instruction on a Thumb-only processor -- `orr lr,lr,#1'
/tmp/ccVIP6jA.s:1356: Error: attempt to use an ARM instruction on a Thumb-only processor -- `ldr pc,1f'
make[3]: *** [arch/arm/kernel/kprobes-test.o] Error 1
  CC      arch/arm/kernel/kprobes-test-thumb.o
/tmp/ccN8WTB4.s: Assembler messages:
/tmp/ccN8WTB4.s:2032: Error: selected processor does not support ARM opcodes
/tmp/ccN8WTB4.s:2033: Error: attempt to use an ARM instruction on a Thumb-only processor -- `adr lr,2f+1'
/tmp/ccN8WTB4.s:2034: Error: attempt to use an ARM instruction on a Thumb-only processor -- `bx lr'
/tmp/ccN8WTB4.s:4183: Error: selected processor does not support ARM opcodes
/tmp/ccN8WTB4.s:4184: Error: attempt to use an ARM instruction on a Thumb-only processor -- `adr lr,2f+1'
/tmp/ccN8WTB4.s:4185: Error: attempt to use an ARM instruction on a Thumb-only processor -- `bx lr'
/tmp/ccN8WTB4.s:4222: Error: selected processor does not support ARM opcodes
/tmp/ccN8WTB4.s:4223: Error: attempt to use an ARM instruction on a Thumb-only processor -- `adr lr,2f+1'
/tmp/ccN8WTB4.s:4224: Error: attempt to use an ARM instruction on a Thumb-only processor -- `bx lr'
/tmp/ccN8WTB4.s:5618: Error: selected processor does not support Thumb mode `rfedb sp'
/tmp/ccN8WTB4.s:5639: Error: selected processor does not support Thumb mode `rfeia sp'
/tmp/ccN8WTB4.s:5660: Error: selected processor does not support Thumb mode `rfedb sp!'
/tmp/ccN8WTB4.s:5681: Error: selected processor does not support Thumb mode `rfeia sp!'
/tmp/ccN8WTB4.s:6489: Error: selected processor does not support ARM opcodes
/tmp/ccN8WTB4.s:6490: Error: attempt to use an ARM instruction on a Thumb-only processor -- `adr lr,2f+1'
/tmp/ccN8WTB4.s:6491: Error: attempt to use an ARM instruction on a Thumb-only processor -- `bx lr'
/tmp/ccN8WTB4.s:6528: Error: selected processor does not support ARM opcodes
/tmp/ccN8WTB4.s:6529: Error: attempt to use an ARM instruction on a Thumb-only processor -- `adr lr,2f+1'
/tmp/ccN8WTB4.s:6530: Error: attempt to use an ARM instruction on a Thumb-only processor -- `bx lr'
/tmp/ccN8WTB4.s:7521: Error: selected processor does not support Thumb mode `strexd r0,r1,[r2]'
/tmp/ccN8WTB4.s:7584: Error: selected processor does not support Thumb mode `ldrexd r0,[r1]'
/tmp/ccN8WTB4.s:15321: Error: selected processor does not support Thumb mode `pkhbt r0,r0,r1'
/tmp/ccN8WTB4.s:15350: Error: selected processor does not support Thumb mode `pkhbt r14,r12,r10,lsl#2'
/tmp/ccN8WTB4.s:15379: Error: selected processor does not support Thumb mode `pkhtb r0,r0,r1'
/tmp/ccN8WTB4.s:15408: Error: selected processor does not support Thumb mode `pkhtb r14,r12,r10,asr#2'
/tmp/ccN8WTB4.s:18355: Error: selected processor does not support Thumb mode `ssat16 r0,#12,r0'

> > - CPU_ENDIAN_BE32 (enabled by building a big-endian kernel on ARMv5 or older)
> 
> > Should we treat those the same way, or just disable Kprobes for this case
> > if nobody cares?
> 
> For CPU_ENDIAN_BE32 I have a feeling that the kprobes code wouldn't
> work, would have to think more about why I have that feeling. If it
> doesn't, we come back to the problem that arch code can't add
> dependencies to CONFIG_KPROBES as things stand.

The error message I get here is

arnd at wuerfel:~/arm-soc$ make O=build/0xCD5BF01B_defconfig/  -skj40
/git/arm-soc/Makefile:629: Cannot use CONFIG_CC_STACKPROTECTOR_STRONG: -fstack-protector-strong not supported by compiler
/git/arm-soc/arch/arm/kernel/patch.c: In function '__patch_text':
/git/arm-soc/arch/arm/kernel/patch.c:35:4: error: implicit declaration of function '__opcode_to_mem_thumb32' [-Werror=implicit-function-declaration]
    insn = __opcode_to_mem_thumb32(insn);
    ^


I've filed that for now in the "wontfix" category, but I though I'd bring
it up anyway.

	Arnd
