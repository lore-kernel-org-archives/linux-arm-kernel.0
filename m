Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6266C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:48:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 772CC2083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e+3xl4kb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 772CC2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=eplgJ3VBZ1//L2VXDld8zWedZRXjCN7mtE0LJtrPNxk=; b=e+3xl4kbG/kAfY
	k5i6q1ccYE2JpppaVCor6rqNB3S91/LGqYQvSqVp6XodyzLFpYHi6TW4fFdOYFgTZuHGS12zZVfrn
	5mHEUAd9LvRSdTN0l8JjQbSTT9CHSCx6arZpUUV2u7sMWK4PVfsmg7dg8Fhz1zjS1NxPW2QDEx7vQ
	ADeubX9QDWJyoDdhCvpC6LWkuJQ0hTU/tqZaedEANlIaJSgQiRpVGYjdtk2jOxUhU9HrDUYQLCtff
	ljAJKdoSejP+HwcSApLXJhBxAEQYvykVLYAMEL3eIta+5K03KFFhjz6JksfxySAXjAp4FW5t0WyUy
	cO32qq2Wm84b4bDMqOvg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goWYh-0003n6-0G; Tue, 29 Jan 2019 16:48:23 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goWYd-0003mP-ME
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 16:48:21 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id ECC05804F;
 Tue, 29 Jan 2019 16:48:24 +0000 (UTC)
Date: Tue, 29 Jan 2019 08:48:13 -0800
From: Tony Lindgren <tony@atomide.com>
To: Douglas Anderson <dianders@chromium.org>, Mark Brown <broonie@kernel.org>
Subject: New underflow of regulator enable count warnings in v5.0-rc1
Message-ID: <20190129164813.GA5720@atomide.com>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_084819_769078_67A10353 
X-CRM114-Status: UNSURE (   4.50  )
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
Cc: linux-omap@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

Looks like commit 5451781dadf8 ("regulator: core: Only count load for
enabled consumers") started showing new warnings with v5.0-rc cycle:

regulator-dummy: Underflow of regulator enable count

I'm seeing this at least with my pwm-vibra test case:

# rumble-test /dev/input/by-path/platform-vibrator-event 0xffff
pwm-vibrator vibrator: vibrator supply vcc not found, using dummy regulator
input: pwm-vibrator as /devices/platform/vibrator/input/input4
regulator-dummy: Underflow of regulator enable count
Upload rumble effect... id=0
regulator-dummy: Underflow of regulator enable count

Are these bogus warnings for dummy regulator or do we have
real unpaired regulator calls or somewhere?

Regards,

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
