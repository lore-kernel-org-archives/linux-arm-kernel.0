From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 10 Feb 2014 14:37:08 +0000
Subject: [PATCH] ARM: mm: add imprecise abort non-deadly handler
In-Reply-To: <1391797214-17142-2-git-send-email-ben.dooks@codethink.co.uk>
References: <1391797214-17142-1-git-send-email-ben.dooks@codethink.co.uk>
 <1391797214-17142-2-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20140210143708.GB2794@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 07, 2014 at 06:20:14PM +0000, Ben Dooks wrote:
> Given that imprecise aborts may be delivered after the action that
> caused them (or even for non-cpu related activities such as bridge
> faults from a bus-master) it is possible that the wrong process is
> terminated as a result.
> 
> It is not know at this time in an SMP system which cores get notified
> of an imprecise external abort, we have yet to find the right details
> in the architecture reference manuals. This also means that killing
> the process is probably the wrong thing to do on reception of these aborts.
> 
> Add a handler to take and print imprecise aborts and allow the process
> to continue. This should ensure that the abort is shown but not kill
> the process that was running on the cpu core at the time.

Not treating these as thread-specific faults seems correct, since we
never have a way to map these aborts back to the culprit ... except that
there is a likelihood the culprit is still running when the abort fires.


"Spurious" imprecise aborts pretty much always indicate a hardware error
or a nasty bug somewhere.

Another cause is badly implemented, buggy or malicious userspace software
being given more exotic mmaps that it is qualified to deal with
responsibly.  That's a nasty bug in the distro maintainer / system
administrator / vendor.

So, I think this should be at least KERN_ERROR; maybe KERN_CRIT or above.
We must not encourage people to think that these aborts are somehow
benign.

If we really want people to fix their bugs, it may be worth considering
panic(), or doing this when some threshold is reached.  This may be a
bit harsh though, at least without some threshold.

Cheers
---Dave
