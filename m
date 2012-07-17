From: b29396@freescale.com (Dong Aisheng)
Date: Tue, 17 Jul 2012 19:55:32 +0800
Subject: MX28EVK mainline 3.5-Patchs-3.5-rc5 sgtl5000 record not working
In-Reply-To: <CAHE2-snYoZB8tTOaZ29nxOU3KNBKut_EaGif_LKNQx9VMNii=g@mail.gmail.com>
References: <CAHE2-smsOufHjfyjKARcwHve4cGqWeM8y7ALxcJkaqLiZBNoSw@mail.gmail.com>
 <20120711031446.GB14060@S2101-09.ap.freescale.net>
 <20120711085244.GA22640@shlinux2.ap.freescale.net>
 <CAHE2-snYoZB8tTOaZ29nxOU3KNBKut_EaGif_LKNQx9VMNii=g@mail.gmail.com>
Message-ID: <20120717115531.GA11024@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 16, 2012 at 07:23:42PM +0800, Andreas Gretler wrote:
> > I can see the same problem at my side.
> > Usually it's caused by clock issue.
> > I will try to fix it tomorrow when have time.
> >
> > Regards
> > Dong Aisheng
> >
>  Hi,
> 
> i did a bit more research on it. Before the change to common clock
> framework, it seems that I can toggle the headphone and adc from Mic
> to Line in. The headphone toggle to direct output works, but
> unfortunately if i toggle the ADC input source to Line-In  the
> recorded sound is only a noisy signal.
> 
> I test several past version, but I can not find a version where the
> recording function for Line-In works.
> 
> 
It seems it's broken for a long time.
I tried 3.3 kernel, with adding below change the record can work(
can hear some noise, however, that's another issue of codec driver).
diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
index 5d68e41..bce93c3 100644
--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -820,8 +820,12 @@ int __init mx28_clocks_init(void)
* uses the other saif's BITCLK&LRCLK but it still needs a basic
* clock which should be fast enough for the internal logic.
*/
+       clk_prepare_enable(&saif0_clk);
+       clk_prepare_enable(&saif1_clk);
        clk_set_rate(&saif0_clk, 24000000);
	clk_set_rate(&saif1_clk, 24000000);

The reason is that the clk_enable function becomes 'nops' after commit:
6abda3e ARM: mxs: select HAVE_CLK_PREPARE for clock
which could cause clock not to be enabled properly.
You can give a quick try.

> I try to understand the saif-code, but i does not understand why not
> all clk_enable are replaced by clk_prepare_enable. Can anyone explain
clk_prepare_enable can not be called in atomic context.
So in trigger function, we call clk_enable instead.

> that? I replaced the clk_enable clk_prepare_enableand the board does
> not crash, but there is an input/output error.
> 
It seems dma did not work properly.

>                 /*
>                  * If the saif's master is not himself, we also need to enable
>                  * itself clk for its internal basic logic to work.
>                  */
>                 if (saif != master_saif) {
>                         clk_enable(saif->clk);
>                         __raw_writel(BM_SAIF_CTRL_RUN,
>                                 saif->base + SAIF_CTRL + MXS_SET_ADDR);
>                 }
> 
> 
> Another question is about the initial clock rate for the saif internal
> logic. Befor the clock_mx28.c was deleted, there was an
> clk_set_rate(&saif1_clk, 24000000); for internal logic. Where it is
> now being made? I did not found it.
That should be added.
I tried, but still did not work.
Still did not have too much time to dig into it.

For others, will reply your later.

Regards
Dong Aisheng
