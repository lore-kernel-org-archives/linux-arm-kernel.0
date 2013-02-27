From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 27 Feb 2013 11:22:23 +0000
Subject: [PATCH] ARM: vfp: fix fpsid register subarchitecture field
 mask width
In-Reply-To: <512D634D.5010600@codeaurora.org>
References: <1361520485-30269-1-git-send-email-sboyd@codeaurora.org>
 <20130225172545.GO17833@n2100.arm.linux.org.uk>
 <20130225200209.GP17833@n2100.arm.linux.org.uk>
 <512D634D.5010600@codeaurora.org>
Message-ID: <20130227112223.GA17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 26, 2013 at 05:37:17PM -0800, Stephen Boyd wrote:
> On 02/25/13 12:02, Russell King - ARM Linux wrote:
> >
> > This can of worms is getting bigger.  We have more problems with our
> > handling of the different VFP versions, specifically the handling of
> > the EX=0 DEX=0 case.
> >
> > VFP common subarch 3 defines the EX=0, DEX=0 encoding to mean one of
> > the following conditions have been met:
> >
> > 1. an unallocated VFP instruction was encountered.
> >
> >    In other words, the VFP was the target of the co-processor instruction,
> >    but the instruction is not a known VFP instruction encoding.  This
> >    should raise an undefined instruction exception.
> >
> > 2. an allocated VFP instruction was encountered, but not handled in
> >    hardware.
> >
> >    In other words, the instruction is a valid VFP instruction, but the
> >    hardware has opted not to implement this instruction and wants
> >    software to emulate it instead.
> >
> >    (Note: this can also be raised as EX=0, DEX=1 - implementation
> >     defined!)
> >
> [snip]
> >
> > So, if EX or DEX is set, _or_ IXE is set, we pass control to VFP_bounce.
> > This is problematical.
> >
> > (a) condition (2) above isn't correctly handled for common subarch v3 - it
> >     is always treated as an undefined instruction, and will result in a
> >     SIGILL being delivered.
> >
> [snip]
> >
> > Now, (a) is just bad behaviour - as we haven't had any reports of this
> > yet, I suspect that no one has implemented VFP hardware with this
> > behaviour yet.
> 
> I believe we ran into this a while ago and fixed it for our chips. We
> never sent the patch upstream. Sorry.
> 
> https://www.codeaurora.org/gitweb/quic/la/?p=kernel/msm.git;a=commitdiff;h=00a13be874f230159a6b7f8cc9d0ff23bc1b7d05

Yes, it looks like you did - because your short vector instructions are
"allocated VFP instruction"s and your hardware response is to raise an
exception with EX=0 DEX=0.

As you've found out, with the VFPv2 exception handling that we have, that
is interpreted as an undefined instruction, rather than an instruction
which needs fixing up.
