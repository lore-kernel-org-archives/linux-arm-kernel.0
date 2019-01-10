Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4C0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:00:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05E232064C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NHbQfX/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05E232064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=R4b9mxRgU6zMDbUZZcEWYE4879Q3/B0yYgT2ySo0DwU=; b=NHbQfX/yNVhJb3
	/mk4TY2oRR2FqspxZ6Sa9ga+u+y0L/DVDsUa3jEyVyAvbDhmtvcOIlik5qm6Za9cOXFeL2LLJ0pRP
	GEZNpSa00gzVV8Q9PZXgaMknmdjOeKkoR16ZXY1iCkaloLnau0OdqJUT3ocNaH3J1xOnLSvNvPpSd
	HLVBi+ldxly3oWVZ5osmcKMNCsx4Y5vS3g3Mfpx9c/KSNPRt39IMs86QiWjL7VMi2ErGZPpPZDZur
	G7SnIf3IIFt2mKrj0eXifZgDjcT8fEEXs7I1q7/kJpXSkQj6S5IqMkNc1Y3ZO5VzwK7aXcEodDYRi
	Vt8wTUtawXczQ7mAALZw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghed9-0003Vv-Ev; Thu, 10 Jan 2019 18:00:35 +0000
Received: from shell.v3.sk ([90.176.6.54])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghebr-0000vM-T4
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 17:59:20 +0000
Received: from localhost (localhost [127.0.0.1])
 by zimbra.v3.sk (Postfix) with ESMTP id 5D0A91002F7;
 Thu, 10 Jan 2019 18:59:14 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
 by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id V2V5FkdbsMUa; Thu, 10 Jan 2019 18:59:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zimbra.v3.sk (Postfix) with ESMTP id A0E371002F1;
 Thu, 10 Jan 2019 18:58:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
 by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id Rb5ZxAFT41BB; Thu, 10 Jan 2019 18:58:54 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com
 [213.175.37.10])
 by zimbra.v3.sk (Postfix) with ESMTPSA id C203E1002F5;
 Thu, 10 Jan 2019 18:58:53 +0100 (CET)
From: Lubomir Rintel <lkundrak@v3.sk>
To: Andy Shevchenko <andy@infradead.org>,
	Darren Hart <dvhart@infradead.org>
Subject: [PATCH v5 03/10] Platform: OLPC: Move EC-specific functionality out
 from x86
Date: Thu, 10 Jan 2019 18:58:38 +0100
Message-Id: <20190110175845.1203986-4-lkundrak@v3.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190110175845.1203986-1-lkundrak@v3.sk>
References: <20190110175845.1203986-1-lkundrak@v3.sk>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_095916_733311_C4A184C1 
X-CRM114-Status: GOOD (  22.89  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, platform-driver-x86@vger.kernel.org,
 Lubomir Rintel <lkundrak@v3.sk>, Rob Herring <robh+dt@kernel.org>,
 Pavel Machek <pavel@ucw.cz>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Move the olpc-ec driver away from the X86 OLPC platform so that it could be
used by the ARM based laptops too. Notably, the driver for the OLPC battery,
which is also used on the ARM models, builds on this driver's interface.

It is actually plaform independent: the OLPC EC commands with their argument
and responses are mostly the same despite the delivery mechanism is
different.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>

---
Changes since v4:
- A whitespace fix
- s/unisgned char ec_byte/u8 ec_byte/

Changes since v1:
- Cosmetic changes in line wrapping.
- Remove an old extra copy of EC_SCI_* defines
- Change version to u8
- Explain which parts are platform independent are in the commit message

 arch/x86/include/asm/olpc.h         |  31 --------
 arch/x86/platform/olpc/olpc.c       | 119 +++++-----------------------
 drivers/platform/olpc/olpc-ec.c     |  99 ++++++++++++++++++++++-
 drivers/power/supply/olpc_battery.c |   1 -
 include/linux/olpc-ec.h             |  32 +++++++-
 5 files changed, 145 insertions(+), 137 deletions(-)

diff --git a/arch/x86/include/asm/olpc.h b/arch/x86/include/asm/olpc.h
index c2bf1de5d901..6fe76282aceb 100644
--- a/arch/x86/include/asm/olpc.h
+++ b/arch/x86/include/asm/olpc.h
@@ -9,12 +9,10 @@
 struct olpc_platform_t {
 	int flags;
 	uint32_t boardrev;
-	int ecver;
 };
 
 #define OLPC_F_PRESENT		0x01
 #define OLPC_F_DCON		0x02
-#define OLPC_F_EC_WIDE_SCI	0x04
 
 #ifdef CONFIG_OLPC
 
@@ -64,13 +62,6 @@ static inline int olpc_board_at_least(uint32_t rev)
 	return olpc_platform_info.boardrev >= rev;
 }
 
