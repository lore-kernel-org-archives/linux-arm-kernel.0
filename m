From: jamesjj.liao@mediatek.com (James Liao)
Date: Thu, 1 Oct 2015 15:15:50 +0800
Subject: [PATCH] soc: mediatek: Fix random hang up issue while kernel init
In-Reply-To: <1443604022.3185.17.camel@pengutronix.de>
References: <1443162717-64831-1-git-send-email-jamesjj.liao@mediatek.com>
 <1443169573.3135.9.camel@pengutronix.de> <5607D224.4050801@gmail.com>
 <CAGS+omCXMRf4bxWancSJSq2a1pc38TYYY46Os9ASWWCRp95_ig@mail.gmail.com>
 <1443604022.3185.17.camel@pengutronix.de>
Message-ID: <1443683750.1714.25.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lucas,

On Wed, 2015-09-30 at 11:07 +0200, Lucas Stach wrote:
> > If the VENC power domain is disabled, then accesses to the vencsys
> > registers just silently fail (i.e., reads probably
> > return all 0s). 
> 
> If this ever happens it is really unfortunate and needs fixing, too. If
> you need the power domain to be powered ON to properly read or even
> change the clock registers, the clock driver needs to be a consumer of
> the power domain, so any clock operations powers the domain up.

A subsystem should be powered on before its clock operations. But I
think this flow should be guaranteed by VENC driver. This patch is
focused on the race between disabling unused clocks and power domains by
frameworks. 

> > In theory, we could add "clocks=<&topckgen CLK_TOP_VENC_SEL>;" to the
> > vencsys clock-controller node.  On initialization, mtk_vencsys_init()
> > could then pass venc_sel to the generic MT8173 gate clock driver, and
> > it would then clk_enable(venc_sel)/_disable(venc_sel) around any
> > access to the clock-controller registers.  James, however, thinks
> > this is a lot of extra overhead, and instead has proposed the fix in this patch,
> > where venc_sel is forced on whenever the VENC power domain is enabled.
> > 
> I would still say this is the correct solution. If the vencsys clock
> registers are itself clocked by VENC_SEL this driver needs to make sure
> this clock is running at the appropriate times. I understand that this
> may be a bit of an overhead, but clock enable/disable paths are not
> really performance critical.
> 
> > So, this patch is a bit of a hack, but the mtk scpsys driver already
> > does something similar for the MM & MFG clocks - these clocks are
> > always enabled whenever certain power domains are enabled, and they
> > are only disabled when all such power domains are disabled.  I'm not
> > 100% why these clocks must always be kept on whenever these power
> > domains are enabled, but probably to solve a similar problem where
> > these clocks are needed to access some registers at a time when these
> > clocks would not otherwise be explicitly enabled.
> > 
> I can't really argue with this being the wrong solution if we already
> have precedent of the same solution being used for other domains. But I
> would still ask you to re-evaluate with the above in mind.

One cause of the hang up issue is frameworks' behavior. Power domain
framework and clock framework work independently during kernel init. So
their control flow can't be guaranteed by a suitable driver, such as
VENC driver.

I preferred to keep venc_sel on during VENC power on because I'm not
sure there is any other framework may control VENC's registers during
kernel init.


Best regards,

James
