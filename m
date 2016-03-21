From: jamesjj.liao@mediatek.com (James Liao)
Date: Mon, 21 Mar 2016 16:45:44 +0800
Subject: [PATCH v6 4/7] clk: mediatek: Add MT2701 clock support
In-Reply-To: <1456381477.22545.24.camel@mtksdaap41>
References: <1454665050-37776-1-git-send-email-jamesjj.liao@mediatek.com>
 <1454665050-37776-5-git-send-email-jamesjj.liao@mediatek.com>
 <20160210200853.26445.15165@quark.deferred.io>
 <1455527982.29688.8.camel@mtksdaap41>
 <20160224212533.2278.7597@quark.deferred.io>
 <1456381477.22545.24.camel@mtksdaap41>
Message-ID: <1458549944.21625.6.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

Sorry to use this old email to ask questions. Do you have any concern to
apply this patch series into next version of kernel? Or do you really
need a new patch series with less CLK_OF_DECLARE()?


Best regards,

James


On Thu, 2016-02-25 at 14:24 +0800, James Liao wrote:
> Hi Mike,
> 
> On Wed, 2016-02-24 at 13:25 -0800, Michael Turquette wrote:
> > Hi James,
> > 
> > Quoting James Liao (2016-02-15 01:19:42)
> > > Hi Mike,
> > > 
> > > On Wed, 2016-02-10 at 12:08 -0800, Michael Turquette wrote:
> > > > Quoting James Liao (2016-02-05 01:37:27)
> > > > > +CLK_OF_DECLARE(mtk_topckgen, "mediatek,mt2701-topckgen", mtk_topckgen_init);
> > > > > +CLK_OF_DECLARE(mtk_infrasys, "mediatek,mt2701-infracfg", mtk_infrasys_init);
> > > > > +CLK_OF_DECLARE(mtk_pericfg, "mediatek,mt2701-pericfg", mtk_pericfg_init);
> > > > > +CLK_OF_DECLARE(mtk_mmsys, "mediatek,mt2701-mmsys", mtk_mmsys_init);
> > > > > +CLK_OF_DECLARE(mtk_imgsys, "mediatek,mt2701-imgsys", mtk_imgsys_init);
> > > > > +CLK_OF_DECLARE(mtk_vdecsys, "mediatek,mt2701-vdecsys", mtk_vdecsys_init);
> > > > > +CLK_OF_DECLARE(mtk_hifsys, "mediatek,mt2701-hifsys", mtk_hifsys_init);
> > > > > +CLK_OF_DECLARE(mtk_ethsys, "mediatek,mt2701-ethsys", mtk_ethsys_init);
> > > > > +CLK_OF_DECLARE(mtk_bdpsys, "mediatek,mt2701-bdpsys", mtk_bdpsys_init);
> > > > > +CLK_OF_DECLARE(mtk_apmixedsys, "mediatek,mt2701-apmixedsys",
> > > > 
> > > > :-/
> > > > 
> > > > This is way too much CLK_OF_DECLARE and not enough Linux Driver Model.
> > > > 
> > > > I understand that some platforms really must initialize some clocks very
> > > > early, but can we please separate those into one table and call
> > > > CLK_OF_DECLARE on only that set, and then register the rest through a
> > > > platform_driver later on?
> > > 
> > > I know CLK_OF_DECLARE is much earlier than platform_driver, so it can
> > > ensure all drivers lookup their clocks successfully during
> > > platform_driver probe. Is there anything different to init these clock
> > > providers in CLK_OF_DECLARE and platform_driver?
> > 
> > This a common pattern we're seeing right now. Joachim did a nice job of
> > supporting early clocks with CLK_OF_DECLARE, and also using a proper
> > driver in his lpc18xx implementation:
> > 
> > http://marc.info/?l=devicetree&m=145618160610001
> 
> Do you mean we should keep most clock init in platform_driver_probe and
> use CLK_OF_DECLARE for some early clocks only?
> 
> Using CLK_OF_DECLARE() for all clock providers is convenient. The
> convenience includes coding structure and driver init order. The coding
> structure means we can use a consistency way to add clock providers, so
> we can reduce errors and apply code generator on clock drivers.
> 
> The driver init order is another issue. In lpc18xx driver you mentioned
> in [1], it uses ERR_PTR(-EPROBE_DEFER) to be the place holder for
> non-early clocks in arch_init (CLK_OF_DECLARE), and then register early
> and non-early clocks again in module_init. The EPROBE_DEFER place holder
> is an interesting idea to resolve init order issue. But to register
> clocks twice on the same clock provider seems not a good idea, although
> it can still work in current CCF implementation.
> 
> Is it important to move clock init into platform_driver? If not, I
> prefer to keep current implementation on MT2701, and look for a better
> way to init clocks in platform_driver in new SoCs.
> 
> 
> [1] http://marc.info/?l=devicetree&m=145618160610001
> 
> 
