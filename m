From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 24 Aug 2011 10:24:07 +0100
Subject: ARM processor mode, kernel startup, Hyp / secure state
In-Reply-To: <20110823221800.GA21084@e102144-lin.cambridge.arm.com>
References: <20051.48809.945431.800543@mariner.uk.xensource.com>
	<CA+wbFdcv_BsHaVwoqgF5yx6scXOodHkKjdVtarqJwjy_GFrAJQ@mail.gmail.com>
	<20110823221800.GA21084@e102144-lin.cambridge.arm.com>
Message-ID: <20110824092407.GA2078@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 23, 2011 at 11:18:00PM +0100, Will Deacon wrote:
> Dave,
> 
> On Tue, Aug 23, 2011 at 05:50:19PM +0100, Dave Martin wrote:
> > On Tue, Aug 23, 2011 at 3:52 PM, Ian Jackson <Ian.Jackson@eu.citrix.com> wrote:
> > > At first I thought that the best thing to do would be to boot the
> > > kernel in any suitable mode, and have the kernel automatically detect
> > > the starting mode. ?I started writing code in linux's head.S to do
> > > this. ?However, detecting whether we are in secure state is very
> > > difficult: it involves deliberately risking an undefined instruction
> > > trap. ?The code for this was getting rather long and involved.
> > 
> > There may be a safe way to do this check -- for example, on ARM1176
> > and Cortex-A8 there is a CP14 debug status/control register that you can
> > read which includes a flag indicating which world you're in.  This isn't part
> > of the architecture though and may be different/not possible on some
> > CPUs.
> 
> Please don't do this! Accessing the debug registers via the CP14 registers
> is like playing russian roulette with a machine gun, especially when you
> have various hypervisor registers and hardware lock registers to contend
> with. For 3.2, I will be guarding all of the hw_breakpoint init debug
> probing with an undef_hook because I'm sick of blowing my head off when
> systems are configured to keep debug out.

Heh -- I didn't think it was quite that scary, but point taken.

> > All in all, it's better to engineer things so that the check doesn't need to
> > be done at all
> 
> Agreed. I think it's better to assume that you can't detect whether you're
> running in secure state or not.
> 
> Will
