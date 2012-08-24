From: marex@denx.de (Marek Vasut)
Date: Fri, 24 Aug 2012 17:38:45 +0200
Subject: SLAVE Side SPI kernel driver development
In-Reply-To: <CAOMZO5Ds6NKsTCptQXDGZDJasb119hYWqXMzX8nG5WFArysL7A@mail.gmail.com>
References: <1345820228.87750.YahooMailNeo@web29604.mail.ird.yahoo.com>
 <CAOMZO5Ds6NKsTCptQXDGZDJasb119hYWqXMzX8nG5WFArysL7A@mail.gmail.com>
Message-ID: <201208241738.45601.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Fabio Estevam,

> On Fri, Aug 24, 2012 at 11:57 AM, Bastelli Carlo (yahoo)

CCing SPI list

> <carlo_bastelli@yahoo.it> wrote:
> > Hello, I'm Carlo, I have a difficult task at work, my boss asked me to
> > develop
> > 
> >  a driver SPI slave side on embedded ARM processor running Linux.
> > 
> > Precisely linux occur on the SPI bus as a slave, not master as required
> > by the hierarchical structure of the current kernel. The new driver
> > will
> > 
> >  receive via interrupt and respond when selected by its chip select.

So a soft-spi ? It's gonna be slow as hell and unstable too.

> >  Can
> >  anyone suggest the best way to develop this driver?

Get a CPU which has SPI-slave capable IP, start from there. If you were to 
implement soft-spi this way, you'd have to use FIQ on ARM, to be able to handle 
stuff with reasonable latency ... check how the ps/2-gpio driver is done in 
Linux ... I tried it, it barely worked, you don't want to go down that road.

> >  Personally, I
> > 
> > have identified two main roads, the first if possible to exploit the
> > structure SPI master driver

Not happening. You'd have to split the parts from the struct spi_master into 
common and master-only parts. That's for starters.

> > with a few tricks that now I can not
> > define. The second most radical, write a driver for a UART like, but
> > managing the SPI device.
> > Thank you for any suggestions or examples.

First of all, the SPI slave mode is COMPLETELY different from the master mode. 
You need to react on incoming CS-low ASAP, which might turn out to be a problem 
on it's own. Then, even if you do, you do not know how long the transfer is 
going to be, so you need to allocate enough buffers as the transfer progresses 
onwards.

In case of your soft-spi, how do you plan to sample the CLK line to sync clock?

> Marek got spi slave running on a mx28. See his patch:
> http://www.spinics.net/lists/arm-kernel/msg190860.html

This was tested (and developed) on this board:
http://www.denx-cs.de/?q=M28

The userland code is really easy too, simply pump it into spidev or read from 
it. But all that is only possible because of the SPI IP in the mx28 is nice.

> Regards,
> 
> Fabio Estevam

Best regards,
Marek Vasut
