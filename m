From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 Sep 2013 19:38:43 +0100
Subject: [PATCH] ASoC: kirkwood: simplify clock handling
In-Reply-To: <1380046355-7920-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1379951159-8294-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1380046355-7920-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20130924183843.GI12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 24, 2013 at 08:12:35PM +0200, Uwe Kleine-K?nig wrote:
> There is no need to not use extclk if it is identical to the main clk.
> The main motivation for this patch is dropping devm_clk_put which is
> used in a wrong way by all other users.

NAK.  There's patches around which switch this driver to always use
the external clock when it's available.  This patch prevents that
from happening because we no longer know whether it is the external
clock or not.

What we could do is just lose the reference to the second clock if
it turns out to be idential to the first - it'll get cleaned up if
the driver is unloaded anyway.  In other words, the call to
devm_clk_put() here can be viewed as merely an optimisation.
