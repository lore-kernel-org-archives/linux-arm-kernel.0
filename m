From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 25 Jan 2011 10:47:50 +0100
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
Message-ID: <AANLkTimReBj7QGw08imBV2JWJGwh-TO5oA+3kiFQZLq4@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 January 2011 22:22, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> So, for small transfers (less than half the FIFO depth), SREQ will be
> asserted to transfer a single word at a time, and LSREQ for the last
> word.  There shouldn't be any bursts from the DMA controller.

Actually, drilling into the datasheet we have this statement for the version
used in U8500:

-------------------
if data to be transferred in not multiple of 8 words, then:
* when Tx mode (DMAreqctl field of DCTRL register should be = 1),
  MCIDMABREQ will be asserted until less 8 words remain. After this
  SDI will assert MCIDMALBREQ for last words transfer to terminate
  the transfer.
* when Rx mode (DMAreqctl field of DCTRL register should be = 0),
  MCIDMABREQ will be asserted until less 8 words remain. After
  this SDI will assert MCIDMASREQ until 1 word remains and then
  it will assert MCIDMALSREQ to terminate the transfer.
-------------------

So the way I read it, the U8500 version of PL180 will do what you
describe for RX transfers (so as not to overwrite any memory)
but for TX it will simply read some extra bytes to make a
complete burst which is faster and then discard the remainder.

This wiring has consequences as we'll see later...

(I don't know if the original PL180 acually works the same, it may
just be some undocumented "feature"...)


> The second argument is that if you have a burst size of, say, 8 words
> and you program the DMA to transfer 4 words, it should _not_ transfer
> 8 words to the peripheral.
>
> > What it does is to emulate single requests below a certain
> > threshold by requesting one-word bursts. I think this is
> > primarily for SDIO, not card transfers.

> This should be handled in hardware, if not it's DMA controller specific
> as it shouldn't burst past the remainder of the transfer.  If your DMA
> controller does burst past the number of bytes in the transfer, surely
> that's something that your DMA controller code needs to work around?

Here is another snippet:

-------------------
For burst size = 1, if the data transfer is more than 7 words and the
data to be transferred is a multiple of 8 words, a single burst transfer
cannot be done, because when data transfer count reaches 8 words,
MCIDMALBREQ is generated and 1 word will be transferred from
memory to the SDI host FIFO. But as the DMA controller sees
MCIDMALBREQ, it terminates the transfer and the remaining 7
words are not be transferred to the Tx FIFO.
-------------------

So we must use a burst size of 8 for anything exceeding and
including 8 words. Else it will break. (Follows logically from the
first snippet in some way, likely the VHDL code just checks
the higher bits.)

Yet, if it tried to issue a burst request size 8 for n<8, nothing
would be transfered, and that's due to limitations in the PL180
derivates way of issuing the request signals, not in the DMA
controller.

So what the driver has to do is issue 1 word requests to avoid
issuing a single burst request when n<8, because of limitations
in the PL180 derivate.

It would require the same treatment no matter what DMA
engine is used on the other side.

So right now I believe this code actually belongs in the mmci
driver albeit with the addition of vendor spec flag, like
.odd_st_bursts for the ST Micro versions.

We're looking into another parameter here: for some packet
size say maybe < 512 DMA may just give overhead, and we may
want to resort to PIO. This would do away with the whole issue
in another way. But that's a separate issue that we need
to back up with measurements.

Yours,
Linus Walleij
