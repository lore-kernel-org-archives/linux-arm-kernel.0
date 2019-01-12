Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227E4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 16:43:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6AD020836
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 16:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dMPKTJRq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6AD020836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AtU7NKSSvXhUwQgQj/ESJIz7cHF1NDp8NfiOOKJwo7w=; b=dMPKTJRqMhJdmt
	AyXZPcATs99rJgN6L8wFH0nb4uOfBxkPCHS2zdnJpRXmPK/73t27PIErViXckCQhXcYPOSDV5ZpQJ
	DINnG0gBLUVQovUTGtIOsimOCgjq5ZIEfPDZ2GKAXPU2GXqByRX1JcCN1+RzXrLPcA60w2nCBM3HZ
	d/xr/n2ZZzRPsyRVcRM716q+2QoYBhJCBUCOaEhQpwb2dUOyqTYWi17syJnSPPS65KDbbo8N8PBZT
	ywYaYGzbncTz1vP/gWi309WEkJEJCheSDaNTZwgBU87i1E5ydDTbtEPFLxXhwmOLcpfrshLOYd3Cy
	b1/1bkokKrLvDLeoLsxw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giMNn-00013Y-Pv; Sat, 12 Jan 2019 16:43:39 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giMNj-000130-6u
 for linux-arm-kernel@lists.infradead.org; Sat, 12 Jan 2019 16:43:37 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 11A352074D; Sat, 12 Jan 2019 17:43:30 +0100 (CET)
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
 by mail.bootlin.com (Postfix) with ESMTPSA id CEAFE20714;
 Sat, 12 Jan 2019 17:43:19 +0100 (CET)
Date: Sat, 12 Jan 2019 17:43:19 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v5 07/17] drm/sun4i: sun6i_mipi_dsi: Refactor vertical
 video start delay
Message-ID: <20190112164319.whr7gwvl4oux5svz@flea>
References: <20181210161729.29720-1-jagan@amarulasolutions.com>
 <20181210161729.29720-8-jagan@amarulasolutions.com>
 <20181211164900.wfmkmbrbj3nmlb3h@flea>
 <CAMty3ZB5F5jD9iJT1soXSA5HtQOf5W9rKO9nCdGFUfVo0hpO4Q@mail.gmail.com>
 <20190107141158.zaimizk4rlqa6xli@flea>
 <CAMty3ZBb8byOwh=_W83Ta0Dse1qkoqccOeaBEY9oHPaxDxe9QA@mail.gmail.com>
 <20190108085829.clianbtjovu3oieq@flea>
 <CAMty3ZC9OQtwT-iH=S1LhHsBPc_jFKGAnCYYeR9nuKuDWSKLQw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMty3ZC9OQtwT-iH=S1LhHsBPc_jFKGAnCYYeR9nuKuDWSKLQw@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_084335_525722_DA3EC712 
X-CRM114-Status: GOOD (  23.82  )
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
Cc: Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 linux-sunxi <linux-sunxi@googlegroups.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, Chen-Yu Tsai <wens@csie.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-clk <linux-clk@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 09, 2019 at 06:57:57PM +0530, Jagan Teki wrote:
> On Tue, Jan 8, 2019 at 2:28 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > On Mon, Jan 07, 2019 at 08:48:21PM +0530, Jagan Teki wrote:
> > > On Mon, Jan 7, 2019 at 7:42 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > >
> > > > On Fri, Dec 21, 2018 at 02:26:11AM +0530, Jagan Teki wrote:
> > > > > On Tue, Dec 11, 2018 at 10:19 PM Maxime Ripard
> > > > > <maxime.ripard@bootlin.com> wrote:
> > > > > >
> > > > > > On Mon, Dec 10, 2018 at 09:47:19PM +0530, Jagan Teki wrote:
> > > > > > > Video start delay can be computed by subtracting total vertical
> > > > > > > timing with front porch timing and with adding 1 delay line for TCON.
> > > > > > >
> > > > > > > BSP code form BPI-M64-bsp is computing video start delay as
> > > > > > > (from linux-sunxi/
> > > > > > > drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> > > > > > >
> > > > > > > u32 vfp = panel->lcd_vt - panel->lcd_y - panel->lcd_vbp;
> > > > > > > => (panel->lcd_vt) - panel->lcd_y - (panel->lcd_vbp)
> > > > > > > => (timmings->ver_front_porch + panel->lcd_vbp + panel->lcd_y)
> > > > > > >    - panel->lcd_y - (panel->lcd_vbp)
> > > > > > > => timmings->ver_front_porch + panel->lcd_vbp + panel->lcd_y
> > > > > > >                            - panel->lcd_y - panel->lcd_vbp
> > > > > > > => timmings->ver_front_porch
> > > > > > >
> > > > > > > So, update the start delay computation accordingly.
> > > > > > >
> > > > > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > > >
> > > > > > Even though it's a bit better now on my A33 board and I don't have the
> > > > > > white stripes on the bottom of the display, there's still some
> > > > > > flickering with your patches applied.
> > > > > >
> > > > > > Bisecting it seems to point at that patch, but reverting it doesn't
> > > > > > make the issue go away, so it's not really clear which one exactly is
> > > > > > at fault.
> > > > >
> > > > > Is reverting this patch, work fine or not?
> > > >
> > > > As I was saying, it doesn't.
> > > >
> > > > > This patch is trying to make use of front porch instead of existing
> > > > > back porch to compute the delay. Since we revert the VBP fix patch[1]
> > > > > to assume VBP as VFP value look like your setup would also require to
> > > > > revert this change. But as per BSP or drm_mode details all of my
> > > > > displays even work with and w/o reverting these two.
> > > >
> > > > Again, I cannot help you without the datasheet for the panels you're
> > > > trying to submit.
> > >
> > > The panel bound with Sitronix ST7701 IC
> > > http://www.startek-lcd.com/res/starteklcd/pdres/201705/20170512144242904.pdf
> >
> > It's the controller, not the panel
> 
> As I said before, the datasheet of that panel doesn't have any
> information except electrical characteristics and used IC which is
> ST7701.
> 
> I have one more panel, which is from Bananapi, S070WV20-CT16 ICN621
> please find the attachment for the same.
> 
> Here is some more details of the same.
> 
> https://github.com/yesnoandor/x300/blob/master/kernel/arch/arm/boot/dts/erobbing/x300/x300.dtsi#L81
> https://github.com/wxzed/Raspberry_5MIPI_Display/blob/master/I2C_Slave/USER/main.c#L15
> 
> https://github.com/eliot-shao/qcom/blob/master/icn6211_cxn0102/kernel/drivers/video/msm/mdss/mdss_i2c_interface.c#L152
> matches timings for
> https://github.com/eliot-shao/qcom/blob/master/icn6211_cxn0102/kernel/arch/arm/boot/dts/qcom/dsi-mipi-2-rgb_1280p_video.dtsi#L20
> 
> https://github.com/zestroly/micromat/blob/master/test/raspberry/ICN6211.cpp#L169

Where did you get the timings from then?

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