-extern void olpc_ec_wakeup_set(u16 value);
-extern void olpc_ec_wakeup_clear(u16 value);
-extern bool olpc_ec_wakeup_available(void);
-
-extern int olpc_ec_mask_write(u16 bits);
-extern int olpc_ec_sci_query(u16 *sci_value);
-
 #else
 
 static inline int machine_is_olpc(void)
@@ -83,14 +74,6 @@ static inline int olpc_has_dcon(void)
 	return 0;
 }
 
-static inline void olpc_ec_wakeup_set(u16 value) { }
-static inline void olpc_ec_wakeup_clear(u16 value) { }
-
-static inline bool olpc_ec_wakeup_available(void)
-{
-	return false;
-}
-
 #endif
 
 #ifdef CONFIG_OLPC_XO1_PM
@@ -101,20 +84,6 @@ extern void olpc_xo1_pm_wakeup_clear(u16 value);
 
 extern int pci_olpc_init(void);
 
-/* SCI source values */
-
-#define EC_SCI_SRC_EMPTY	0x00
-#define EC_SCI_SRC_GAME		0x01
-#define EC_SCI_SRC_BATTERY	0x02
-#define EC_SCI_SRC_BATSOC	0x04
-#define EC_SCI_SRC_BATERR	0x08
-#define EC_SCI_SRC_EBOOK	0x10	/* XO-1 only */
-#define EC_SCI_SRC_WLAN		0x20	/* XO-1 only */
-#define EC_SCI_SRC_ACPWR	0x40
-#define EC_SCI_SRC_BATCRIT	0x80
-#define EC_SCI_SRC_GPWAKE	0x100	/* XO-1.5 only */
-#define EC_SCI_SRC_ALL		0x1FF
-
 /* GPIO assignments */
 
 #define OLPC_GPIO_MIC_AC	1
diff --git a/arch/x86/platform/olpc/olpc.c b/arch/x86/platform/olpc/olpc.c
index f0e920fb98ad..c6c62b4f251f 100644
--- a/arch/x86/platform/olpc/olpc.c
+++ b/arch/x86/platform/olpc/olpc.c
@@ -30,9 +30,6 @@
 struct olpc_platform_t olpc_platform_info;
 EXPORT_SYMBOL_GPL(olpc_platform_info);
 
-/* EC event mask to be applied during suspend (defining wakeup sources). */
-static u16 ec_wakeup_mask;
-
 /* what the timeout *should* be (in ms) */
 #define EC_BASE_TIMEOUT 20
 
@@ -186,83 +183,6 @@ static int olpc_xo1_ec_cmd(u8 cmd, u8 *inbuf, size_t inlen, u8 *outbuf,
 	return ret;
 }
 
