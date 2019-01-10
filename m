Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898CCC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:01:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ECCD2064C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OzaPnXfl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ECCD2064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KWJPJbZ0agRwduk4GBZF1cL6mjRWBtPIKhKxkWntZ50=; b=OzaPnXfl4KDYZ2
	uB7yZwSrPWc7ZP7NSf+7KR8ED/1FcbtrMEOJq6sIF3DKwSPI1zjuXA/VtUZZStYvQTSxSHNBFwS85
	9BlCyL739v7oxzhigpL056N4NkVlLssswb8g+5qHYgVoubiU3Gj19NRC7tNr3C1jsgULfsmMCOnSc
	U5AQObaZlsYB+E4tdc+34Wzbs1nApI34ffYtz8Z4ZSSCKbdBfNQR0NBxWTTg/usPKGTUOF5zdx/yR
	U1yi8YZHGG8t+yi0Q7jKac8XhpeFxMFwh72Lvp0Hhxd65Q7CyqJhiaOnwqT00XicwyzxqwbGXkcZT
	ptpC8K6cc4H0cN6rVOXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghee3-0004TO-Ve; Thu, 10 Jan 2019 18:01:32 +0000
Received: from shell.v3.sk ([90.176.6.54])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gheby-00013U-GG
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 17:59:31 +0000
Received: from localhost (localhost [127.0.0.1])
 by zimbra.v3.sk (Postfix) with ESMTP id E88C61002F1;
 Thu, 10 Jan 2019 18:59:20 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
 by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id CjwEAdZ_cx2t; Thu, 10 Jan 2019 18:59:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zimbra.v3.sk (Postfix) with ESMTP id D67861002F0;
 Thu, 10 Jan 2019 18:59:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
 by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id goc6kLLtZsRL; Thu, 10 Jan 2019 18:58:59 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com
 [213.175.37.10])
 by zimbra.v3.sk (Postfix) with ESMTPSA id DD7B11002FF;
 Thu, 10 Jan 2019 18:58:55 +0100 (CET)
From: Lubomir Rintel <lkundrak@v3.sk>
To: Andy Shevchenko <andy@infradead.org>,
	Darren Hart <dvhart@infradead.org>
Subject: [PATCH v5 10/10] Platform: OLPC: Add restart support to XO-1.75 EC
 driver
Date: Thu, 10 Jan 2019 18:58:45 +0100
Message-Id: <20190110175845.1203986-11-lkundrak@v3.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190110175845.1203986-1-lkundrak@v3.sk>
References: <20190110175845.1203986-1-lkundrak@v3.sk>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_095923_324236_534A5A33 
X-CRM114-Status: GOOD (  12.02  )
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
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This hooks to arm_pm_restart instead od utilizing a restart handler
notifier, because the reboot dance on XO 1.75 needs to sleep (it pokes a
GPIO and waits for the EC to initiate the command transaction) and the
restart handler is called in atomic context. Sad.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v4:
- Split off from the driver.

 drivers/platform/olpc/Kconfig         |  2 +-
 drivers/platform/olpc/olpc-xo175-ec.c | 13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/olpc/Kconfig b/drivers/platform/olpc/Kconfig
index 858ac1d2290a..02b232c34444 100644
--- a/drivers/platform/olpc/Kconfig
+++ b/drivers/platform/olpc/Kconfig
@@ -4,7 +4,7 @@ config OLPC_EC
 
 config OLPC_XO175_EC
 	tristate "OLPC XO 1.75 Embedded Controller"
-	depends on ARCH_MMP || COMPILE_TEST
+	depends on ARM && (ARCH_MMP || COMPILE_TEST)
 	select SPI_SLAVE
 	select OLPC_EC
 	help
diff --git a/drivers/platform/olpc/olpc-xo175-ec.c b/drivers/platform/olpc/olpc-xo175-ec.c
index c3a176ce474d..74db06bacc44 100644
--- a/drivers/platform/olpc/olpc-xo175-ec.c
+++ b/drivers/platform/olpc/olpc-xo175-ec.c
@@ -23,6 +23,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/spi/spi.h>
+#include <asm/system_misc.h>
 
 struct ec_cmd_t {
 	u8 cmd;
@@ -578,6 +579,14 @@ static int olpc_xo175_ec_set_event_mask(unsigned int mask)
 	return olpc_ec_cmd(CMD_WRITE_EXT_SCI_MASK, args, 2, NULL, 0);
 }
 
+static void olpc_xo175_ec_restart(enum reboot_mode mode, const char *cmd)
+{
+	while (1) {
+		olpc_ec_cmd(CMD_POWER_CYCLE, NULL, 0, NULL, 0);
+		mdelay(1000);
+	}
+}
+
 static void olpc_xo175_ec_power_off(void)
 {
 	while (1) {
@@ -649,6 +658,8 @@ static int olpc_xo175_ec_remove(struct spi_device *spi)
 {
 	if (pm_power_off == olpc_xo175_ec_power_off)
 		pm_power_off = NULL;
+	if (arm_pm_restart == olpc_xo175_ec_restart)
+		arm_pm_restart = NULL;
 
 	spi_slave_abort(spi);
 
@@ -716,6 +727,8 @@ static int olpc_xo175_ec_probe(struct spi_device *spi)
 
 	if (pm_power_off == NULL)
 		pm_power_off = olpc_xo175_ec_power_off;
+	if (arm_pm_restart == NULL)
+		arm_pm_restart = olpc_xo175_ec_restart;
 
 	dev_info(&spi->dev, "OLPC XO-1.75 Embedded Controller driver\n");
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
