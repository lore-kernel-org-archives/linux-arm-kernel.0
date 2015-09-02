From: axel.lin@ingics.com (Axel Lin)
Date: Wed, 2 Sep 2015 08:42:14 +0800
Subject: ARM: pxa: build error in arch/arm/plat-pxa/ssp.c
In-Reply-To: <20150901184335.GY5313@sirena.org.uk>
References: <1441073073.12012.3.camel@ingics.com>
 <55E54754.1060002@linux.intel.com>
 <20150901184335.GY5313@sirena.org.uk>
Message-ID: <CAFRkauDq8tWeso0M3cWH9z=i2hCou8m6w8q_RpmgofPcdcKGNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-09-02 2:43 GMT+08:00 Mark Brown <broonie@kernel.org>:
> On Tue, Sep 01, 2015 at 09:36:04AM +0300, Jarkko Nikula wrote:
>
>> No I'm pondering how to fix this. I see these bindings are added by the
>> commit a6e56c28a178 ("ARM: pxa: ssp: add DT bindings") but some of the types
>> are not used anywhere. For instance PXA168_SSP or PXA910_SSP. Then
>> PXA3xx_SSP is used in sound/soc/pxa/pxa-ssp.c and CE4100_SSP in
>> drivers/spi/spi-pxa2xx.c (where LPSS_SSP was used too before differentiating
>> it).
>
> IIRC the PXA168 and PXA910 are software compatible with the PXA3xx SPI
> controller.  Those SoCs never got wide distribution compared to the
> older PXA models I think.
>
>> What I'm wondering is this binding below correct in arch/arm/plat-pxa/ssp.c?
>> LPSS_SSP was meant to be for Intel Intel Low Power Subsystem SPI.
>
>> "{ .compatible = "mrvl,lpss-ssp",     .data = (void *) LPSS_SSP }"
>
>> Mika, Daniel: do you know is there any change there is a Marvell PXA
>> platform compatible with Intel LPSS or is above binding bogus?
>
> I bet it's just cut'n'paste because everything else about the driver and
> all the DT is for Marvell stuff.

The LPSS_SSP support was added by:
commit a0d2642e9296882cda3ad03ff3d9a6649cd70439
Author: Mika Westerberg <mika.westerberg@linux.intel.com>
Date:   Tue Jan 22 12:26:32 2013 +0200

    spi/pxa2xx: add support for Intel Low Power Subsystem SPI

    Intel LPSS SPI is pretty much the same as the PXA27xx SPI except that it
    has few additional features over the original:

        o FIFO depth is 256 entries
        o RX FIFO has one watermark
        o TX FIFO has two watermarks, low and high
        o chip select can be controlled by writing to a register

    The new FIFO registers follow immediately the PXA27xx registers
but then there
    are some additional LPSS private registers at offset 1k or 2k from the base
    address. For these private registers we add new accessors that
take advantage
    of drv_data->lpss_base once it is resolved.

    We add a new type LPSS_SSP that can be used to distinguish the LPSS devices
    from others.
