From: andi@etezian.org (Andi Shyti)
Date: Fri, 8 Jul 2016 00:39:07 +0900
Subject: [PATCH v4 1/2] clk: exynos5433: do not use CLK_IGNORE_UNUSED for
 SPI clocks
In-Reply-To: <577E7343.9090002@samsung.com>
References: <1467893637-12573-1-git-send-email-andi.shyti@samsung.com>
 <1467893637-12573-2-git-send-email-andi.shyti@samsung.com>
 <CGME20160707124623epcas1p2452001bf48f03cb47c7f7db437130e6d@epcas1p2.samsung.com>
 <577E4F1C.8070004@samsung.com>
 <20160707132738.GI23620@samsunx.samsung>
 <577E7343.9090002@samsung.com>
Message-ID: <20160707153907.GB1256@jack.zhora.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylwester,

> >>> > > The CLK_IGNORE_UNUSED flag has to be avoided whenever possible.
> >>> > > Use the CLK_IS_CRITICAL flag instead for critical SPI1 clocks,
> >>> > > which enables the clock line during boot time.
> >> > 
> >> > I don't agree. Both flags should be avoided. Clk is critical does not
> >> > solve the problem. It is just a better workaround for lack of proper
> >> > clock consumers.
> >> > 
> >> > The IOCLK is not a critical clock. It can be disabled (e.g. when SoC
> >> >  is used on a board without any SPI device connected).
> >
> > As we discussed offline there is no driver which is requesting
> > this clock. We cannot ask to the spi driver to handle three
> > clocks because the exynos5433 has its own peculiarities.
> > 
> > If we want this on the spi driver's side, we need to add a new
> > compatible and check it everytime. To me it looks uglier than
> > just keep it alive.
> 
> I took a closer look at what those IOCLK clocks exactly are and
> unfortunately I must agree with Krzysztof.  These clock gates are
> closely related to the IP blocks and to me proper approach is to
> have them listed in DT and controlled by the SPI bus driver.
> 
> I checked and there is similar pattern for other IPs like I2S and
> other SoCs, e.g. exynos7420.
> Additionally parents of those IOCLK_SPI?_CLK clocks are currently
> wrongly modelled as fixed rate clocks.  These clocks really don't
> have a parent until some clock is fed externally to the SoC's I/O
> pin.  But this issue could be addressed later.

yes, it's a weird design :/

> I think it is not a big deal to add "samsung-exynos5433-spi"
> compatible to the SPI driver along with a new variant data and
> a flag like "has_cmu_ioclk" to indicate whether a third clock
> should be handled or not. Presumably for now the ioclk clock can
> just simply be enabled in probe(), this way it will be enabled
> only for SPI controllers actually in use.

OK, I will work on s3c64xx driver side, then.

Thanks,
Andi
