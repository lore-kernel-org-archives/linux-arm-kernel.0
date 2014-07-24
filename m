From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 24 Jul 2014 11:43:18 +0100
Subject: next build: 629 warnings 1 failures (next/next-20140723)
In-Reply-To: <20140724085037.GB1994@arm.com>
References: <53cf8323.e4b6440a.7d37.4f75@mx.google.com>
 <CAOesGMhT9n7nVbCay5cU74pv2qrbqMooZLoY923Lk6SzXk5z+A@mail.gmail.com>
 <20140724085037.GB1994@arm.com>
Message-ID: <20140724104318.GA13371@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 24, 2014 at 09:50:37AM +0100, Will Deacon wrote:
> On Thu, Jul 24, 2014 at 12:27:30AM +0100, Olof Johansson wrote:
> > On Wed, Jul 23, 2014 at 2:40 AM, Olof's autobuilder <build@lixom.net> wrote:
> > >         arm64.defconfig:
> > > arch/arm64/kernel/head.S:298: Error: unknown or missing system register name at operand 2 -- `mrs x0,S3_4_C12_C9_5'
> > > arch/arm64/kernel/head.S:301: Error: unknown or missing system register name at operand 1 -- `msr S3_4_C12_C9_5,x0'
> > > arch/arm64/kernel/head.S:303: Error: unknown or missing system register name at operand 1 -- `msr S3_4_C12_C11_0,xzr'
> > > arch/arm64/kernel/ptrace.c:1119:3: error: too many arguments to function 'audit_syscall_entry'
> > > /tmp/ccq7ZztI.s:21: Error: unknown or missing system register name at operand 1 -- `msr S3_0_C12_C12_1,x0'
> > > /tmp/ccq7ZztI.s:162: Error: unknown or missing system register name at operand 2 -- `mrs x19,S3_0_C12_C12_0'
> > > /tmp/ccq7ZztI.s:186: Error: unknown or missing system register name at operand 1 -- `msr S3_0_C12_C12_1,x19'
> > > /tmp/ccq7ZztI.s:220: Error: unknown or missing system register name at operand 1 -- `msr S3_0_C12_C12_1,x19'
> > > /tmp/ccq7ZztI.s:1110: Error: unknown or missing system register name at operand 1 -- `msr S3_0_C12_C11_5,x27'
> > > /tmp/ccq7ZztI.s:1530: Error: unknown or missing system register name at operand 2 -- `mrs x0,S3_0_C12_C12_5'
> > > /tmp/ccq7ZztI.s:1540: Error: unknown or missing system register name at operand 1 -- `msr S3_0_C12_C12_5,x0'
> > > /tmp/ccq7ZztI.s:1548: Error: unknown or missing system register name at operand 2 -- `mrs x0,S3_0_C12_C12_5'
> > > /tmp/ccq7ZztI.s:1564: Error: unknown or missing system register name at operand 1 -- `msr S3_0_C4_C6_0,x0'
> > > /tmp/ccq7ZztI.s:1576: Error: unknown or missing system register name at operand 1 -- `msr S3_0_C12_C12_4,x0'
> > > /tmp/ccq7ZztI.s:1592: Error: unknown or missing system register name at operand 1 -- `msr S3_0_C12_C12_7,x0'
> > 
> > 
> > I'm building with a vanilla gcc 4.8.2 / binutils 2.23.2. That
> > shouldn't be broken like this, so those changes should be fixed (or
> > minimal toolchain expecations need to be documented -- but there
> > really is no good reason to require 4.9.0/2.24).
> 
> These all come from the GICv3 driver, so it's not going to be a lot of fun
> fixing them. You'd have to introduce a macro for generating the system-reg
> accesses (for both C and asm), then switch the GIC driver and the arch code
> over to using that.

We may need to document that enabling GICv3 requires a newer toolchain.

Otherwise, my years old macros ;) (adapted here and untested):

In asm/sysreg.h:

#define	sys_reg(op0, op1, crn, crm, op2)	\
	((((op0)-2)<<19)|((op1)<<16)|((crn)<<12)|((crm)<<8)|((op2)<<5))

#ifdef __ASSEMBLY__

	.macro	mrs_s, rt, sreg
	.inst	0xd5300000|(\sreg)|(\rt)
	.endm

	.macro	msr_s, sreg, rt
	.inst	0xd5100000|(\sreg)|(\rt)
	.endm

#else

__asm__(
"	.macro	mrs_s, rt, sreg\n"
"	.inst	0xd5300000|(\\sreg)|(\\rt)\n"
"	.endm\n"
"\n"
"	.macro	msr_s, sreg, rt\n"
"	.inst	0xd5100000|(\\sreg)|(\\rt)\n"
"	.endm\n"
);

#endif


In the arm-gic-v3.h file, we change the definitions to:

#define ICC_SRE_EL2			sys_reg(3, 4, 12, 9, 5)


And in head.S:

	mrs_s	x0, ICC_SRE_EL2

Similarly in C files (the only change is s/mrs/mrs_s/):

	asm volatile("mrs_s %0, " __stringify(ICC_IAR1_EL1) : "=r" (irqstat));


But I'll let Marc comment when he gets back from holiday (I'm pretty
sure he will enjoy it ;))

-- 
Catalin
