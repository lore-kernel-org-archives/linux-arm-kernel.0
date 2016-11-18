From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Nov 2016 12:54:10 +0000
Subject: [PATCH] arm: spin one more cycle in timer-based delays
In-Reply-To: <20161118120630.GJ13470@arm.com>
References: <582B0F61.6030903@free.fr>
 <20161118120630.GJ13470@arm.com>
Message-ID: <20161118125409.GK1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 18, 2016 at 12:06:30PM +0000, Will Deacon wrote:
> On Tue, Nov 15, 2016 at 02:36:33PM +0100, Mason wrote:
> > When polling a tick counter in a busy loop, one might sample the
> > counter just *before* it is updated, and then again just *after*
> > it is updated. In that case, while mathematically v2-v1 equals 1,
> > only epsilon has really passed.
> > 
> > So, if a caller requests an N-cycle delay, we spin until v2-v1
> > is strictly greater than N to avoid these random corner cases.
> > 
> > Signed-off-by: Mason <slash.tmp@free.fr>
> > ---
> >  arch/arm/lib/delay.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/lib/delay.c b/arch/arm/lib/delay.c
> > index 69aad80a3af4..3f1cd15ca102 100644
> > --- a/arch/arm/lib/delay.c
> > +++ b/arch/arm/lib/delay.c
> > @@ -60,7 +60,7 @@ static void __timer_delay(unsigned long cycles)
> >  {
> >  	cycles_t start = get_cycles();
> >  
> > -	while ((get_cycles() - start) < cycles)
> > +	while ((get_cycles() - start) <= cycles)
> >  		cpu_relax();
> >  }
> 
> I thought a bit about this last night. It is well known that the delay
> routines are not guaranteed to be accurate, and I don't *think* that's
> limited to over-spinning, so arguably this isn't a bug. However, taking
> the approach that "drivers should figure it out" is also unhelpful,
> because the frequency of the underlying counter isn't generally known
> and so drivers can't simply adjust the delay parameter.

I don't think this change makes any sense whatsoever.  udelay() is
inaccurate, period.  It _will_ give delays shorter than requested
for many reasons, many of which can't be fixed.

Having a super-accurate version just encourages people to write broken
drivers which assume (eg) that udelay(10) will give _at least_ a 10us
delay.  However, there is no such guarantee.

So, having udelay() for timers return slightly short is actually a good
thing - it causes people not to make the mistake to be soo accurate
with their delay specifications.

So, NAK on this change.  udelay is not super-accurate.

Reference (and this is the most important one):

  http://lists.openwall.net/linux-kernel/2011/01/12/372

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
