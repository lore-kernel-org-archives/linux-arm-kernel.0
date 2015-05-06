From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 6 May 2015 12:01:35 +0100
Subject: [PATCH v4 5/5] arm64: dts: Add dts files for Hisilicon Hi6220 SoC
In-Reply-To: <CAD6h2NRtni=+pwkt7ng-gC_iu5B3+0mxbi96Pj01OY+PkfKBYA@mail.gmail.com>
References: <1430827599-11560-1-git-send-email-bintian.wang@huawei.com>
 <1430827599-11560-6-git-send-email-bintian.wang@huawei.com>
 <20150505171349.GA30215@leverpostej> <5549877C.10408@huawei.com>
 <5549B9CC.1040709@huawei.com> <20150506093022.GB31001@leverpostej>
 <CAD6h2NRtni=+pwkt7ng-gC_iu5B3+0mxbi96Pj01OY+PkfKBYA@mail.gmail.com>
Message-ID: <20150506110135.GD707@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 06, 2015 at 11:38:43AM +0100, Haojian Zhuang wrote:
> On 6 May 2015 at 17:30, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Wed, May 06, 2015 at 07:50:52AM +0100, Bintian wrote:
> >> Hello Mark,
> >>
> >> On 2015/5/6 11:16, Bintian wrote:
> >> > Hello Mark,
> >> >
> >> > On 2015/5/6 1:13, Mark Rutland wrote:
> >> [...]
> >> >>> +        uart0: uart at f8015000 {    /* console */
> >> >>> +            compatible = "arm,pl011", "arm,primecell";
> >> >>> +            reg = <0x0 0xf8015000 0x0 0x1000>;
> >> >>> +            interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
> >> >>> +            clocks = <&ao_ctrl HI6220_UART0_PCLK>, <&ao_ctrl
> >> >>> HI6220_UART0_PCLK>;
> >> >>> +            clock-names = "uartclk", "apb_pclk";
> >> >>> +        };
> >> >>
> >> >> In a previous discussion [1] the UART on HI6220 was described as not
> >> >> fully PL011 compliant, with a number of differences (e.g. the FIFO
> >> >> length).
> >> >>
> >> >> Given that, I feel somewhat uncomfortable with the current compatible
> >> >> string list. What exactly are those differences? We may need a more
> >> >> specific compatible string (even if in addition to those existing ones),
> >> >> or perhaps other properties.
> >> > The small system can be booted and the console also works well without
> >> > changing any code of driver amba-pl011.c, so I think the compatible
> >> > string is OK for this patch set.
> >> >
> >> > Hisilicon do some performance enhancements based on PL011, but the
> >> > current driver "amba-pl011.c" also works on hi6220 without those
> >> > enhancements driver code.
> >> Checked with Hisilicon chip designer, the UART0 is used for DEBUG
> >> console and compliant with PL011 fully.
> >
> > I think that given that we know the UART is not quite a PL011 we should
> > add an additional compatible string just in case some difference crops
> > up later that is problematic.
> >
> > So we'd have something like:
> >
> >         compatible = "hisilicon,hi6220-uart", "arm,pl011", "arm,primecell";
> >
> > That way we can add any optimisations or workarounds later as required.
> >
> 
> There's no code to handle the feature of hi6220 uart in mainline.

Sure, I wasn't suggesting that there was.

> It's meaningless to append "hisilicon,hi6220-uart" at here. I think
> it's only required when those uart code are merged into mainline.

I disagree. Given that the UART is not quite a PL011, it is likely to
behave differently under certain circumstances, and may have its own
errata that need to be worked around.

Even if the driver happens to currently work with it, a driver change
could easily break that. By being explicit from the outset that this is
a hi6220-specific PL011 variant, we can target workarounds far more
effectively later, without requiring DTB updates.

Having the additional string costs us nothing today.

Thanks,
Mark.
