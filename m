From: eddie.huang@mediatek.com (Eddie Huang)
Date: Fri, 8 May 2015 17:51:56 +0800
Subject: Question about checking rate_spi in pwrap_init_reg_clock
In-Reply-To: <CAFRkauCbpDfT0V6pEcUf=_amcwa4E_t4taA3YzU5dYMmRxGRXA@mail.gmail.com>
References: <1429581487.5994.1.camel@ingics.com>
 <20150421103155.GX6325@pengutronix.de>
 <CABuKBeJqgWHWNYaFXS-BwEayHEtiYGt+56LLXs3QaO3MHUk0bQ@mail.gmail.com>
 <20150421125223.GB6325@pengutronix.de>
 <CABuKBeJMKpmkVZQvjZOuEtZmVaby6wxhr-i7w6eoHLjqTNNRig@mail.gmail.com>
 <CAFRkauCbpDfT0V6pEcUf=_amcwa4E_t4taA3YzU5dYMmRxGRXA@mail.gmail.com>
Message-ID: <1431078716.16627.6.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Axel,

On Fri, 2015-05-08 at 17:33 +0800, Axel Lin wrote:
> CC Leilk Liu
> 
> 2015-04-21 23:42 GMT+08:00 Matthias Brugger <matthias.bgg@gmail.com>:
> > 2015-04-21 14:52 GMT+02:00 Sascha Hauer <s.hauer@pengutronix.de>:
> >> On Tue, Apr 21, 2015 at 01:43:19PM +0200, Matthias Brugger wrote:
> >>> 2015-04-21 12:31 GMT+02:00 Sascha Hauer <s.hauer@pengutronix.de>:
> >>> > On Tue, Apr 21, 2015 at 09:58:07AM +0800, Axel Lin wrote:
> >>> >> hi,
> >>> >> The implementation in pwrap_init_reg_clock seems has off-by-one bug.
> >>> >> If rate_spi is 26000000, current code set ck_mhz to 18 rather than 26.
> >>> >>
> >>> >> I guess it needs below fix, but I'm not 100% sure as I don't have the datasheet.
> >>> >> Can someone confirm if this is a bug or not?
> >>> >
> >>> > Yes, seems to be a bug. Thanks for noting. Will you send a formal patch
> >>> > or should I do it?
> >>>
> >>> Did you have a look on both datasheets/reference kernels, mt8135 and mt8173?
> >>> Reading the datasheet and reference kernel code for mt6589 this SPI
> >>> waveform configuration looks like magic.
> >>>
> >>> But reading the clock frequency which can have clk_spi in mt8135, they
> >>> are 0 MHz, 26 MHz and bigger then 26 MHz, which leads me to the
> >>> conclusion that the code is correct. Otherwise the check for bigger
> >>> then 18 MHz is useless and should be deleted, if we have a similar
> >>> clock distribution in mt8173.
> >>
> >> The CSHEXT and CSLEXT registers extend the time the chipselect stays
> >> high after a SPI transfer or low before a new transfer by the given
> >> number of spi clk cycles.
> >> Looking at the code maybe the real question is not whether the border is
> >> at 25999999Hz or at 26000000Hz, but why the transfers are throttled with
> >> slower clock frequencies. I would assume the other way round makes
> >> sense.
> >
> > After re-reading the data sheet and the reference kernel
> > implementation, it seems as if three clocks exist. clk_wrap and
> > clk_spi and "pmic reg_clk". And some how depending on the three clocks
> > you have to calculate the values for CSHEXT, CSLEXT etc.
> >
> > I think we need some clarification here from Mediatek to really
> > understand what is going on.
> 
> Hi Leilk,
> I found you are working on mtk's spi driver.
> Any comment about this discussion?
> 
> Regards,
> Axel
> 
Leilk's SPI driver is general SPI bus driver, different than pwrapper
SPI, which is a specific bus only used by pwrapper. For pwrapper SPI,
"clk_wrap" is clock used in 8173 pwrapper side, "clk_spi" is SPI bus
clock. "pmic reg_clk" is clock in PMIC side. We already discuss this
issue with Sascha, and I believe he will send new patch to solve this
problem.

Eddie



> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
