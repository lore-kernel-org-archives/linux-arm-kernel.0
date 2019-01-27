Return-Path: <SRS0=mu0f=QD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF132C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 14:51:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F64721736
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 14:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BzvJuRap"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F64721736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=mua1lQkbsX3SM8K5qQ1DFzn5Uj7J6Ej6FBW7S8rth0k=; b=BzvJuRapBC8i89
	MbsTbaWYgpAYmSHoDZVOf5XiB4baV1gjD1suEm1mnk3TVw0kK4Ez13W9G6VfPx+PtS8FgtBce1JT7
	lzXehSh7qi6VcTjNTy0m4HSLRMyN2T3xaq3GM/tMyZlkgpEGxS+VFZmtT/TZCbk6Q2CMjadoiO3Js
	pqlqg/rDE9INssDurTF67c+kTWeHxWN/REb4xdnA0pbj1cib6mu+l1Ra2NQfDHnSfe8LZNGIFOGnP
	4THja4GqPrwJQpDUaErHpTbJ93dp0uIBiLrZ/NPfowwwpj5CV6FsW5wekZQWzSZLM15gbsFdIqxVw
	J5icznYABtXFdKEomUeg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnlm1-0003CV-8P; Sun, 27 Jan 2019 14:51:01 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnllx-0003Bt-7Y
 for linux-arm-kernel@lists.infradead.org; Sun, 27 Jan 2019 14:50:58 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id CC4905FD14; Sun, 27 Jan 2019 22:50:55 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Thierry Reding <thierry.reding@gmail.com>,
 Lee Jones <lee.jones@linaro.org>,
 Daniel Thompson <daniel.thompson@linaro.org>,
 Jingoo Han <jingoohan1@gmail.com>
Subject: [PATCH] backlight: pwm_bl: Use gpiod_get_value_cansleep() to get
 initial state
Date: Sun, 27 Jan 2019 22:50:54 +0800
Message-Id: <20190127145054.3770-1-wens@csie.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190127_065057_404431_CBE44327 
X-CRM114-Status: GOOD (  11.54  )
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
Cc: linux-pwm@vger.kernel.org, Maxime Ripard <maxime.ripard@bootlin.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

gpiod_get_value() gives out a warning if access to the underlying gpiochip
requires sleeping, which is common for I2C based chips:

    WARNING: CPU: 0 PID: 77 at drivers/gpio/gpiolib.c:2500 gpiod_get_value+0xd0/0x100
    Modules linked in:
    CPU: 0 PID: 77 Comm: kworker/0:2 Not tainted 4.14.0-rc3-00589-gf32897915d48-dirty #90
    Hardware name: Allwinner sun4i/sun5i Families
    Workqueue: events deferred_probe_work_func
    [<c010ec50>] (unwind_backtrace) from [<c010b784>] (show_stack+0x10/0x14)
    [<c010b784>] (show_stack) from [<c0797224>] (dump_stack+0x88/0x9c)
    [<c0797224>] (dump_stack) from [<c0125b08>] (__warn+0xe8/0x100)
    [<c0125b08>] (__warn) from [<c0125bd0>] (warn_slowpath_null+0x20/0x28)
    [<c0125bd0>] (warn_slowpath_null) from [<c037069c>] (gpiod_get_value+0xd0/0x100)
    [<c037069c>] (gpiod_get_value) from [<c03778d0>] (pwm_backlight_probe+0x238/0x508)
    [<c03778d0>] (pwm_backlight_probe) from [<c0411a2c>] (platform_drv_probe+0x50/0xac)
    [<c0411a2c>] (platform_drv_probe) from [<c0410224>] (driver_probe_device+0x238/0x2e8)
    [<c0410224>] (driver_probe_device) from [<c040e820>] (bus_for_each_drv+0x44/0x94)
    [<c040e820>] (bus_for_each_drv) from [<c040ff0c>] (__device_attach+0xb0/0x114)
    [<c040ff0c>] (__device_attach) from [<c040f4f8>] (bus_probe_device+0x84/0x8c)
    [<c040f4f8>] (bus_probe_device) from [<c040f944>] (deferred_probe_work_func+0x50/0x14c)
    [<c040f944>] (deferred_probe_work_func) from [<c013be84>] (process_one_work+0x1ec/0x414)
    [<c013be84>] (process_one_work) from [<c013ce5c>] (worker_thread+0x2b0/0x5a0)
    [<c013ce5c>] (worker_thread) from [<c0141908>] (kthread+0x14c/0x154)
    [<c0141908>] (kthread) from [<c0107ab0>] (ret_from_fork+0x14/0x24)

This was missed in commit 0c9501f823a4 ("backlight: pwm_bl: Handle gpio
that can sleep"). The code was then moved to a separate function in
commit 7613c922315e ("backlight: pwm_bl: Move the checks for initial power
state to a separate function").

The only usage of gpiod_get_value() is during the probe stage, which is
safe to sleep in. Switch to gpiod_get_value_cansleep().

Fixes: 0c9501f823a4 ("backlight: pwm_bl: Handle gpio that can sleep")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/video/backlight/pwm_bl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index feb90764a811..53b8ceea9bde 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -435,7 +435,7 @@ static int pwm_backlight_initial_power_state(const struct pwm_bl_data *pb)
 	 */
 
 	/* if the enable GPIO is disabled, do not enable the backlight */
-	if (pb->enable_gpio && gpiod_get_value(pb->enable_gpio) == 0)
+	if (pb->enable_gpio && gpiod_get_value_cansleep(pb->enable_gpio) == 0)
 		return FB_BLANK_POWERDOWN;
 
 	/* The regulator is disabled, do not enable the backlight */
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
