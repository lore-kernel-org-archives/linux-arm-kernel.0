From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 31 Jul 2012 23:33:26 -0700
Subject: [06/10,V2] spi: Add SPI driver for mx233/mx28
In-Reply-To: <20120801062838.GF1672@S2100-06.ap.freescale.net>
References: <1341555449-17507-6-git-send-email-marex@denx.de>
 <20120801033559.GB2323@roeck-us.net>
 <20120801045010.GC1672@S2100-06.ap.freescale.net>
 <201208010700.54829.marex@denx.de>
 <20120801052947.GA2400@roeck-us.net>
 <20120801055854.GE1672@S2100-06.ap.freescale.net>
 <20120801054228.GA2645@roeck-us.net>
 <20120801062838.GF1672@S2100-06.ap.freescale.net>
Message-ID: <20120801063326.GA2764@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 01, 2012 at 02:28:40PM +0800, Shawn Guo wrote:
> On Tue, Jul 31, 2012 at 10:42:28PM -0700, Guenter Roeck wrote:
> > On Wed, Aug 01, 2012 at 01:58:56PM +0800, Shawn Guo wrote:
> > > On Tue, Jul 31, 2012 at 10:29:47PM -0700, Guenter Roeck wrote:
> > > > Anyone up for writing some patches ? If not, I'll do it.
> > > > 
> > > Go ahead.
> > > 
> > Ok, will do. It isn't that simple, actually, since at least some of the drivers
> > also call spi_master_get(), and thus need two calls to spi_master_put() (or a
> > call to spi_master_put and a call to kfree).
> > 
> Hmm, are you saying that there must be a spi_master_put call matching
> spi_alloc_master?  I think we only need to have spi_master_get and
> spi_master_put matched.
> 
Yes, I think that may be so. Of course, I may be wrong, but ultimately that is
what almost all drivers do in the probe error path. Some of the drivers do it in
the remove path as well, though many don't. I suspect that all drivers using
spi_alloc_master() which do not call spi_master_put() in the remove function may
have a memory leak.

Someone who knows the spi infrastructure better than I should have a closer
look, though. The question is really quite simple: For example, in spi-atmel.c,
how is the allocated master freed in the _remove function ? If it doesn't need
the call to spi_master_put(), why do, for example, spi-stmp.c or spi-mpc52xx.c
call it ?

On the other side, I must admit I am getting more and more confused after
looking into the code. For example, the probe function error path in spi-mpc52xx.c
accesses the master's devdata after the call to spi_master_put(). If
spi_master_put() frees the memory as we think it does, the code would access
freed memory. The same happens in the remove path. And spi_master_put() is not
always called, meaning there is either a memory leak or I am completely confused.

Thanks,
Guenter
