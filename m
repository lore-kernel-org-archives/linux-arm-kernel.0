From: horms@verge.net.au (Simon Horman)
Date: Thu, 27 Jul 2017 21:53:12 +0200
Subject: [PATCH] ARM: shmobile: rcar-gen2: Fix deadlock in regulator quirk
In-Reply-To: <1499870720-30390-1-git-send-email-geert+renesas@glider.be>
References: <1499870720-30390-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20170727195307.GA2834@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 12, 2017 at 04:45:20PM +0200, Geert Uytterhoeven wrote:
> Simon Horman reported that Koelsch and Lager hang during boot, and
> bisected this to commit 1c3c5eab171590f8 ("sched/core: Enable
> might_sleep() and smp_processor_id() checks early").
> 
> The da9063/da9210 regulator quirk for R-Car Gen2 boards uses a bus
> notifier, and unregisters the notifier when it is no longer needed.
> However, a notifier must not be unregistered from within the call chain.
> 
> This bug went unnoticed, as blocking_notifier_chain_unregister() didn't
> take the semaphore during early boot.  The aforementioned commit changed
> that behavior, leading to a deadlock.
> 
> Fix this by removing the call to bus_unregister_notifier(), and keeping
> local completion state instead.
> 
> Reported-by: Simon Horman <horms+renesas@verge.net.au>
> Fixes: 663fbb52159cca6f ("ARM: shmobile: R-Car Gen2: Add da9063/da9210 regulator quirk")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Sorry for the delay, I have applied this as a fix for v4.13.
