From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 10 Aug 2011 18:25:24 +0800
Subject: [PATCH] pxa/hx4700: Add Synaptics NavPoint (PXA27x SSP/SPI) driver
In-Reply-To: <1312970324.34060.YahooMailClassic@web29011.mail.ird.yahoo.com>
References: <1312970324.34060.YahooMailClassic@web29011.mail.ird.yahoo.com>
Message-ID: <CAMPhdO-PH2M-VyzqOHnUo7j54Ok8D=xuh1cX2F+KVL4fCkFKnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2011 at 5:58 PM, Paul Parsons <lost.distance@yahoo.com> wrote:
> Hi Eric,
>
>> > ? ? ? ?/* SSP 1 (NavPoint) */
>> > - ? ? ? GPIO23_SSP1_SCLK,
>> > + ? ? ? MFP_CFG_IN(GPIO23, AF2),? ? ? ? /* SSPSCLK */
>> > ? ? ? ?GPIO24_SSP1_SFRM,
>> > ? ? ? ?GPIO25_SSP1_TXD,
>> > ? ? ? ?GPIO26_SSP1_RXD,
>> > + ? ? ? MFP_CFG_OUT(GPIO102, AF0, KEEP_OUTPUT), /*
>> SYNAPTICS_POWER_ON */
>>
>> Setting low power mode state can be OR'ed with MFP_LPM_*,
>> what makes
>> the original pin mux configuration not usable here?
>
> Not sure I understand. In the case of GPIO23 (SSPSCLK) I switched the direction from output to input; none of the defines in mfp-pxa27x.h were applicable so I used MFP_CFG_IN directly. AFAIK the four wire GPIOs (23-26) aren't used anyway, so that change was really just for documentation.

Please check arch/arm/mach-pxa/include/mach/mfp-pxa27x.h

If GPIO23 needs to be configured as input when acting as SSP1_SCLK,
please modify that file instead, it's a fix to other platforms as well.

So the general guideline here is: to use the macros in mfp-pxa27x.h
as much as possible, since those are the standard definitions across
all pxa27x boards.

MFP_CFG_*() are solely used for internal purposes, please do not use
them directly.

>
>> For cleanness, you may want to separate this patch into
>> two:
>>
>> 1. the navpoint driver itself
>> 2. the support of this driver for hx4700 (board specific
>> code)
>
> Yes, that's easy.
>
>> Can we avoid using pxa_ssp_*() calls directly? As those are
>> for internal
>> usage purpose of the on-top drivers, e.g. SPI or audio. If
>> communication
>> with this device follows SPI protocol, please try hard to
>> make use of the
>> spi_*() API, and make it an spi_driver instead of a
>> platform_driver.
>
> AFAIK Linux doesn't provide an SPI slave side API. So I had little option other than to drive SSP directly.

Are you implying that the hx4700 is acting as a SPI slave? My original
understanding is hx4700 is communicating with an external touchpad
controller through SPI? If hx4700 is acting as a SPI slave, then it's true
there is no existing framework for that yet.

>
>> > +struct navpoint_platform_data {
>> > + ? ? ? int ? ? ? ? ? ? port;
>> /* PXA SSP port for pxa_ssp_request() */
>> > + ? ? ? void ? ? ? ? ? ?(*power)(int onoff);
>> > +};
>>
>> port doesn't need to be here if it's a SPI driver. And if
>> the existing
>> implementation of this (*power)() callback uses only the
>> GPIO, you
>> could specify gpio number directly here as device data.
>
> I can't use the SPI driver, per previous reply, so the SSP port needs to be defined somewhere; I suppose I could use the platform_device id instead of platform data. As for the callback, it wasn't obvious whether or not other platforms would use GPIOs for power on/off, so providing a callback covered all eventualities. I'm happy to simplify by using a GPIO number though.
>
> Regards,
> Paul
>
