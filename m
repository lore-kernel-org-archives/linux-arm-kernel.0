From: arasv@magellan-technology.com (Aras Vaichas)
Date: Wed, 27 Oct 2010 12:00:53 +1100
Subject: at91: input overruns question
In-Reply-To: <20101026064906.GN8554@pengutronix.de>
References: <AANLkTinbThMFXd1KpuMRYNJREpjGa6RNBH9R1SM955Sd@mail.gmail.com>
	<20101026064906.GN8554@pengutronix.de>
Message-ID: <AANLkTikrxTcLCv_8HkE76Th466HTbU2TshKTqw2DcRRh@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/10/26 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Hello Aras,
>
> On Tue, Oct 26, 2010 at 05:19:30PM +1100, Aras Vaichas wrote:
>> I'm updating our production kernel to 2.6.33.7-rt29 for an at91rm9200.
>> This is the newest version supported by RT.
>>
>> I've noticed that the age-old debug serial input overrun(s) issue has
>> gotten far worse and I can no longer use the cursor keys at all. i.e.
>> no history on serial console or vi.
>>
>> As the kernel version numbers have gone up, the problem seems to have
>> gotten worse.
>>
>> Is there anything that I can do to make it a bit more usable?
>>
>> Any .config changes?
>>
>> Is it worse because of the RT patches?
>>
>> Please feel free to point me to any previous posts discussing the
>> issue, or solutions.
> Where does the warning come from?

The warning comes from drivers/char/n_tty.c, function n_tty_receive_overrun()


> How big is the fifo in the at91 serial device?

The DBGU (debug serial port) doesn't have one. The idea is that it's
supposed to use the PDC (Peripheral DMA Controller)

There is this comment in /arch/arm/mach-at91/at91rm9200_devices.c:

static struct atmel_uart_data dbgu_data = {
    .use_dma_tx = 0,
    .use_dma_rx = 0,        /* DBGU not capable of receive DMA */

So I guess there is no DMA for the DBGU receive. Also, AFAIK, it
shares an IRQ with the RTC. But the RTC only goes off once a second.

The only reason that I've brought it up is that I've never seen it
this bad. It barely happened in 2.4.x, 2.6.19 was OK, 2.6.26 got worse
and now the DBGU is almost a lost cause in 2.6.33.7-rt29.

I can try rebuilding this kernel without the RT patches and see if
that makes a difference, but my application developers really want as
much performance as they can get at this point.

Aras
