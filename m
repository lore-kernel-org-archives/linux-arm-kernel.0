From: davem@davemloft.net (David Miller)
Date: Sat, 07 Jan 2012 12:22:31 -0800 (PST)
Subject: linux-next: net/smsc911x compile error on next-20120106
In-Reply-To: <CAAQ0ZWSRzUM2rdhfWDqang6Baat6x-gEso5hQGEkbOqFjM-sMQ@mail.gmail.com>
References: <CAAQ0ZWSRzUM2rdhfWDqang6Baat6x-gEso5hQGEkbOqFjM-sMQ@mail.gmail.com>
Message-ID: <20120107.122231.981626055647748882.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>
Date: Sat, 7 Jan 2012 13:55:41 +0800

> Hi Stephen, David,
> 
> I just ran into the following compile error when building
> next-20120106 with imx_v6_v7_defconfig.
> 

I just commited the following to fix this, thanks:

--------------------
smsc911x: Unconditionally include linux/smscphy.h in smsc911x.h

The energy detect enable/disable code in the driver uses some
register defines in this header unconditionally, so guarding
the smscphy.h header include with CONFIG_SMSC_PHY leads to
build failures in some configurations.

Reported-by: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/net/ethernet/smsc/smsc911x.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/smsc/smsc911x.h b/drivers/net/ethernet/smsc/smsc911x.h
index 938ecf2..9ad5e5d 100644
--- a/drivers/net/ethernet/smsc/smsc911x.h
+++ b/drivers/net/ethernet/smsc/smsc911x.h
@@ -401,8 +401,6 @@
 #include <asm/smsc911x.h>
 #endif
 
-#ifdef CONFIG_SMSC_PHY
 #include <linux/smscphy.h>
-#endif
 
 #endif				/* __SMSC911X_H__ */
-- 
1.7.6.5
