From: will.deacon@arm.com (Will Deacon)
Date: Wed, 26 Nov 2014 17:11:40 +0000
Subject: [PATCHv6 4/8] arm64: Move some head.text functions to executable
 section
In-Reply-To: <20141126163027.GC1819@leverpostej>
References: <1416606645-25633-1-git-send-email-lauraa@codeaurora.org>
 <1416606645-25633-5-git-send-email-lauraa@codeaurora.org>
 <20141126163027.GC1819@leverpostej>
Message-ID: <20141126171140.GN14866@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 26, 2014 at 04:30:27PM +0000, Mark Rutland wrote:
> On Fri, Nov 21, 2014 at 09:50:41PM +0000, Laura Abbott wrote:
> > The head.text section is intended to be run at early bootup
> > before any of the regular kernel mappings have been setup.
> > Parts of head.text may be freed back into the buddy allocator
> > due to TEXT_OFFSET so for security requirements this memory
> > must not be executable. The suspend/resume/hotplug code path
> > requires some of these head.S functions to run however which
> > means they need to be executable. Support these conflicting
> > requirements by moving the few head.text functions that need
> > to be executable to the text section which has the appropriate
> > page table permissions.
> > 
> > Tested-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> 
> Other than a minor nit below this looks good to me, and I'm not seeing
> any issues with boot, hotplug, or idle, so:
> 
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> Tested-by: Mark Rutland <mark.rutland@arm.com>
> 
> Thanks for putting this together!
> 
> > ---
> > v6: Dropped the latehead.text bit and just moved everything to the regular
> > text section
> > ---
> >  arch/arm64/kernel/head.S | 407 ++++++++++++++++++++++++-----------------------
> >  1 file changed, 210 insertions(+), 197 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> > index 10f5cc0..4b63d7a 100644
> > --- a/arch/arm64/kernel/head.S
> > +++ b/arch/arm64/kernel/head.S
> > @@ -238,7 +238,13 @@ ENTRY(stext)
> >         mov     x0, x22
> >         bl      lookup_processor_type
> >         mov     x23, x0                         // x23=current cpu_table
> > -       cbz     x23, __error_p                  // invalid processor (x23=0)?
> > +       /*
> > +        *      __error_p may end up out of range for cbz if text areas
> > +        *      are aligned up to section sizes
> > +        */
> 
> Nit: We don't need to align the comment text (we don't for the comment a
> few lines later, or any others in this file). It would be nice to keep
> that consistent.

Applied with this fixup.

Will
