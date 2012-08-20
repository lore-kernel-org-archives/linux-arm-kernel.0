From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Aug 2012 09:57:20 +0100
Subject: restart callback not supposed to sleep?
In-Reply-To: <20120820082423.GJ2232@pengutronix.de>
References: <20120820082423.GJ2232@pengutronix.de>
Message-ID: <20120820085720.GQ18957@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 20, 2012 at 10:24:23AM +0200, Uwe Kleine-K?nig wrote:
> while triggering a reboot via sysrq on an ARM machine I saw a "BUG:
> sleeping function called from invalid context" message (details below).
> The reason is that the sysrq handler is calling the restart hook in irq
> context.

Correct - it's been the case for years that the restart hook is called
from atomic contexts (it's not only sysrq, but also softdog as well which
does this, as well as any system panic with panic timeout/panic-on-oops
enabled.)

You need to fix your platform restart hook.
