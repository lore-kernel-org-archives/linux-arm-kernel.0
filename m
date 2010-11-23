From: h-kanigeri2@ti.com (Hari Kanigeri)
Date: Tue, 23 Nov 2010 15:26:54 -0600
Subject: [PATCH v4 2/5] OMAP: mailbox: fix rx interrupt disable in omap4
In-Reply-To: <1290547617-16640-1-git-send-email-h-kanigeri2@ti.com>
References: <1290547617-16640-1-git-send-email-h-kanigeri2@ti.com>
Message-ID: <1290547617-16640-3-git-send-email-h-kanigeri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

disablign rx interrupt on omap4 is different than its pre-decessors.
The bit in OMAP4_MAILBOX_IRQENABLE_CLR should be set to disable the
interrupts instead of clearing the bit.

Defined rev field in mailbox structure to differentiate the mailbox
versions.

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 arch/arm/mach-omap2/mailbox.c             |    7 ++++++-
 arch/arm/plat-omap/include/plat/mailbox.h |    4 ++++
 arch/arm/plat-omap/mailbox.c              |    4 ++++
 3 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 42dbfa4..c32058d 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -195,7 +195,12 @@ static void omap2_mbox_disable_irq(struct omap_mbox *mbox,
 	struct omap_mbox2_priv *p = (struct omap_mbox2_priv *)mbox->priv;
 	u32 l, bit = (irq == IRQ_TX) ? p->notfull_bit : p->newmsg_bit;
 	l = mbox_read_reg(p->irqdisable);
-	l &= ~bit;
+
+	if (mbox->rev == OMAP_MBOX_IP_VERSION_2)
+		l |= bit;
+	else
+		l &= ~bit;
+
 	mbox_write_reg(l, p->irqdisable);
 }
 
diff --git a/arch/arm/plat-omap/include/plat/mailbox.h b/arch/arm/plat-omap/include/plat/mailbox.h
index 13f2ef3..1655c61 100644
--- a/arch/arm/plat-omap/include/plat/mailbox.h
+++ b/arch/arm/plat-omap/include/plat/mailbox.h
@@ -20,6 +20,9 @@ typedef int __bitwise omap_mbox_type_t;
 #define OMAP_MBOX_TYPE1 ((__force omap_mbox_type_t) 1)
 #define OMAP_MBOX_TYPE2 ((__force omap_mbox_type_t) 2)
 
+#define OMAP_MBOX_IP_LEGACY                    0x1
+#define OMAP_MBOX_IP_VERSION_2                 0x2
+
 struct omap_mbox_ops {
 	omap_mbox_type_t	type;
 	int		(*startup)(struct omap_mbox *mbox);
@@ -58,6 +61,7 @@ struct omap_mbox {
 	struct omap_mbox_ops	*ops;
 	struct device		*dev;
 	void			*priv;
+	int			rev;
 };
 
 int omap_mbox_msg_send(struct omap_mbox *, mbox_msg_t msg);
diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 48e161c..a1c6bd9 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -358,6 +358,10 @@ int omap_mbox_register(struct device *parent, struct omap_mbox **list)
 			ret = PTR_ERR(mbox->dev);
 			goto err_out;
 		}
+		if (cpu_is_omap44xx())
+			mbox->rev = OMAP_MBOX_IP_VERSION_2;
+		else
+			mbox->rev = OMAP_MBOX_IP_LEGACY;
 	}
 	return 0;
 
-- 
1.7.0
