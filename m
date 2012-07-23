From: b29396@freescale.com (Dong Aisheng)
Date: Mon, 23 Jul 2012 17:29:39 +0800
Subject: MX28EVK mainline 3.5-Patchs-3.5-rc5 sgtl5000 record not working
In-Reply-To: <CAHE2-snYoZB8tTOaZ29nxOU3KNBKut_EaGif_LKNQx9VMNii=g@mail.gmail.com>
References: <CAHE2-smsOufHjfyjKARcwHve4cGqWeM8y7ALxcJkaqLiZBNoSw@mail.gmail.com>
 <20120711031446.GB14060@S2101-09.ap.freescale.net>
 <20120711085244.GA22640@shlinux2.ap.freescale.net>
 <CAHE2-snYoZB8tTOaZ29nxOU3KNBKut_EaGif_LKNQx9VMNii=g@mail.gmail.com>
Message-ID: <20120723092938.GB9427@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 16, 2012 at 07:23:42PM +0800, Andreas Gretler wrote:
Sorry for late reply, a little busy these days and did not have too much
time to research it.

> I'm new to driver development and I want to develop a driver for the
> Cirrus cs5381 ADC Codec. That's why I want to understand the saif
> code.  The codec is pretty simple, because it can be only configured
> the data output format and the Master/slave Clock mode.  Unfortunately
> i would like to get the codec working in master mode with MCLK is
> driven by external clock source to the codec.
> I see in the source code
> that only EXTMSTR0 mode is implemented. I would like to get the DIRECT
> mode working, and use SAIF1 in Slave mode for recive only.  For my
> understanding in the SGTL5000 drive, the SAIF1 works in slave mode and
> get it BITCLK and LRCLK from Saif0. I think and hope that the changes
> to get the Directmode working is not very much.  The Codec provide the
> BITCLK and LRCLK to the cpu . But I don't unterstand to handle that
> each Saif must have a master, described in the mxs-saif.c comment.
> Because in my hardware setup I only need SAIF1 in Slave mode. Can you
> give me a hint howto handle this?
> 
Hmm, the most quick method maybe saif as master and codec as slave since
current driver supports that.
If you really want the codec to be master, what i think you can try is:
1) make the saif driver support working on slave mode for record
Currently mxs-saif driver only supports master mode, mainly due to saif
tx can only work as master so we simply make saif as master by default to
codec for both rx/tx. But from spec, saif could be a slave to codec and
receive clocks from codec if only working on rx.
You may need change mxs_saif_set_dai_fmt a bit.
2) you probably also need set saif clkmux to DIRECT mode via
mxs_saif_clkmux_select.
3) If you want the saif to provide mclk to codec, i have tried that saif
can also output mclk when working on slave mode.
But i have no such board working like that, you may need give a try
if saif can work properly on that mode for record.

Regards
Dong Aisheng
