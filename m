From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 7 Oct 2015 12:04:57 +0100
Subject: [PATCH v3 1/5] clk: Add a basic multiplier clock
In-Reply-To: <20151005180929.GB12338@codeaurora.org>
References: <1443512353-28073-1-git-send-email-maxime.ripard@free-electrons.com>
 <1443512353-28073-2-git-send-email-maxime.ripard@free-electrons.com>
 <20151002204308.GY12338@codeaurora.org>
 <20151005101932.GH2696@lukather>
 <20151005180929.GB12338@codeaurora.org>
Message-ID: <20151007110457.GF2278@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 05, 2015 at 11:09:29AM -0700, Stephen Boyd wrote:
> On 10/05, Maxime Ripard wrote:
> > Hi,
> > 
> > On Fri, Oct 02, 2015 at 01:43:08PM -0700, Stephen Boyd wrote:
> > > On 09/29, Maxime Ripard wrote:
> > > > +
> > > > +	if (!val && mult->flags & CLK_MULTIPLIER_ZERO_BYPASS)
> > > > +		val = 1;
> > > > +	
> > > > +	return parent_rate * val;
> > > > +}
> > > > +
> > > > +static bool __is_best_rate(unsigned long rate, unsigned long new,
> > > > +			   unsigned long best, unsigned long flags)
> > > > +{
> > > > +	if (flags & CLK_MULTIPLIER_ROUND_CLOSEST)
> > > 
> > > Is the only difference in this function vs the divider one that
> > > flag? Maybe we should make this function generic to the framework
> > > and pass a flag indicating closest or not.
> > 
> > Actually, the logic is also reversed.
> > 
> > The divider driver will always try to find some rate that is higher
> > than the one we already have, without going above than the one
> > requested.
> > 
> > Here, we're tring to be lower than the best rate, without going below
> > the requested rate.
> 
> So then a tri-state flag that indicates, closest, less than,
> greater than?

Still, the computation itself is different, and the only consolidation
we could possibly do is by not duplicating the ROUND_CLOSEST. We would
end up with two different code pathes in the same function, which I
feel would make it unnecessarily complex.

> 
> > 
> > > 
> > > > +	unsigned long val;
> > > > +
> > > > +	if (mult->lock)
> > > > +		spin_lock_irqsave(mult->lock, flags);
> > > 
> > > This needs the same "trick" that we did in the generic clock
> > > types to avoid sparse warnings.
> > 
> > The __acquire call ?
> 
> Yes.

Ok.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151007/46995fa7/attachment.sig>
