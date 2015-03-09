From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 Mar 2015 15:58:40 +0000
Subject: [PATCH v5] drivers/tty: amba: defer probing DMA availability
 until hw_init
In-Reply-To: <CAL_Jsq+1ayOsYH+dyexnyiLTuW4=ervVFdU6HL7GLtKQGCt9Ew@mail.gmail.com>
References: <1424969811-11197-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1424969811-11197-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <CAL_Jsq+1ayOsYH+dyexnyiLTuW4=ervVFdU6HL7GLtKQGCt9Ew@mail.gmail.com>
Message-ID: <20150309155840.GT8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 03, 2015 at 10:13:21AM -0600, Rob Herring wrote:
> On Thu, Feb 26, 2015 at 10:56 AM, Jorge Ramirez-Ortiz
> <jorge.ramirez-ortiz@linaro.org> wrote:
> > Fix a race condition that happens when device_initcall(pl011_dma_initicall)
> > is executed before all the devices have been probed - this issue was observed on
> > an hisi_6220 SoC (HiKey board from Linaro).
> >
> > The deferred driver probing framework relies on late_initcall to trigger
> > deferred probes so it is just possible that, even with a valid DMA driver ready
> > to be loaded, we fail to synchronize with it.
> >
> > The proposed implementation delays probing of the DMA until the uart device is
> > opened. As hw_init is invoked on port startup and port resume - but the DMA
> > probe is only required once - we avoid calling multiple times using a new field
> > in uart_amba_port to track this scenario.
> >
> > This commit allows for subsequent attempts to associate an external DMA if the
> > DMA driver was deferred at UART hw_init time.
> >
> > Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> 
> You need to send this to Greg KH and linux-serial if you want it applied.

ARM PRIMECELL UART PL010 AND PL011 DRIVERS
M:      Russell King <linux@arm.linux.org.uk>
S:      Maintained
F:      drivers/tty/serial/amba-pl01*.c
F:      include/linux/amba/serial.h

And you really should wait for _my_ approval and ack, especially as I've
already highlighted concerns in previous replies to the change of DMA
management thing.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
