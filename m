From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 2 Nov 2011 16:41:02 +0100
Subject: AT91 reboot code
In-Reply-To: <20111102151210.GL19187@n2100.arm.linux.org.uk>
References: <20111101144058.GP19187@n2100.arm.linux.org.uk>
	<CAFumwP2m7=QsMTGAafPJs2ekm0R5FqCg8QxbOESBCq5r1PQkrA@mail.gmail.com>
	<20111102145903.GK19187@n2100.arm.linux.org.uk>
	<20111102151210.GL19187@n2100.arm.linux.org.uk>
Message-ID: <20111102154102.GB7136@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15:12 Wed 02 Nov     , Russell King - ARM Linux wrote:
> On Wed, Nov 02, 2011 at 02:59:03PM +0000, Russell King - ARM Linux wrote:
> > On Wed, Nov 02, 2011 at 07:43:28AM +0200, Andrew Victor wrote:
> > > hi Russell,
> > > 
> > > > Is there any reason this can't just be:
> > > >
> > > > void (*arch_reset)(char mode, const char *cmd);
> > > 
> > > I don't see any reason why not, except if arch_reset() can be called
> > > early in the setup code (before the platform initialization).
> > 
> > There is a case where it could happen - that is if you panic and you
> > have a non-zero panic timeout.
> > 
> > However, if you don't know how to restart your machine, then you're not
> > going to be able to do anything.  I'd therefore suggest this patch:
> 
> And we can do one better with this given the size of this change.
> As all the AT91 reset handlers are using a hardware method, we can
> do without the arm_machine_restart() indirection too.  And we can
> get rid of the icache enable in the assembly restart code as this
> will now be the case.  This is a replacement patch for the previous.
> 
> I've taken the liberty to rename _reset to _restart as well, so we
> have a common naming for this operation across converted platforms.
> 
>  arch/arm/mach-at91/at91cap9.c            |    4 ++--
>  arch/arm/mach-at91/at91rm9200.c          |    4 ++--
>  arch/arm/mach-at91/at91sam9260.c         |    2 +-
>  arch/arm/mach-at91/at91sam9261.c         |    2 +-
>  arch/arm/mach-at91/at91sam9263.c         |    2 +-
>  arch/arm/mach-at91/at91sam9_alt_reset.S  |    9 ++-------
>  arch/arm/mach-at91/at91sam9g45.c         |    4 ++--
>  arch/arm/mach-at91/at91sam9rl.c          |    2 +-
>  arch/arm/mach-at91/generic.h             |    3 +--
>  arch/arm/mach-at91/include/mach/system.h |    5 -----
>  10 files changed, 13 insertions(+), 24 deletions(-)
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

I'll test it later this week

Best Regards,
J.
