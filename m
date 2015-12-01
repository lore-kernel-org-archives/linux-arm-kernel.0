From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Dec 2015 23:44:37 +0000
Subject: [PATCH v2 3/5] printk/nmi: Try hard to print Oops message in NMI
 context
In-Reply-To: <1448622572-16900-4-git-send-email-pmladek@suse.com>
References: <1448622572-16900-1-git-send-email-pmladek@suse.com>
 <1448622572-16900-4-git-send-email-pmladek@suse.com>
Message-ID: <20151201234437.GA8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 27, 2015 at 12:09:30PM +0100, Petr Mladek wrote:
> What we can do, though, is to zap all printk locks. We already do this
> when a printk recursion is detected. This should be safe because
> the system is crashing and there shouldn't be any printk caller
> that would cause the deadlock.

What about serial consoles which may call out to subsystems like the
clk subsystem to enable a clock, which would want to take their own
spinlocks in addition to the serial console driver?

I don't see bust_spinlocks() dealing with any of these locks, so IMHO
trying to make this work in NMI context strikes me as making the
existing solution more unreliable on ARM systems.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
