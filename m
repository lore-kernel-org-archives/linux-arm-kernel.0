Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E980C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 04:42:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04465218CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 04:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KisLwLxj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04465218CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=X4T/ri+TGRik/YjV5+90598hjSPXpm6Cs87qx4Lken8=; b=KisLwLxjQxduLzGVoq4+afgvvd
	48PZ6zqOzsNEuMHsCxA2ip/z9kZxTfRH+TYZ7ZNonJMgH+dCCq3Um1gJTeqIBZrQImYIlsQ9axp4W
	gq0uOVFEwTjFSPBeqQk5LUeYxHKPSeHjSOFiYRj/xZb1dfuU2IMMWOPmydWyJ0axoY4pMIRQJdNel
	ioleDu7ooMQS2/l9ib/fxEKRGuMOgkS2YKCmZ+YhA1uJ2C5Ce3YpehPsam1djnTFP7Bgoddl2rp0S
	kcLEaTHOhP6d61w7Q3Yreawm+XMhlxBQiYo2KTPHAKy1MxqWQo5LZV/rhLmX/CVRBNGAlnj7DtHd8
	yB9JpMfA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyr3O-0007Ic-RV; Wed, 27 Feb 2019 04:42:47 +0000
Received: from out1.zte.com.cn ([202.103.147.172] helo=mxct.zte.com.cn)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyr1n-00055x-1I; Wed, 27 Feb 2019 04:41:15 +0000
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
 by Forcepoint Email with ESMTPS id 8E9CD2854E3034C164C2;
 Wed, 27 Feb 2019 12:41:05 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
 by mse01.zte.com.cn with ESMTP id x1R4etdZ003794;
 Wed, 27 Feb 2019 12:40:55 +0800 (GMT-8)
 (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
 by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
 with ESMTP id 2019022712411629-2029149 ;
 Wed, 27 Feb 2019 12:41:16 +0800 
From: Wen Yang <wen.yang99@zte.com.cn>
To: benh@kernel.crashing.org
Subject: [PATCH 8/8] PCI: rpadlpar: fix a leaked reference by adding missing
 of_node_put
Date: Wed, 27 Feb 2019 12:40:43 +0800
Message-Id: <1551242443-27300-8-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1551242443-27300-1-git-send-email-wen.yang99@zte.com.cn>
References: <1551242443-27300-1-git-send-email-wen.yang99@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release
 8.5.3FP6|November 21, 2013) at 2019-02-27 12:41:16,
 Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-02-27 12:40:48, Serialize complete at 2019-02-27 12:40:48
X-MAIL: mse01.zte.com.cn x1R4etdZ003794
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_204107_925882_070530DA 
X-CRM114-Status: UNSURE (   9.85  )
X-CRM114-Notice: Please train this message.
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
Cc: heiko@sntech.de, hayashi.kunihiko@socionext.com, linux-pci@vger.kernel.org,
 shawn.lin@rock-chips.com, minghuan.Lian@nxp.com, paulus@samba.org,
 thomas.petazzoni@bootlin.com, Wen Yang <wen.yang99@zte.com.cn>,
 ryder.lee@mediatek.com, mpe@ellerman.id.au, kishon@ti.com,
 linux-rockchip@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com,
 linux-arm-kernel@lists.infradead.org, wang.yi59@zte.com.cn, rjui@broadcom.com,
 lorenzo.pieralisi@arm.com, linux-mediatek@lists.infradead.org,
 tyreld@linux.vnet.ibm.com, matthias.bgg@gmail.com, linux-omap@vger.kernel.org,
 mingkai.hu@nxp.com, roy.zang@nxp.com, sbranden@broadcom.com,
 yamada.masahiro@socionext.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, bhelgaas@google.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The call to of_find_node_by_name returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with the following warnings:
./drivers/pci/hotplug/rpadlpar_core.c:55:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 42, but without a corresponding object release within this function

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/pci/hotplug/rpadlpar_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
index e2356a9..f3f42ff 100644
--- a/drivers/pci/hotplug/rpadlpar_core.c
+++ b/drivers/pci/hotplug/rpadlpar_core.c
@@ -52,6 +52,7 @@ static struct device_node *find_vio_slot_node(char *drc_name)
 			break;
 	}
 
+	of_node_put(parent);
 	return dn;
 }
 
-- 
2.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