-void olpc_ec_wakeup_set(u16 value)
-{
-	ec_wakeup_mask |= value;
-}
-EXPORT_SYMBOL_GPL(olpc_ec_wakeup_set);
-
-void olpc_ec_wakeup_clear(u16 value)
-{
-	ec_wakeup_mask &= ~value;
-}
-EXPORT_SYMBOL_GPL(olpc_ec_wakeup_clear);
-
-/*
- * Returns true if the compile and runtime configurations allow for EC events
- * to wake the system.
- */
-bool olpc_ec_wakeup_available(void)
-{
-	if (!machine_is_olpc())
-		return false;
-
-	/*
-	 * XO-1 EC wakeups are available when olpc-xo1-sci driver is
-	 * compiled in
-	 */
-#ifdef CONFIG_OLPC_XO1_SCI
-	if (olpc_platform_info.boardrev < olpc_board_pre(0xd0)) /* XO-1 */
-		return true;
-#endif
-
-	/*
-	 * XO-1.5 EC wakeups are available when olpc-xo15-sci driver is
-	 * compiled in
-	 */
-#ifdef CONFIG_OLPC_XO15_SCI
-	if (olpc_platform_info.boardrev >= olpc_board_pre(0xd0)) /* XO-1.5 */
-		return true;
-#endif
-
-	return false;
-}
-EXPORT_SYMBOL_GPL(olpc_ec_wakeup_available);
-
-int olpc_ec_mask_write(u16 bits)
-{
-	if (olpc_platform_info.flags & OLPC_F_EC_WIDE_SCI) {
-		__be16 ec_word = cpu_to_be16(bits);
-		return olpc_ec_cmd(EC_WRITE_EXT_SCI_MASK, (void *) &ec_word, 2,
-				   NULL, 0);
-	} else {
-		unsigned char ec_byte = bits & 0xff;
-		return olpc_ec_cmd(EC_WRITE_SCI_MASK, &ec_byte, 1, NULL, 0);
-	}
-}
-EXPORT_SYMBOL_GPL(olpc_ec_mask_write);
-
-int olpc_ec_sci_query(u16 *sci_value)
-{
-	int ret;
-
-	if (olpc_platform_info.flags & OLPC_F_EC_WIDE_SCI) {
-		__be16 ec_word;
-		ret = olpc_ec_cmd(EC_EXT_SCI_QUERY,
-			NULL, 0, (void *) &ec_word, 2);
-		if (ret == 0)
-			*sci_value = be16_to_cpu(ec_word);
-	} else {
-		unsigned char ec_byte;
-		ret = olpc_ec_cmd(EC_SCI_QUERY, NULL, 0, &ec_byte, 1);
-		if (ret == 0)
-			*sci_value = ec_byte;
-	}
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(olpc_ec_sci_query);
-
 static bool __init check_ofw_architecture(struct device_node *root)
 {
 	const char *olpc_arch;
@@ -296,6 +216,10 @@ static bool __init platform_detect(void)
 	if (success) {
 		olpc_platform_info.boardrev = get_board_revision(root);
 		olpc_platform_info.flags |= OLPC_F_PRESENT;
+
+		pr_info("OLPC board revision %s%X\n",
+			((olpc_platform_info.boardrev & 0xf) < 8) ? "pre" : "",
+			olpc_platform_info.boardrev >> 4);
 	}
 
 	of_node_put(root);
@@ -315,27 +239,8 @@ static int __init add_xo1_platform_devices(void)
 	return PTR_ERR_OR_ZERO(pdev);
 }
 
-static int olpc_xo1_ec_probe(struct platform_device *pdev)
-{
-	/* get the EC revision */
-	olpc_ec_cmd(EC_FIRMWARE_REV, NULL, 0,
-			(unsigned char *) &olpc_platform_info.ecver, 1);
-
-	/* EC version 0x5f adds support for wide SCI mask */
-	if (olpc_platform_info.ecver >= 0x5f)
-		olpc_platform_info.flags |= OLPC_F_EC_WIDE_SCI;
-
-	pr_info("OLPC board revision %s%X (EC=%x)\n",
-			((olpc_platform_info.boardrev & 0xf) < 8) ? "pre" : "",
-			olpc_platform_info.boardrev >> 4,
-			olpc_platform_info.ecver);
-
-	return 0;
-}
 static int olpc_xo1_ec_suspend(struct platform_device *pdev)
 {
-	olpc_ec_mask_write(ec_wakeup_mask);
-
 	/*
 	 * Squelch SCIs while suspended.  This is a fix for
 	 * <http://dev.laptop.org/ticket/1835>.
@@ -359,15 +264,27 @@ static int olpc_xo1_ec_resume(struct platform_device *pdev)
 }
 
 static struct olpc_ec_driver ec_xo1_driver = {
-	.probe = olpc_xo1_ec_probe,
 	.suspend = olpc_xo1_ec_suspend,
 	.resume = olpc_xo1_ec_resume,
 	.ec_cmd = olpc_xo1_ec_cmd,
+#ifdef CONFIG_OLPC_XO1_SCI
+	/*
+	 * XO-1 EC wakeups are available when olpc-xo1-sci driver is
+	 * compiled in
+	 */
+	.wakeup_available = true,
+#endif
 };
 
 static struct olpc_ec_driver ec_xo1_5_driver = {
-	.probe = olpc_xo1_ec_probe,
 	.ec_cmd = olpc_xo1_ec_cmd,
+#ifdef CONFIG_OLPC_XO1_5_SCI
+	/*
+	 * XO-1.5 EC wakeups are available when olpc-xo15-sci driver is
+	 * compiled in
+	 */
+	.wakeup_available = true,
+#endif
 };
 
 static int __init olpc_init(void)
diff --git a/drivers/platform/olpc/olpc-ec.c b/drivers/platform/olpc/olpc-ec.c
index 981955dce926..2a647455a368 100644
--- a/drivers/platform/olpc/olpc-ec.c
+++ b/drivers/platform/olpc/olpc-ec.c
@@ -32,6 +32,7 @@ struct ec_cmd_desc {
 
 struct olpc_ec_priv {
 	struct olpc_ec_driver *drv;
+	u8 version;
 	struct work_struct worker;
 	struct mutex cmd_lock;
 
@@ -41,6 +42,12 @@ struct olpc_ec_priv {
 
 	struct dentry *dbgfs_dir;
 
+	/*
+	 * EC event mask to be applied during suspend (defining wakeup
+	 * sources).
+	 */
+	u16 ec_wakeup_mask;
+
 	/*
 	 * Running an EC command while suspending means we don't always finish
 	 * the command before the machine suspends.  This means that the EC
@@ -149,6 +156,88 @@ int olpc_ec_cmd(u8 cmd, u8 *inbuf, size_t inlen, u8 *outbuf, size_t outlen)
 }
 EXPORT_SYMBOL_GPL(olpc_ec_cmd);
 
+void olpc_ec_wakeup_set(u16 value)
+{
+	struct olpc_ec_priv *ec = ec_priv;
+
+	if (WARN_ON(!ec))
+		return;
+
+	ec->ec_wakeup_mask |= value;
+}
+EXPORT_SYMBOL_GPL(olpc_ec_wakeup_set);
+
+void olpc_ec_wakeup_clear(u16 value)
+{
+	struct olpc_ec_priv *ec = ec_priv;
+
+	if (WARN_ON(!ec))
+		return;
+
+	ec->ec_wakeup_mask &= ~value;
+}
+EXPORT_SYMBOL_GPL(olpc_ec_wakeup_clear);
+
+int olpc_ec_mask_write(u16 bits)
+{
+	struct olpc_ec_priv *ec = ec_priv;
+
+	if (WARN_ON(!ec))
+		return -ENODEV;
+
+	/* EC version 0x5f adds support for wide SCI mask */
+	if (ec->version >= 0x5f) {
+		__be16 ec_word = cpu_to_be16(bits);
+
+		return olpc_ec_cmd(EC_WRITE_EXT_SCI_MASK, (void *)&ec_word, 2, NULL, 0);
+	} else {
+		u8 ec_byte = bits & 0xff;
+
+		return olpc_ec_cmd(EC_WRITE_SCI_MASK, &ec_byte, 1, NULL, 0);
+	}
+}
+EXPORT_SYMBOL_GPL(olpc_ec_mask_write);
+
+/*
+ * Returns true if the compile and runtime configurations allow for EC events
+ * to wake the system.
+ */
+bool olpc_ec_wakeup_available(void)
+{
+	if (WARN_ON(!ec_driver))
+		return false;
+
+	return ec_driver->wakeup_available;
+}
+EXPORT_SYMBOL_GPL(olpc_ec_wakeup_available);
+
+int olpc_ec_sci_query(u16 *sci_value)
+{
+	struct olpc_ec_priv *ec = ec_priv;
+	int ret;
+
+	if (WARN_ON(!ec))
+		return -ENODEV;
+
+	/* EC version 0x5f adds support for wide SCI mask */
+	if (ec->version >= 0x5f) {
+		__be16 ec_word;
+
+		ret = olpc_ec_cmd(EC_EXT_SCI_QUERY, NULL, 0, (void *)&ec_word, 2);
+		if (ret == 0)
+			*sci_value = be16_to_cpu(ec_word);
+	} else {
+		u8 ec_byte;
+
+		ret = olpc_ec_cmd(EC_SCI_QUERY, NULL, 0, &ec_byte, 1);
+		if (ret == 0)
+			*sci_value = ec_byte;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(olpc_ec_sci_query);
+
 #ifdef CONFIG_DEBUG_FS
 
 /*
@@ -276,14 +365,16 @@ static int olpc_ec_probe(struct platform_device *pdev)
 	ec_priv = ec;
 	platform_set_drvdata(pdev, ec);
 
-	err = ec_driver->probe ? ec_driver->probe(pdev) : 0;
+	/* get the EC revision */
+	err = olpc_ec_cmd(EC_FIRMWARE_REV, NULL, 0, &ec->version, 1);
 	if (err) {
 		ec_priv = NULL;
 		kfree(ec);
-	} else {
-		ec->dbgfs_dir = olpc_ec_setup_debugfs();
+		return err;
 	}
 
+	ec->dbgfs_dir = olpc_ec_setup_debugfs();
+
 	return err;
 }
 
@@ -293,6 +384,8 @@ static int olpc_ec_suspend(struct device *dev)
 	struct olpc_ec_priv *ec = platform_get_drvdata(pdev);
 	int err = 0;
 
+	olpc_ec_mask_write(ec->ec_wakeup_mask);
+
 	if (ec_driver->suspend)
 		err = ec_driver->suspend(pdev);
 	if (!err)
diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/olpc_battery.c
index 5a97e42a3547..6dba55562203 100644
--- a/drivers/power/supply/olpc_battery.c
+++ b/drivers/power/supply/olpc_battery.c
@@ -19,7 +19,6 @@
 #include <linux/jiffies.h>
 #include <linux/sched.h>
 #include <linux/olpc-ec.h>
-#include <asm/olpc.h>
 
 
 #define EC_BAT_VOLTAGE	0x10	/* uint16_t,	*9.76/32,    mV   */
diff --git a/include/linux/olpc-ec.h b/include/linux/olpc-ec.h
index 79bdc6328c52..7fa3d27f7fee 100644
--- a/include/linux/olpc-ec.h
+++ b/include/linux/olpc-ec.h
@@ -16,14 +16,28 @@
 #define EC_SCI_QUERY			0x84
 #define EC_EXT_SCI_QUERY		0x85
 
+/* SCI source values */
+#define EC_SCI_SRC_EMPTY        0x00
+#define EC_SCI_SRC_GAME         0x01
+#define EC_SCI_SRC_BATTERY      0x02
+#define EC_SCI_SRC_BATSOC       0x04
+#define EC_SCI_SRC_BATERR       0x08
+#define EC_SCI_SRC_EBOOK        0x10    /* XO-1 only */
+#define EC_SCI_SRC_WLAN         0x20    /* XO-1 only */
+#define EC_SCI_SRC_ACPWR        0x40
+#define EC_SCI_SRC_BATCRIT      0x80
+#define EC_SCI_SRC_GPWAKE       0x100   /* XO-1.5 only */
+#define EC_SCI_SRC_ALL          0x1FF
+
 struct platform_device;
 
 struct olpc_ec_driver {
-	int (*probe)(struct platform_device *);
 	int (*suspend)(struct platform_device *);
 	int (*resume)(struct platform_device *);
 
 	int (*ec_cmd)(u8, u8 *, size_t, u8 *, size_t, void *);
+
+	bool wakeup_available;
 };
 
 #ifdef CONFIG_OLPC
@@ -33,11 +47,27 @@ extern void olpc_ec_driver_register(struct olpc_ec_driver *drv, void *arg);
 extern int olpc_ec_cmd(u8 cmd, u8 *inbuf, size_t inlen, u8 *outbuf,
 		size_t outlen);
 
+extern void olpc_ec_wakeup_set(u16 value);
+extern void olpc_ec_wakeup_clear(u16 value);
+
+extern int olpc_ec_mask_write(u16 bits);
+extern int olpc_ec_sci_query(u16 *sci_value);
+
+extern bool olpc_ec_wakeup_available(void);
+
 #else
 
 static inline int olpc_ec_cmd(u8 cmd, u8 *inbuf, size_t inlen, u8 *outbuf,
 		size_t outlen) { return -ENODEV; }
 
+static inline void olpc_ec_wakeup_set(u16 value) { }
+static inline void olpc_ec_wakeup_clear(u16 value) { }
+
+static inline bool olpc_ec_wakeup_available(void)
+{
+	return false;
+}
+
 #endif /* CONFIG_OLPC */
 
 #endif /* _LINUX_OLPC_EC_H */
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
