From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 27 May 2010 06:13:58 +0200
Subject: Controlling Driver Load Order
In-Reply-To: <AANLkTikj8yGSK5Ovud_k8f6jWloojqDJmQ_H6pD_IFgM@mail.gmail.com>
References: <AANLkTikzDvWakd7JW3DzTHinjS3dAlqzPx6K8V2qMDG7@mail.gmail.com>
	<AANLkTinkY8JYh44UOEPflBUDyQ2wat_AKShRjA3HPxrf@mail.gmail.com>
	<20100526235246.GA31068@pengutronix.de>
	<AANLkTikj8yGSK5Ovud_k8f6jWloojqDJmQ_H6pD_IFgM@mail.gmail.com>
Message-ID: <20100527041358.GA14070@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 26, 2010 at 06:39:13PM -0700, Robert Emanuele wrote:

> Still the framebuffer device would initialize first and it would lack
> having the i2c chips it needs ready.  That is the order I'm trying to
> straighten out.

Understood. Our pointers were probably not precise enough, sorry. Please try
this patch and give a Tested-by-tag if it solves your problems.

From: Wolfram Sang <w.sang@pengutronix.de>
Date: Thu, 27 May 2010 06:03:48 +0200
Subject: [PATCH] i2c-at91: use subsys_initcall() for early initialization

I2C needs to be available early, so other subsystems can access it.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Robert Emanuele <rob@emanuele.us>
Cc: Ben Dooks <ben-linux@fluff.org>
---

 drivers/i2c/busses/i2c-at91.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index 305c075..bea5794 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -313,13 +313,12 @@ static int __init at91_i2c_init(void)
 {
 	return platform_driver_register(&at91_i2c_driver);
 }
+subsys_initcall(at91_i2c_init);
 
 static void __exit at91_i2c_exit(void)
 {
 	platform_driver_unregister(&at91_i2c_driver);
 }
-
-module_init(at91_i2c_init);
 module_exit(at91_i2c_exit);
 
 MODULE_AUTHOR("Rick Bronson");


-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100527/0ac368f0/attachment.sig>
