From: govindraj.ti@gmail.com (Govindraj)
Date: Mon, 23 Jan 2012 15:30:01 +0530
Subject: omap-serial RX DMA polling?
In-Reply-To: <alpine.DEB.2.00.1201221718190.26641@utopia.booyaka.com>
References: <alpine.DEB.2.00.1201221718190.26641@utopia.booyaka.com>
Message-ID: <CAAL8m4wcSfhjxg0Lyo-W7DQ85rikb6asRds95hwQQNTDXe2YKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 23, 2012 at 6:03 AM, Paul Walmsley <paul@pwsan.com> wrote:
>
> Hello Govindraj
>
> while trying to track down some of the serial-related PM issues in
> v3.3-rc1, I noticed that the omap-serial.c driver sets a 1 microsecond
> polling timer when DMA is enabled (uart_dma.rx_timer) (!) ?This seems
> quite broken from both the DMA and PM points of view.
>

Poll rate is used for doing tty_insert_flip_string for pushing data to
user space
to keep faster response to any client device over uart, some Bt chips
expect faster
response when data on uart arrives and packet should be pushed out immediately.


> From a DMA point of view, the DMA transfer should automatically start
> when there is data to transfer, and stop when there is no data left, based
> on the DMA request lines. ?So timer-driven polling should not be needed at
> all.
>

its for tty_insert pushing data to tty stack.


> From a PM point of view, this short timer will effectively prevent the MPU
> from going into a low-power state whenever there is data in the FIFO.
> This will more than erase any energy consumption or CPU efficiency
> benefits of doing DMA. ?Interrupt-driven PIO should be much more efficient
> than this, since at least the MPU can enter a low-power state while
> waiting for the FIFO to fill.
>

yes we maintain 3 secs timeout period and keep uart active in DMA case.
since rx is asynchronous we cant afford to stop and start dma every time after
x bytes after every rx data completion call back.


> So basically, the broken timeout calculations used in the interrupt-driven
> PIO mode (which set a 1 microsecond PM QoS constraint), plus the 1
> microsecond polling timer used in DMA mode, mean that this driver is
> pretty bad from a PM perspective.
>
> I sent some patches to fix the interrupt-driven PIO receive part of the
> problem, which you've probably seen. ?But I'm hoping that you can describe
> further why the driver needs this RX DMA polling timer? ?Shouldn't it be
> unnecessary? ?If it's truly unavoidable, then we should presumably not
> even bother with RX DMA at all.
>
>
>
> ?- Paul
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
