Return-Path: <SRS0=N/t3=PD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AEAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 17:44:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A482218EA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 17:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NdeB5KCT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="OQFvDCxO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A482218EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=nMLFZXkpsluwuC/n9BeFfY0YS9IhucI1oowW0JJmG1s=; b=Nde
	B5KCTXfX1OjkCz9KvIW6lJ3JjT7mxYBwxbhOke+cjC1vp0UPGOIKnbf7tJHnwNNNDY2J2uh7kGJKl
	hUB4qxd/O0UaHFQDKXz0NAjCaMvKgvFlz/VXKHj82NSBwi8BPQNa+uW4KHqlq9LYLashK5OWy+dFs
	17kvV2sN9Vukq7FxuY8xJPpOrhAxQFKXEWMPW+Mqov4Z2ESJjpLLNEKoJJqdznOjkRTAT2D1fRU+U
	rAA9K7FoZSfciIRnNMiiywaDw9neD08O2W/Gr2AwIm/x4WvxEH51fGayysPSQZGUaZD/FtozJzrZh
	S+gcBkAK3dcrT38a5IcRfAWGJe4sYog==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcDDx-0005i1-55; Wed, 26 Dec 2018 17:44:05 +0000
Received: from mta-p6.oit.umn.edu ([134.84.196.206])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcDDt-0005h6-1E
 for linux-arm-kernel@lists.infradead.org; Wed, 26 Dec 2018 17:44:03 +0000
Received: from localhost (unknown [127.0.0.1])
 by mta-p6.oit.umn.edu (Postfix) with ESMTP id 866C773B
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 26 Dec 2018 17:37:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
 by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YZAfL9oFwrkx for <linux-arm-kernel@lists.infradead.org>;
 Wed, 26 Dec 2018 11:37:42 -0600 (CST)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71])
 (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 58EAF93B
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 26 Dec 2018 11:37:42 -0600 (CST)
Received: by mail-io1-f71.google.com with SMTP id t133so19818057iof.20
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 26 Dec 2018 09:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=umn.edu; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=yxt2Y/xGhxUz9dJIXAwgpXma5zpJOQ6jsJWBEi9cV/s=;
 b=OQFvDCxOhylfCdGZIC1Ivz53I5R5Sg/z58U949NMThkexWe/ydLTJf3VmcAefytV2B
 mnBSFA0Rg93qORqjmdqswTinhq88HRIENj6rAzayEJcsj/zhvPDGU4KbEabBZkVEDfKl
 lYCW2mqVz/RXCqUDKhBPb10ET4OFcOL5HNNWEeE04ysDyV9Pnp7BQExji21xcUh8Tol2
 zyUGv4HoZWYUMynRkHrAXN9TiYEx+YffJb76dBS+7OgZ0L9gPfvm3WYzE3twDc/0i7vB
 wgwF8KjhkAIoSe5r/8HSZacsT7cv1QJ/3hH3Ceg3S6Awbic19caLblS28FlLbanA4vBz
 p31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=yxt2Y/xGhxUz9dJIXAwgpXma5zpJOQ6jsJWBEi9cV/s=;
 b=lesgRUAtzyUalj1LmWlGe4UZU5YEW+YxYgQxWgDUN8jkaPcTjmpoNBPId9CPX356Uy
 envk0WlrekQEQa/3fl2C+8JjU4I0HeetS8ffTE6oQiUUPPKWqr7g0kfx/ljtbskjZz7k
 J1GTdR802kLVpbqogVj58oMyOOTcfoDhr1F1M1EPKGIssXvr3tLytprXfXyhC0Ffae9P
 4fKL0WoGQEu97yEywD/qD/vbm1RteGFBd/eRtHRkPYCdX9Fxk6heoa6mk8kS1wpfFz8U
 X9lzs6+zTQroSyQN2kPMeVgt158yF/lrux28UHz3gOyJWLenWZP2nmBOad5CAJrdA9pt
 lr7Q==
X-Gm-Message-State: AJcUukcmdY+ovw7CjSG1YE1tekf352VNLnDF6S8XACvLZHjs6SRlMy/4
 reXMiyOEs1ff27pMfbTLFXdIemYD43yvON+A4WE1ZVhqKO9sUiELqEmzaTg2YUMNOiGyCIxD3dM
 fB4RL4TXd1Sx8KT9llFQ85hRDGLrg3E6WGXWeCSM=
X-Received: by 2002:a5d:9652:: with SMTP id d18mr3921134ios.257.1545845861724; 
 Wed, 26 Dec 2018 09:37:41 -0800 (PST)
X-Google-Smtp-Source: ALg8bN4e56M/UjQ8az4I6y5/An2cMORU0RpSR/Wpz/yw5KLfDXD34AUkCIXYPw4WOQbrwyfDZKQs3w==
X-Received: by 2002:a5d:9652:: with SMTP id d18mr3921111ios.257.1545845861495; 
 Wed, 26 Dec 2018 09:37:41 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu.
 [134.84.121.78])
 by smtp.gmail.com with ESMTPSA id e68sm14585031ite.7.2018.12.26.09.37.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Dec 2018 09:37:40 -0800 (PST)
From: Aditya Pakki <pakki001@umn.edu>
To: pakki001@umn.edu
Subject: [PATCH] net:phy: Add a return value check on bus write
Date: Wed, 26 Dec 2018 11:37:17 -0600
Message-Id: <20181226173717.7113-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181226_094401_162331_37BFAF97 
X-CRM114-Status: GOOD (  13.04  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 netdev@vger.kernel.org, kjlu@umn.edu, Michal Simek <michal.simek@xilinx.com>,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org, Heiner Kallweit <hkallweit1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

xgmiitorgmii_read_status() could fail when writing to the bus via
mdiobus_write(). The fix adds a check and returns an error in case
of failure.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/net/phy/xilinx_gmii2rgmii.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/xilinx_gmii2rgmii.c b/drivers/net/phy/xilinx_gmii2rgmii.c
index 74a8782313cf..926879d43373 100644
--- a/drivers/net/phy/xilinx_gmii2rgmii.c
+++ b/drivers/net/phy/xilinx_gmii2rgmii.c
@@ -58,7 +58,9 @@ static int xgmiitorgmii_read_status(struct phy_device *phydev)
 	else
 		val |= BMCR_SPEED10;
 
-	mdiobus_write(bus, addr, XILINX_GMII2RGMII_REG, val);
+	err = mdiobus_write(bus, addr, XILINX_GMII2RGMII_REG, val);
+	if (err)
+		return err;
 
 	return 0;
 }
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
