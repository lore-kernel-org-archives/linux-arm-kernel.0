From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 31 Dec 2010 18:23:25 +0000
Subject: [PATCH] ARM: add PrimeCell generic DMA to PL011
In-Reply-To: <AANLkTi=uhMyDySAxbZK4XKU6Z4AbkjVc29L4idc0sxLf@mail.gmail.com>
References: <1286357526-5570-1-git-send-email-linus.walleij@stericsson.com>
	<20101222141006.GA19852@n2100.arm.linux.org.uk>
	<AANLkTi=uhMyDySAxbZK4XKU6Z4AbkjVc29L4idc0sxLf@mail.gmail.com>
Message-ID: <20101231182325.GA5012@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 22, 2010 at 06:09:22PM +0100, Linus Walleij wrote:
> There *may* be a corner case when you're transferring
> an even multiple of the burst size though, then you can
> *maybe* get into the situation you're describing. Such as
> paste a buffer with n MOD 8 bytes, but I haven't
> been able to provoke it :-/ (and no hardware here sadly).

This will only happen if you send all 8 bytes without triggering a
RTIM interrupt, and your DMA controller reads all 8 bytes upon receiving
the burst request.

If you send 4 bytes, pause, 4 bytes, and your DMA is only transferring
when 8 bytes have been received then you won't see the problem (as after
the first four bytes are received, you'll get a RTIM interrupt, and
another RTIM after the second group of four bytes.

I'm not sure that I'd trust pasting characters into a terminal to
guarantee that we receive all 8 bytes as a single back-to-back burst.

echo -n 01234567 >/dev/ttySn

where /dev/ttySn is the uart on your host PC to which your terminal
program is attached.  If you can't provoke it with fast baud rates,
try slowing down the baud rate so the 32-bit period takes longer to
expire - your DMA controller may not be reading all data from the
FIFO before this period expires, thereby allowing the RTIM interrupt
to occur.

Note: I've no idea how the ST Micro parts operate - you're setting the
DMA threshold to 16 bytes, yet the FIFO is 64 bytes, but you're asking
the DMA controller to do bursts of 32 bytes.  What's the effect of
IFLS on the DMA thesholds too?  Does that result in the DMA BREQ
signal only being activated after 32 bytes and the ST_UART011_DMAWM
register being ignored?  If so that could mean you need to send 32
bytes instead of 8.  Or maybe it's 16 bytes?


Anyway, this is easy to work around.  Let's assume a 16-byte FIFO for
everything that follows.

Set a threshold of 8 characters for the DMA burst request to be triggered
in the PL011 and set the DMA to transfer a burst of 4 bytes.  This will
guarantee that bytes are left in the PL011 FIFO, which means we have the
conditions for the PL011 to generate a RTIM interrupt when there's a
pause of 32 bit times in the transmission no matter what.

In your RTIM interrupt handler, you disable and read data from the DMA
buffer as before.  However, you also check for characters in the FIFO
and empty those into the TTY buffers before re-enabling DMA.

What this means is that the DMA engine controller _absolutely_ _must_
respect the requested burst size and never transfer anything but the
requested burst size per burst request.  If the DMA engine controller
it is unable to make this guarantee, we need some way of ensuring that
the PL011 driver will never use RX DMA.

In other words:
- if you make use of the PL011's SREQ signal for the RX path, you lose.
- if you DMA 8 or more characters per BREQ for the RX path, you lose.

Lastly, I've confirmed what's going on on the PB926 - the PL080 DMA
controller is definitely violating the statement in B.4.1 below figure
B-3.  However, it's rather iffy that this is in an appendix rather than
the main text describing the behaviour of the DMA controller - given
the observed behaviour I believe this paragraph has been accidentally
left in the documentation.  This at least explains why it doesn't work
- and can _never_ work on this platform.
