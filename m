From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 7 Jul 2011 18:36:45 +0100
Subject: [PATCHv2] arm: mm: Poison freed init memory
In-Reply-To: <1310057247-4933-1-git-send-email-sboyd@codeaurora.org>
References: <20110706210106.GX8286@n2100.arm.linux.org.uk>
	<1310057247-4933-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20110707173645.GD20403@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2011 at 09:47:27AM -0700, Stephen Boyd wrote:
> Poisoning __init marked memory can be useful when tracking down
> obscure memory corruption bugs. Therefore, poison init memory
> with 0xe7fddef0 to catch bugs earlier. The poison value is an
> undefined instruction in ARM mode and branch to an undefined
> instruction in Thumb mode.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
> 
> On 7/6/2011 2:01 PM, Russell King - ARM Linux wrote:
> > On Wed, Jul 06, 2011 at 01:55:54PM -0700, Stephen Boyd wrote:
> >> Should it include the initrd too? At least x86 poisons that memory but I
> >> don't know who would be using that incorrectly.
> >
> > It could do - I don't see any harm in not doing so.  The only issue
> > is that people may want to disable this stuff if they're after
> > squeezing every last ms out of the boot time.
> 
> I haven't done this. I hope a follow up patch will suffice.
> 
> >
> >> How about a free_init_area() function which calls free_area() after
> >> poisoning the memory?
> >
> > I need to go back and look at the Integrator etc situation with regard
> > to reorganizing the vmlinux layout - it may be that the omission of
> > freeing .init memory can now be removed (it was there to stop the
> > memory being used as the first K of memory wasn't DMA-able.)
> >
> > Assuming it has to stay though, we still should arrange for the initrd
> > memory to be poisoned even if it isn't freed.
> 
> Is this is patch what you're saying? I would have liked to do a
> free_init_area() wrapper, but until the Integrator situation can be
> sorted it doesn't look worthwhile.

Yes, thanks.  This looks fine for the time being.  Have you been able
to test it?  If yes, then please put it in the patch system and I'll
see about giving it a test too.
