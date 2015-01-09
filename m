From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 9 Jan 2015 10:36:16 +0000
Subject: [PATCH 2/2] arm64: Emulate SETEND for AArch32 tasks
In-Reply-To: <54AFAB8C.5040803@arm.com>
References: <1420647405-3907-1-git-send-email-suzuki.poulose@arm.com>
 <1420647405-3907-3-git-send-email-suzuki.poulose@arm.com>
 <20150108184258.GB31280@leverpostej> <54AFAB8C.5040803@arm.com>
Message-ID: <20150109103616.GB27421@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 09, 2015 at 10:21:00AM +0000, Suzuki K. Poulose wrote:
> On 08/01/15 18:43, Mark Rutland wrote:
> > Hi Suzuki,
> >
> > On Wed, Jan 07, 2015 at 04:16:45PM +0000, Suzuki K. Poulose wrote:
> >> From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>
> >>
> >> Emulate deprecated 'setend' instruction for AArch32 bit tasks.
> >>
> >> 	setend [le/be] - Sets the endianness of EL0
> >>
> >> The hardware support for the instruction can be enabled by setting the
> >> SCTLR_EL1.SED bit. Like the other emulated instructions it is controlled by
> >> an entry in /proc/sys/abi/. For more information see :
> >> 	Documentation/arm64/legacy_instructions.txt
> >>
> >> The instruction is emulated by setting/clearing the SPSR_EL1.E bit, which
> >> will be reflected in the PSTATE.E in AArch32 context.
> >
> > A "fun" problem with emulating setend is that it will not always work
> > unless we emulate the entire instruction set when userspace wants to be
> > in an unsupported endianness.
> >
> > For implementations which are not bi-endian at EL0 (i.e. where
> > ID_AA64MMFR0_EL1.BigEndEL0 == 0), SCTLR_EL1.E0E has a fixed value which
> > we cannot change. The field names are misleading: in a BE-only system
> > ID_AA64MMFR0_EL1.{BigEnd,BigEndEL0} == {0,0} and SCTLR_EL1.{EE,E0E} are
> > fixed to {1,1}.
> >
> > I think we need to detect when EL0 has a fixed endianness such that we
> > can treat the setend instruction as undefined. Otherwise we will
> > silently fail to change EL0 endianness, advance the PC, and return to
> > userspace in the wrong endianness, which will be very painful to debug.
> > Userspace has the option of handling the resulting SIGILL in such cases.
> 
> You are right. I missed this scenario. To add to that things get 
> complicated when there are heterogeneous CPUs on the system that might 
> have differing bits for BigEndEL0. I will take a look at this one. 
> Thanks for pointing this out.

As I mention above the naming of {BigEnd,BigEndEL0} is misleading, as
the describe mixed endian support rather than big endian support.

For example, if all CPUs have ID_AA64MMFR0_EL1.BigEndEL0 == 0 the
endianness at EL0 is fixed, but that endianness may be LE or BE.

Thus you will need to check whether any CPU has
ID_AA64MMFR0_EL1.BigEndEL0 == 0, rather than whether the value of this
field differs across CPUs.

Cheers,
Mark.
