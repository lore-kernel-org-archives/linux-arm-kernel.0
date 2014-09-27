From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 27 Sep 2014 13:18:14 +0100
Subject: [PATCH 2/4] serial: mxs-auart: use mctrl_gpio helpers for
 handling modem signals
In-Reply-To: <54269C34.8040702@elproma.com.pl>
References: <1411811197-12638-1-git-send-email-j.uzycki@elproma.com.pl>
 <1411811197-12638-3-git-send-email-j.uzycki@elproma.com.pl>
 <5426926C.60402@elproma.com.pl>
 <20140927105408.GD5182@n2100.arm.linux.org.uk>
 <54269C34.8040702@elproma.com.pl>
Message-ID: <20140927121814.GE5182@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 27, 2014 at 01:15:00PM +0200, Janusz U?ycki wrote:
> It means it is possible but not in Linux today?

It depends on your maximum interrupt latency.

> I think the problem is not interrupt delay, which is often much below 100us
> (we get ~10us delay on DCD).

http://archive.arm.linux.org.uk/lurker/message/20130724.145238.44ad37b5.en.html

   I can believe why this all happens, when you see USB interrupts taking
   upwards of 3ms to complete:

   Longest time: 3247506ns
   Longest irq: 24
   Longest handler: usb_hcd_irq+0x0/0x68

This no longer seems to be the case - the maximum interrupt time I'm seeing
on recent kernels is:

   Longest time: 382236ns
   Longest irq: 62
   Longest handler: mv_interrupt+0x0/0x948

My Dove kernel runs permanently with my own maximum interrupt latency
tracking enabled.

> Isn't the problem rather how to break DMA transmission fast?

There are two factors there.  The first is being able to tell the DMA
engine to stop, the second is the UART hardware FIFO draining.

> Hardware flow control not always requires to stop transmission
> immediately.

No.  Hardware flow control is normally implemented at the UART, and
CTS is normally implemented to prevent the transmitter starting a new
character.  Any in-progress character is completed before the transmitter
stops, so that there are no errors.

At least, this is the behaviour found on the UARTs which I've seen
implementing hardware flow control, and it is the only sane way to do
it.

> Usually delay of some chars is acceptable if remote receiver
> implements low/high water mark (overflow trigger lower than RX FIFO size).

The receiver you may be communicating with may have a receive FIFO of
only 16 characters.  It may deassert CTS when it reaches half-full state.
That leaves you with only 8 characters to send before it overflows.  At
115200 baud, you will have started to send the 9th characters by 700us.

However, that isn't the full picture.  The full picture is that CTS is
normally controlled by software as well, and depends on the availability
of buffers to store characters.  There's latency at the remote end to
deassert CTS in software when the software buffers reach their high
watermark, and there's the hope that there is sufficient room in those
buffers to take the excess characters that the remote end may continue
to send.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
