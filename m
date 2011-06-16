From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 16 Jun 2011 16:34:35 +0800
Subject: Slow spi_sync() on pxa2xx_spi
In-Reply-To: <20110616082112.GA10075@excalibur.local>
References: <20110616082112.GA10075@excalibur.local>
Message-ID: <BANLkTikuo_fHbw9FFMtorpg15vOnXMK-+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 16, 2011 at 4:21 PM, Stefan Schmidt
<stefan@datenfreihafen.org> wrote:
> Hello.
>
> I'm working on the Imote2 (pxa27x based) platform [1] which includes a
> radio chip (cc2420, IEEE 802.15.4) connected over SPI [2].
>
> The problem I'm facing is that the spi_sync() call of the driver to
> write/read from the registers over the SPI bus takes up to 26 milli
> seconds. The minimum I measured was 500 micro seconds for the call.
>
> That creates a problem as the workflow to send a frame over the radio
> includes to write to a spi register for sending out the frame from a
> pre-filled FIFO. Then wait up to 320 micro seconds for a GPIO to raise
> and polling a status register until a TX_ACTIVE bit is no longer set
> afterwards.
>
> But the first register write to initiate the sending already takes so
> long that the GPIO is already low again and the TX_ACTIVE is also gone
> when I come back from the spi_sync() call.
>
> It really smells like I'm doing something seriously wrong here. For
> the pxa2xx_spi driver I already tried various options without any
> difference I could see. Enable/disbale DMA, different tx/rx
> thresholds, different dma burst sizes, different timeout, etc.
>
> I can only explain the long time with some sleeping in SPI while
> other parts are scheduled. Is there a way to avoid this for SPI? Or
> is there an API I did not found yet to cover my needs?
>
> The measurement is done with getnstimeofday btw and I verified that a
> basic operation like two multiplications are down in the 5 micro
> seconds area which gives me faith that the measurements should be
> correct:
>
> getnstimeofday (&before);
> ret = spi_sync(lp->spi, &msg);
> getnstimeofday (&after);
>
> result = timespec_sub(after, before);
> printk("Strobe time: %lu secs and %lu nsecs (strobe %i)\n", (long)result.tv_sec, result.tv_nsec, addr);
>
> I'm out of ideas what to change here. The only option, I want to
> avoid, is trying to drive the SPI pins manually and see if I have
> better results with bit-banging it myself.

What is the SPI frequency?

For PIO, the transfer actually happens in the interrupt handler so it's
supposed to be fast (did you enable threaded IRQ by the way?).

And since the transfer happens on message base, what is the size
of each of your message? And if it could be enlarged to big blocks.

>
> regards
> Stefan Schmidt
>
> [1] Board: http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/arm/mach-pxa/stargate2.c
> [2] Driver:
> http://linux-zigbee.git.sourceforge.net/git/gitweb.cgi?p=linux-zigbee/kernel;a=blob;f=drivers/ieee802154/cc2420.c;h=50761de6eb2d87014b6e43daa4ed642319d10567;hb=6a1a3375886ba69b1969ceb5df3007a4f1791d27
>
