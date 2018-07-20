From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 20 Jul 2018 16:51:43 +0200
Subject: [PATCH v3 0/7] mmc: sunxi: Add runtime PM support
In-Reply-To: <20180716171428.ud3zsmeccds545si@core>
References: <cover.e9b9c0ab5bc9ffcc52a15e1c2f41462729da5b61.1523888566.git-series.maxime.ripard@bootlin.com>
 <20180716171428.ud3zsmeccds545si@core>
Message-ID: <20180720145143.qgvlk2gbegxwwcfs@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ondrej,

On Mon, Jul 16, 2018 at 07:14:28PM +0200, Ond?ej Jirman wrote:
> On Mon, Apr 16, 2018 at 04:22:58PM +0200, Maxime Ripard wrote:
> > Hi,
> > 
> > Since it's introduction, our MMC controller has had its external clocks
> > running all the time.
> > 
> > While that was working great, the power usage and most importantly the EMI
> > that it generated was pretty bad.
> > 
> > Let's implement some runtime_pm hooks with an autosuspend to shut down the
> > whole block when the MMC is not active.
> > 
> > However, some SDIO devices will not probe properly if we keep shutting down
> > the controller, so the autosuspend is disabled for the SDIO devices.
> 
> I've tested your patches on TBS A711 tablet (A83T). I get this in the log:
> 
>   sunxi-mmc 1c10000.mmc: fatal err update clk timeout
> 
> Interestingly, this only happens after the first boot. If I hard power cycle the
> tablet (removing/reinserting the battery) the first boot after that, there's no
> timeout, and WiFi chip connected to the mmc controller works.
> 
> Any other reboot (even power cycling via PMIC), it fails with the above error.
> Maybe there's some unforeseen interaction of runtime PM with mmc-powerseq used
> for the wifi chip power seuencing? Do you know what's the above error about?
> I don't know anything about mmc subsystem.

It's kind of weird. Do you have an oscilloscope available to look at
the clock signal (and the reset gpio) and see if there's any
difference of behaviour?

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180720/476fd7a9/attachment.sig>
