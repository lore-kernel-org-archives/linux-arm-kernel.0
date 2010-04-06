From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Tue, 6 Apr 2010 08:44:18 +0300
Subject: [PATCH v2 1/3] spi: implemented driver for Cirrus EP93xx SPI
	controller
In-Reply-To: <s2n56d259a01003311715ke5b93a96v9d453ec32f08ec29@mail.gmail.com>
References: <cover.1268930557.git.mika.westerberg@iki.fi>
	<9de3769ae253830fb0eebc98d299137c59c69b8c.1268930557.git.mika.westerberg@iki.fi>
	<56d259a01003250649ubf0e32ejc15e4f3b45ec43cd@mail.gmail.com>
	<20100325184316.GB20512@gw.healthdatacare.com>
	<s2n56d259a01003311715ke5b93a96v9d453ec32f08ec29@mail.gmail.com>
Message-ID: <20100406054418.GA27465@gw.healthdatacare.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 01, 2010 at 01:15:20AM +0100, Martin Guy wrote:
> On 3/25/10, Mika Westerberg <mika.westerberg@iki.fi> wrote:
> >  > > This patch adds an SPI master driver for the Cirrus EP93xx SPI controller found
> >  > >  in EP93xx chips (EP9301, EP9302, EP9307, EP9312 and EP9315).
> >  > >
> >  > >  Driver currently supports only interrupt driven mode but in future we may add
> >  > >  polling mode support as well.
> 
> I've been staring more at this again and it looks (2 clock
> strangenesses and extensive control reg setting apart) like good code.
> I have another question: like the Cirrus driver, this takes 100% CPU
> doing busy wait for the current transfer to complete.

Hi,

I tried to find out whether the driver did something wrong to get
into busylooping but couldn't find anything. In case of MMC/SD
cards, through mmc_spi, transfer sizes are >= 512 bytes at a time
and FIFO size is only 8 bytes (or words) so the CPU is expected to
be pretty busy serving interrupts from the SSP.

I'm about to post updated series with your comments addressed. I
also added support for polling transfers.

> Given that this driver is interrupt-based, is there any reason why it
> can't do something else in the meanwhile?
> Not that that's a reason not to include it in 2.6.35 - it works well
> and we can think whether to make it more efficient in N+1...
