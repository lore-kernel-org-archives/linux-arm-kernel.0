From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 11 Feb 2014 15:43:07 +0000
Subject: [PATCH] ARM: mm: add imprecise abort non-deadly handler
In-Reply-To: <52F90B7B.50807@codethink.co.uk>
References: <1391797214-17142-1-git-send-email-ben.dooks@codethink.co.uk>
 <1391797214-17142-2-git-send-email-ben.dooks@codethink.co.uk>
 <20140210143708.GB2794@e103592.cambridge.arm.com>
 <52F90B7B.50807@codethink.co.uk>
Message-ID: <20140211154307.GB3035@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 10, 2014 at 05:25:15PM +0000, Ben Dooks wrote:
> On 10/02/14 14:37, Dave Martin wrote:

[...]

> >"Spurious" imprecise aborts pretty much always indicate a hardware error
> >or a nasty bug somewhere.
> 
> I need to find out where the one we are catching is coming from in our
> system.

Would certainly be good to know...

> >Another cause is badly implemented, buggy or malicious userspace software
> >being given more exotic mmaps that it is qualified to deal with
> >responsibly.  That's a nasty bug in the distro maintainer / system
> >administrator / vendor.
> >
> >So, I think this should be at least KERN_ERROR; maybe KERN_CRIT or above.
> >We must not encourage people to think that these aborts are somehow
> >benign.
> 
> Ok, KERN_ERROR or KERN_CRIT sound reasonable.
> 
> >If we really want people to fix their bugs, it may be worth considering
> >panic(), or doing this when some threshold is reached.  This may be a
> >bit harsh though, at least without some threshold.
> 
> I was considering also firing a WARN_ON(abort_count++ > 10) or something
> similar.

Maybe WARN_ON the first such abort, and ratelimit somehow after?

Being noisy is good -- it's just killing a random, possibly-innocent task
that's not so good.

Cheers
---Dave
