From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Wed, 22 Feb 2017 17:43:02 +0100
Subject: [PATCH v2 0/8] ARM64: Initial Marvell IAP140 enablement
In-Reply-To: <CAL_JsqJmv--wP+gEt27ZbTT+8GeqKhYc=x3MTPBiz2Jr2wys8A@mail.gmail.com>
References: <20170222022929.10540-1-afaerber@suse.de>
 <CAL_JsqJmv--wP+gEt27ZbTT+8GeqKhYc=x3MTPBiz2Jr2wys8A@mail.gmail.com>
Message-ID: <22850768-8ea8-3d56-5c34-31f24ca3b487@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

Am 22.02.2017 um 14:34 schrieb Rob Herring:
> On Tue, Feb 21, 2017 at 8:29 PM, Andreas F?rber <afaerber@suse.de> wrote:
>> One limitation is currently the lack of an IAP140 clk driver. Patch 4/4 works
>> around that for UART0 with a fixed-clock.
> 
> The PXA1928 clock driver should be close to what you need. They are
> supposed to be very similar.

Where do you see that in mainline? Not in drivers/clk/pxa/ at least. I'm
certain the acorn-marvell tree has a PXA1908 clk driver somewhere, too,
I just haven't ported it yet.

>> Andreas F?rber (8):
>>   Documentation: arm: Marvell: Document IAP140
>>   tty: serial: Suppress deprecated SERIAL_PXA on arm64
>>   tty: serial: 8250_pxa: Implement mmp earlycon
> 
> You should not use the pxa serial driver. AFAICT, it was separate to
> add DMA support, but now the base 8250 driver supports DMA. The base
> 8250 driver works with the PXA1928 and should also work with the
> PXA1908.

Do you personally have one? I didn't spot a pxa1928 DT in mainline.

So, by my reading both 8250_of.c and 8250_pxa.c list "mrvl,mmp-uart" for
the platform driver. Is that really intentional?

What the early_pxa earlycon does is set the register shift and then
reuse the 8250 core - that looks perfectly valid to me. Are you possibly
mixing that up with the non-8250 pxa serial driver that I am already
suppressing one patch earlier?

While at it, are you aware that we have two drivers, one pxa and one
mmp, that bind to "marvell,pdma-1.0"? That seemed wrong to me, too.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
