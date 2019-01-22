Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBD6C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:35:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F59720879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BboTZLW3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F59720879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=tty+ZmBRP1fV3xfEOs/jIvwuJFDzWlK/ZhtI6CR3Euw=; b=Bbo
	TZLW3fR7vHInvkT8vNg8oU93Ic9rGDho06HPTne6FVQWw7mS35ZLDTPKGqXGh9qbM8EfO5/GP4V/c
	+pwomH6PdwenO2mNWIJVjs4F0sGT4RkCjOvtk4HQK7U4xU365vhm006sDtSIPhP5ziK96/3mAH26I
	Xpsm81z0LiZ8KUJ7V+5mvW6ZsDOTW2PABL9BC7/Ac+n9ctFsxwkSaotNSpotT0uTPRHvabi18FQij
	4J5ga5avlHd+E7pZuR0bEtjBPeQN6yTTKq5sCShYPVkfi1iNl7QQm+fzOaYdsKszK9i4GrS3au7dH
	YW9Eob3cNG638fiQY3HdPseLK+lZUXA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gluLE-0002P6-QF; Tue, 22 Jan 2019 11:35:40 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gluLB-0002Of-R7
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 11:35:39 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19A78A78;
 Tue, 22 Jan 2019 03:35:36 -0800 (PST)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B6F4B3F6A8;
 Tue, 22 Jan 2019 03:35:34 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	ARM SoC Team <arm@kernel.org>
Subject: [PATCH] firmware: arm_scmi: provide the mandatory device release
 callback
Date: Tue, 22 Jan 2019 11:35:25 +0000
Message-Id: <20190122113525.13705-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_033537_885142_D87F53A2 
X-CRM114-Status: GOOD (  11.18  )
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
Cc: Olof Johansson <olof@lixom.net>, Kevin Hilman <khilman@linaro.org>,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Sudeep Holla <sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The device/driver model clearly mandates that bus driver that discover
and allocate the device must set the release callback. This callback
will be used to free the device after all references have gone away.

scmi bus driver is missing the obvious callback which will result in
the following warning if the device is unregistered:

Device 'scmi_dev.1' does not have a release() function, it is broken and
must be fixed. See Documentation/kobject.txt.
WARNING at drivers/base/core.c:922 device_release+0x8c/0xa0
Hardware name: ARM LTD Juno Development Platform BIOS EDK II Jan 21 2019
Workqueue: events deferred_probe_work_func
pstate: 60000005 (nZCv daif -PAN -UAO)
pc : device_release+0x8c/0xa0
lr : device_release+0x8c/0xa0
Call trace:
 device_release+0x8c/0xa0
 kobject_put+0x8c/0x208
 device_unregister+0x30/0x78
 scmi_device_destroy+0x28/0x50
 scmi_probe+0x354/0x5b0
 platform_drv_probe+0x58/0xa8
 really_probe+0x2c4/0x3e8
 driver_probe_device+0x12c/0x148
 __device_attach_driver+0xac/0x150
 bus_for_each_drv+0x78/0xd8
 __device_attach+0xe0/0x168
 device_initial_probe+0x24/0x30
 bus_probe_device+0xa0/0xa8
 deferred_probe_work_func+0x8c/0xe0
 process_one_work+0x1f0/0x478
 worker_thread+0x22c/0x450
 kthread+0x134/0x138
 ret_from_fork+0x10/0x1c
---[ end trace 420bdb7f6af50937 ]---

Fix the issue by providing scmi_device_release callback. We have
everything required for device release already in scmi_device_destroy,
so we just need to move freeing of the device to scmi_device_release.

Fixes: 933c504424a2 ("firmware: arm_scmi: add scmi protocol bus to enumerate protocol devices")
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/bus.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

Hi ARM-SoC team,

Can you apply this one patch directly or I can send pull request if you
prefer ?

Regards,
Sudeep

diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index 472c88ae1c0f..92f843eaf1e0 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -119,6 +119,11 @@ void scmi_driver_unregister(struct scmi_driver *driver)
 }
 EXPORT_SYMBOL_GPL(scmi_driver_unregister);

+static void scmi_device_release(struct device *dev)
+{
+	kfree(to_scmi_dev(dev));
+}
+
 struct scmi_device *
 scmi_device_create(struct device_node *np, struct device *parent, int protocol)
 {
@@ -138,6 +143,7 @@ scmi_device_create(struct device_node *np, struct device *parent, int protocol)
 	scmi_dev->dev.parent = parent;
 	scmi_dev->dev.of_node = np;
 	scmi_dev->dev.bus = &scmi_bus_type;
+	scmi_dev->dev.release = scmi_device_release;
 	dev_set_name(&scmi_dev->dev, "scmi_dev.%d", id);

 	retval = device_register(&scmi_dev->dev);
@@ -156,9 +162,8 @@ scmi_device_create(struct device_node *np, struct device *parent, int protocol)
 void scmi_device_destroy(struct scmi_device *scmi_dev)
 {
 	scmi_handle_put(scmi_dev->handle);
-	device_unregister(&scmi_dev->dev);
 	ida_simple_remove(&scmi_bus_id, scmi_dev->id);
-	kfree(scmi_dev);
+	device_unregister(&scmi_dev->dev);
 }

 void scmi_set_handle(struct scmi_device *scmi_dev)
--
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
