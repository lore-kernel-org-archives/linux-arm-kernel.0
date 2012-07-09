From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 9 Jul 2012 10:52:25 +0300
Subject: [PATCH] [v3] i.MX27: Fix emma-prp clocks in mx2_camera.c
In-Reply-To: <CACKLOr05W5N4n9TSKdaCP-6-j+zDSr=aNG4QoTMVWXTrM30x7Q@mail.gmail.com>
References: <1341572162-29126-1-git-send-email-javier.martin@vista-silicon.com>
 <20120709072809.GP30009@pengutronix.de>
 <CACKLOr25yb1Cx4XNriyPceBcqmc5T4jDpJXFpve9JCXpP7iMLg@mail.gmail.com>
 <20120709074337.GT30009@pengutronix.de>
 <CACKLOr05W5N4n9TSKdaCP-6-j+zDSr=aNG4QoTMVWXTrM30x7Q@mail.gmail.com>
Message-ID: <20120709075225.GI22116@sapphire.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

On Mon, Jul 09, 2012 at 09:46:03AM +0200, javier Martin wrote:
> On 9 July 2012 09:43, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > On Mon, Jul 09, 2012 at 09:37:25AM +0200, javier Martin wrote:
> >> On 9 July 2012 09:28, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> >> > On Fri, Jul 06, 2012 at 12:56:02PM +0200, Javier Martin wrote:
> >> >> This driver wasn't converted to the new clock changes
> >> >> (clk_prepare_enable/clk_disable_unprepare). Also naming
> >> >> of emma-prp related clocks for the i.MX27 was not correct.
> >> >> ---
> >> >> Enable clocks only for i.MX27.
> >> >
> >> > Indeed,
> >> >
> >> >> -     pcdev->clk_csi = clk_get(&pdev->dev, NULL);
> >> >> -     if (IS_ERR(pcdev->clk_csi)) {
> >> >> -             dev_err(&pdev->dev, "Could not get csi clock\n");
> >> >> -             err = PTR_ERR(pcdev->clk_csi);
> >> >> -             goto exit_kfree;
> >> >> +     if (cpu_is_mx27()) {
> >> >> +             pcdev->clk_csi = devm_clk_get(&pdev->dev, "ahb");
> >> >> +             if (IS_ERR(pcdev->clk_csi)) {
> >> >> +                     dev_err(&pdev->dev, "Could not get csi clock\n");
> >> >> +                     err = PTR_ERR(pcdev->clk_csi);
> >> >> +                     goto exit_kfree;
> >> >> +             }
> >> >
> >> > but why? Now the i.MX25 won't get a clock anymore.
> >>
> >> What are the clocks needed by i.MX25? csi only?
> >>
> >> By the way, is anybody using this driver with i.MX25?
> >
> > It seems Baruch (added to Cc) has used it on an i.MX25.
> could you tell us what are the clocks needed by i.MX25?

According to the code the csi clock is sufficient for i.MX25. Unfortunately I 
don't have access to a running system anymore, so I can't test current code.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
