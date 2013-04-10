From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 10 Apr 2013 12:42:29 +0100
Subject: Removal of NWFPE in its entirety, and VFP emulation code
In-Reply-To: <yw1xmwt68whw.fsf@unicorn.mansr.com>
References: <20130410104002.GF14496@n2100.arm.linux.org.uk>
 <yw1xmwt68whw.fsf@unicorn.mansr.com>
Message-ID: <20130410114229.GH14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 10, 2013 at 12:18:19PM +0100, M?ns Rullg?rd wrote:
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> 
> > The situation with VFP is likely less disruptive - only instructions
> > which aren't implemented in hardware (or, for example, if you ask for
> > inexact exceptions to be enabled) which are bounced to the software
> > support code will be affected.  I think OMAP should get away unscathed,
> > but ARM's implementation will bounce if inexact exceptions are enabled
> 
> What do you mean by this?  OMAP uses ARM's cores.

OMAP's VFP reports that it never traps to support code for VFP instructions,
so the emulation code is never used on OMAP.

> > or in a few corner cases.  Qualcomm is likely to be the worst affected
> > by this.
> >
> > Will Deacon has tested debian armhf on a Cortex-A15 with VFP emulation
> > support removed, which boots successfully.
> 
> Cortex-A9 and later lack hardware support for VFP vector operations.
> Any code using these will fail to run without the software emulation.
> Of course such code is already horribly slow on these cores and should
> be fixed, so perhaps this is not such a terrible thing.

It's probably not "horribly slow" because unlike NWFPE, I went to great
efforts through my derivation of softfloat to ensure that it was as fast
and efficient as possible on ARM hardware.

If we can identify those which support the full range of VFP instructions
without trapping, but not the vector operations, we could implement the
vector iterations in the support code, executing non-vectored VFP
instructions instead.

But... the problem is identifying those implementations.  We aren't told
all the details about what the implementation supports and what it traps.
:(
