From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 25 Jan 2011 09:33:07 +0100
Subject: [PATCH] ARM: add PrimeCell generic DMA to MMCI/PL180
In-Reply-To: <20110124212228.GN24104@n2100.arm.linux.org.uk>
References: <1286358159-6994-1-git-send-email-linus.walleij@stericsson.com>
	<20101219163240.GA27929@n2100.arm.linux.org.uk>
	<20101219195959.GA28157@n2100.arm.linux.org.uk>
	<20101221135421.GS28157@n2100.arm.linux.org.uk>
	<20101221155935.GV28157@n2100.arm.linux.org.uk>
	<AANLkTin2fBLsq2YJHjZ=e+gmwWXWezH0t38bzsjiJ+i=@mail.gmail.com>
	<20110124160127.GA24104@n2100.arm.linux.org.uk>
	<AANLkTi=GmYoDYhKGpvzt2vHWSEb2b72cQbQfVc4PANdH@mail.gmail.com>
	<20110124212228.GN24104@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi=kMnXm+VU2V8HR98DhL1wVk6cJJQ0DtkV=yFqs@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 January 2011 22:22, Russell King - ARM Linux
<linux@arm.linux.org.uk>wrote:


> On Mon, Jan 24, 2011 at 10:06:53PM +0100, Linus Walleij wrote:
> > This was an addition from Per Forlin, IIRC the requirement
> > to not push more than one word at the time into the FIFO
> > below a certain threadhold is a requirement for the MMCI,
> > not the DMA engine.
>
> The MMCI has four DMA request signals:
> - BREQ (burst request)
> - SREQ (single request)
> - LBREQ (last burst request)
> - LSREQ (last single request)
>
> From PL181 TRM (DDI0205B) 2.3.2:
> For SREQ:
>        For receive: Asserted if data counter is
>        zero and receive FIFO contains more than
>        one and fewer than eight words.
>        For transmit: Asserted if fewer than eight
>        and more than one word remain for
>        transfer to FIFO.
>
> For BREQ:
>        For receive: Asserted if FIFO contains
>        eight words and data counter is not zero,
>        or if FIFO contains more than eight words.
>        For transmit: Asserted if more than eight
>        words remain for transfer to FIFO.
>
> For LSREQ:
>        For receive: Asserted if data counter is
>        zero and FIFO contains only one word.
>        For transmit: Asserted if only one word
>        remains for transfer to FIFO.
>
> For LBREQ:
>        For receive: Asserted if data counter is
>        zero and FIFO contains eight words.
>        For transmit: Asserted if only eight words
>        remain for transfer to FIFO.
>
> So, for small transfers (less than half the FIFO depth), SREQ will be
> asserted to transfer a single word at a time, and LSREQ for the last
> word.  There shouldn't be any bursts from the DMA controller.
>
> The second argument is that if you have a burst size of, say, 8 words
> and you program the DMA to transfer 4 words, it should _not_ transfer
> 8 words to the peripheral.
>
> > What it does is to emulate single requests below a certain
> > threshold by requesting one-word bursts. I think this is
> > primarily for SDIO, not card transfers.
>
> This should be handled in hardware, if not it's DMA controller specific
> as it shouldn't burst past the remainder of the transfer.  If your DMA
> controller does burst past the number of bytes in the transfer, surely
> that's something that your DMA controller code needs to work around?
>

Yes that indeed seems resonable. With the COH901318 DMA engine
it worked just fine without the burst threshold. Just want to give my
colleagues a chance to have a second opinion on this.


> > > +       /* Check for weird stuff in the sg list */
> > > +       /* shouldn't this be in the DMA engine driver? */
> > > +       for_each_sg(data->sg, sg, data->sg_len, i) {
> > > +               dev_vdbg(mmc_dev(host->mmc), "MMCI SGlist %d dir %d:
> length: %08
> > > +                        i, conf.direction, sg->length);
> > > +               if (sg->offset & 3 || sg->length & 3)
> > > +                       return -EINVAL;
> > > +       }
> >
> > This one is just overcautious and for SDIO we don't even want to do
> > such things, so it should be dropped altogether.
> >
> > The original intent was to avoid writing anything than 32bit words
> > into the register, and with the SDIO-modified versions you can
> > actually do that.
>
> Surely that's to do with the DMA controller though?
>

Absolutely.


> > So I'll drop it for the next iteration.
>
> Given that I've already heavily modified the code, it's probably better if
> you just let me know the answer... ;)
>

In any case I'm happy if you post/commit the MMCI support
you have, if there are problems we can certainly sort it out later
in any case.

Hm, does this mean you got it working with one of the
reference boards eventually?

Yours,
Linus Walleij
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110125/0f16c540/attachment-0001.html>
