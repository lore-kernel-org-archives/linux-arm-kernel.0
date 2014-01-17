From: b32955@freescale.com (Huang Shijie)
Date: Fri, 17 Jan 2014 10:02:28 +0800
Subject: [PATCH v4 0/7] mtd: spi-nor: add a new framework for SPI NOR
In-Reply-To: <CAD6G_RRNg-uRtKnnVgJYpUGPsKecAUm9mwETVJsCsaGSuL2eCw@mail.gmail.com>
References: <1387950629-27448-1-git-send-email-b32955@freescale.com>
 <CAD6G_RTnNQgeJM8Tc16Sc1_n29d=V9sJN1ePrOAn5YzM+GujMQ@mail.gmail.com>
 <52D7A237.8@freescale.com>
 <CAD6G_RRNg-uRtKnnVgJYpUGPsKecAUm9mwETVJsCsaGSuL2eCw@mail.gmail.com>
Message-ID: <20140117020226.GB27652@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 16, 2014 at 03:09:13PM +0530, Jagan Teki wrote:
> >>>     After this patch, the layer is like:
> >>>                     MTD
> >>>           ------------------------
> >>>                    spi-nor
> >>>           ------------------------
> >>>                    m25p80
> >>>           ------------------------
> >>>                 spi bus driver
> >>>           ------------------------
> >>>                 SPI NOR chip
> 
> Just for looking on your new framework, is that above link correct.
> I guess it should be MTD -- m25p80 -- spi-nor -- spi bus driver -- SPI NOR chip

I do not think so.
The spi-nor layer does not contact with the spi bus driver directly.

> >> 3) Can you explain your framework precisely take an example of like
> >> spi_controller_A with spi_flash_A
> >> and qspi_controller_B and qspi_flash_B - how will this new framework
> >> operates.
> >>
> > The framework is just cloned from the m25p80.c, and extract the common code,
> > and provides more
> > hooks such as
> >
> > @prepare/unpreare: used to do some work before or after the
> >              read/write/erase/lock/unlock.
> >     @read_xfer/write_xfer: We can use these two hooks to code all
> >              the following hooks if the driver tries to implement them
> >              by itself.
> >     @read_reg: used to read the registers, such as read status register,
> >              read configure register.
> >     @write_reg: used to write the registers, such as write enable,
> >              erase sector.
> >     @read_id: read out the ID info.
> >     @wait_till_ready: wait till the NOR becomes ready.
> >     @read: read out the data from the NOR.
> >     @write: write data to the NOR.
> >     @erase: erase a sector of the NOR.
> >
> 
> My basic question is like I have a qspi spi controller in my SOC and I
> designed two boards B1 and B2

okay.

> B1 with quad spi controller connected with non-flash as a slave and B2
> with quad spi controller connected
> with quad flash as a slave.
You can use the framework for B2. But for B1, you should not use the framework,
since this framework is just for the SPI-NOR. If you do not connected with
a NOR, i think it's better to code another driver for your controller.

thanks
Huang Shijie
