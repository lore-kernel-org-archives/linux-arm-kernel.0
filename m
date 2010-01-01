From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 1 Jan 2010 20:29:16 +0000
Subject: 21285 serial driver deadlock(?) fix
In-Reply-To: <1262039226.28196.125.camel@localhost>
References: <1262039226.28196.125.camel@localhost>
Message-ID: <20100101202916.GD16220@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 28, 2009 at 05:27:06PM -0500, Steve Moskovchenko wrote:
> I've modified the ISR to call a different version of stop_tx, which uses
> disable_irq_nosync() instead. This gave me a working console.

That's right - however, I'm not sure whether the stop_rx also needs
to be a _nosync version.

> Another issue with the driver is the baud rate calculation, which seems
> broken for me. I had to comment out the lines that write to the BRG
> register (not in this patch), but this may be a result of my board using
> a different clock rate than a real EBSA285. Maybe I will look into that
> later.

Works for me.  Could be that your 21285 is clocked at a different rate,
in which case the 21285 timers are also going to be wrong.  You need to
specify the 21285 clock rate to the booting kernel via ATAGs or the
"mem_fclk_21285=" command line option.

There is no way for the kernel to autodetect this; it must be passed to
the kernel in some manner from something like a boot loader.
