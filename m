From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 May 2011 20:04:22 +0100
Subject: [RFC PATCH 08/12] ARM: msm: use remapped PPI interrupts for
	local timer
In-Reply-To: <4DB6FD50.9070907@codeaurora.org>
References: <1303326501-15664-1-git-send-email-marc.zyngier@arm.com>
	<1303326501-15664-9-git-send-email-marc.zyngier@arm.com>
	<4DB6FD50.9070907@codeaurora.org>
Message-ID: <20110503190422.GA14176@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 26, 2011 at 10:13:52AM -0700, Stephen Boyd wrote:
> Why do we need to call local_timer_setup() on each CPU up though? It
> would be nice to be able to just add local timers for all possible CPUs
> at boot time and then have the clockevents core take care of enabling
> and disabling the events as appropriate without ARM code forcing the
> events to be UNUSED and then re-adding the events back on CPU up. I'm
> probably missing something really obvious here.

Firstly, because you can't access the local timer registers from non-
local CPUs.  Secondly, when you offline a CPU, generic code unregisters
the local timer, so whenever you online a CPU you have to add its local
timer clockevent back again.

Thirdly, you may have a system where the local timer gets powered down
when a CPU is offlined, and so it would need reinitialization when you
online it again.
