From: robh@kernel.org (Rob Herring)
Date: Wed, 22 Feb 2017 13:27:29 -0600
Subject: [PATCH v2 0/8] ARM64: Initial Marvell IAP140 enablement
In-Reply-To: <22850768-8ea8-3d56-5c34-31f24ca3b487@suse.de>
References: <20170222022929.10540-1-afaerber@suse.de>
 <CAL_JsqJmv--wP+gEt27ZbTT+8GeqKhYc=x3MTPBiz2Jr2wys8A@mail.gmail.com>
 <22850768-8ea8-3d56-5c34-31f24ca3b487@suse.de>
Message-ID: <CAL_JsqJhH7hqfdU9t8m=gY8c2qcA2aHNhmTTdV_HTFPp+YdF_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 22, 2017 at 10:43 AM, Andreas F?rber <afaerber@suse.de> wrote:
> Hi Rob,
>
> Am 22.02.2017 um 14:34 schrieb Rob Herring:
>> On Tue, Feb 21, 2017 at 8:29 PM, Andreas F?rber <afaerber@suse.de> wrote:
>>> One limitation is currently the lack of an IAP140 clk driver. Patch 4/4 works
>>> around that for UART0 with a fixed-clock.
>>
>> The PXA1928 clock driver should be close to what you need. They are
>> supposed to be very similar.
>
> Where do you see that in mainline? Not in drivers/clk/pxa/ at least. I'm
> certain the acorn-marvell tree has a PXA1908 clk driver somewhere, too,
> I just haven't ported it yet.

drivers/clk/mmp/clk-of-pxa1928.c

I ported/rewrote that from Marvell's 3.10 vendor tree.

>>> Andreas F?rber (8):
>>>   Documentation: arm: Marvell: Document IAP140
>>>   tty: serial: Suppress deprecated SERIAL_PXA on arm64
>>>   tty: serial: 8250_pxa: Implement mmp earlycon
>>
>> You should not use the pxa serial driver. AFAICT, it was separate to
>> add DMA support, but now the base 8250 driver supports DMA. The base
>> 8250 driver works with the PXA1928 and should also work with the
>> PXA1908.
>
> Do you personally have one? I didn't spot a pxa1928 DT in mainline.

Yes. It never got released and got abandoned. I got several drivers
cleaned up to support it and the clock code in before that happened. I
had a in-progress DRM driver too. I was debugging why some monitors
worked and others didn't when I stopped working on it. I think the
board you are working on has the same ADV7533?

It's all up on my Linaro tree:
https://git.linaro.org/people/rob.herring/linux.git

> So, by my reading both 8250_of.c and 8250_pxa.c list "mrvl,mmp-uart" for
> the platform driver. Is that really intentional?

Humm, well I added support in commit 6ad991b699b4e to of_serial.c and
then it looks like it got copied to 8250_pxa.c recently. Not sure if
that really made sense or not. We should remove one of them.
8250_pxa.c looks fairly pointless to me. Turning a clock on/off in
resume/suspend is already supported by 8250_of.c (which doesn't have
the bug of turning off the console's clock in suspend). The only other
thing is the errata in serial_pxa_dl_write.

> What the early_pxa earlycon does is set the register shift and then
> reuse the 8250 core - that looks perfectly valid to me. Are you possibly
> mixing that up with the non-8250 pxa serial driver that I am already
> suppressing one patch earlier?

The earlycon core already sets up reg-shift for you.

I added earlycon support in commit a4c639b04f301d. I used "ns16650a"
as a fallback compatible string, so there's not an explicit PXA/MMP
compatible string there.

> While at it, are you aware that we have two drivers, one pxa and one
> mmp, that bind to "marvell,pdma-1.0"? That seemed wrong to me, too.

Yeah, it was drivers/tty/serial/pxa.c that I was thinking of. I was
incorrectly thinking 8250_pxa.c was that one.

Rob
