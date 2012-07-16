From: andreasgretler@googlemail.com (Andreas Gretler)
Date: Mon, 16 Jul 2012 13:23:42 +0200
Subject: MX28EVK mainline 3.5-Patchs-3.5-rc5 sgtl5000 record not working
In-Reply-To: <20120711085244.GA22640@shlinux2.ap.freescale.net>
References: <CAHE2-smsOufHjfyjKARcwHve4cGqWeM8y7ALxcJkaqLiZBNoSw@mail.gmail.com>
 <20120711031446.GB14060@S2101-09.ap.freescale.net>
 <20120711085244.GA22640@shlinux2.ap.freescale.net>
Message-ID: <CAHE2-snYoZB8tTOaZ29nxOU3KNBKut_EaGif_LKNQx9VMNii=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I can see the same problem at my side.
> Usually it's caused by clock issue.
> I will try to fix it tomorrow when have time.
>
> Regards
> Dong Aisheng
>
 Hi,

i did a bit more research on it. Before the change to common clock
framework, it seems that I can toggle the headphone and adc from Mic
to Line in. The headphone toggle to direct output works, but
unfortunately if i toggle the ADC input source to Line-In  the
recorded sound is only a noisy signal.

I test several past version, but I can not find a version where the
recording function for Line-In works.


I try to understand the saif-code, but i does not understand why not
all clk_enable are replaced by clk_prepare_enable. Can anyone explain
that? I replaced the clk_enable clk_prepare_enableand the board does
not crash, but there is an input/output error.

                /*
                 * If the saif's master is not himself, we also need to enable
                 * itself clk for its internal basic logic to work.
                 */
                if (saif != master_saif) {
                        clk_enable(saif->clk);
                        __raw_writel(BM_SAIF_CTRL_RUN,
                                saif->base + SAIF_CTRL + MXS_SET_ADDR);
                }


Another question is about the initial clock rate for the saif internal
logic. Befor the clock_mx28.c was deleted, there was an
clk_set_rate(&saif1_clk, 24000000); for internal logic. Where it is
now being made? I did not found it.

I'm new to driver development and I want to develop a driver for the
Cirrus cs5381 ADC Codec. That's why I want to understand the saif
code.  The codec is pretty simple, because it can be only configured
the data output format and the Master/slave Clock mode.  Unfortunately
i would like to get the codec working in master mode with MCLK is
driven by external clock source to the codec. I see in the source code
that only EXTMSTR0 mode is implemented. I would like to get the DIRECT
mode working, and use SAIF1 in Slave mode for recive only.  For my
understanding in the SGTL5000 drive, the SAIF1 works in slave mode and
get it BITCLK and LRCLK from Saif0. I think and hope that the changes
to get the Directmode working is not very much.  The Codec provide the
BITCLK and LRCLK to the cpu . But I don't unterstand to handle that
each Saif must have a master, described in the mxs-saif.c comment.
Because in my hardware setup I only need SAIF1 in Slave mode. Can you
give me a hint howto handle this?

Best regards Andreas
