From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 6 Jan 2016 15:45:40 +0800
Subject: [RFC] spi: dw: support setting tmode dynamically
In-Reply-To: <CAFLsZf3pdk6EdTRoax7Mp5GGZoGKm4PuwMdG2nC-hr+StYwYQQ@mail.gmail.com>
References: <20151223192338.128e95a4@xhacker>
 <20151223121512.GV16023@sirena.org.uk>	<20151223202952.28be5bab@xhacker>
 <20160105161231.GG6588@sirena.org.uk>
 <CAFLsZf0LvrQ60GdLzp_5nPLVxSxVaPadgzT_7aL4SQzgvswQbA@mail.gmail.com>
 <20160106142340.34e2d334@xhacker>
 <CAFLsZf31bt+-uwTo3zBWkho3UxquRCeTmK3hNMrGLXkjwHanwA@mail.gmail.com>
 <20160106152201.7829bdd7@xhacker>
 <CAFLsZf3pdk6EdTRoax7Mp5GGZoGKm4PuwMdG2nC-hr+StYwYQQ@mail.gmail.com>
Message-ID: <20160106154540.15ff75a8@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ linux arm kernel

Dear Khoa,

On Wed, 6 Jan 2016 14:36:08 +0700 Khoa Dang Pham  wrote:

> Hi Jisheng,
> 
> For me, I use the "EEPROM Read" mode as well, but I am not sure if any
> other solution. We may need some feedbacks from other experienced
> developers.

Indeed, this is a common issue for spi-dw controllers, all spi-dw users
(FWICT, most users are arm based SoCs) are impacted.

> Could you please provide your solution? Any suggestion would be appreciated.

My solution is: implement and export one function dw_spi_set_mode(),
NOR flash driver call this function before and after transfer.

Thanks,
Jisheng

> Regards,
> Khoa Pham
> 
> 
> On Wed, Jan 6, 2016 at 2:22 PM, Jisheng Zhang <jszhang@marvell.com> wrote:
> > Dear Khoa,
> >
> > On Wed, 6 Jan 2016 14:04:30 +0700 Khoa Dang Pham wrote:
> >  
> >> Hi Jisheng,
> >>
> >> On Wed, Jan 6, 2016 at 1:23 PM, Jisheng Zhang wrote:  
> >> > Dear Khoa, Mark,
> >> >
> >> > On Wed, 6 Jan 2016 08:45:38 +0700 Khoa Dang Pham wrote:
> >> >  
> >> >> Hi Mark,
> >> >>
> >> >> May I provide a bit more info about the "EEPROM read" on this controller?
> >> >>
> >> >> According to the "DesignWare DW_apb_ssi Databook" (version 3.21b) provided
> >> >> by Synopsys, the EEPROM read is:
> >> >>
> >> >> "When TMOD = 2?b11, the transmit data is used to transmit an opcode and/or
> >> >> an address to the EEPROM
> >> >> device. Typically this takes three data frames (8-bit opcode followed by
> >> >> 8-bit upper address and 8-bit lower
> >> >> address). During the transmission of the opcode and address, no data is
> >> >> captured by the receive logic (as
> >> >> long as the DW_apb_ssi master is transmitting data on its txd line, data on
> >> >> the rxd line is ignored). The
> >> >> DW_apb_ssi master continues to transmit data until the transmit FIFO is
> >> >> empty. Therefore, you should
> >> >> ONLY have enough data frames in the transmit FIFO to supply the opcode and
> >> >> address to the EEPROM. If
> >> >> more data frames are in the transmit FIFO than are needed, then read data
> >> >> is lost.
> >> >> When the transmit FIFO becomes empty (all control information has been
> >> >> sent), data on the receive line
> >> >> (rxd) is valid and is stored in the receive FIFO; the txd output is held at
> >> >> a constant logic level. The serial
> >> >> transfer continues until the number of data frames received by the
> >> >> DW_apb_ssi master matches the value of
> >> >> the NDF field in the CTRLR1 register + 1."  
> >> >
> >> > I tried the following combinations:
> >> >
> >> > 1. "Transmit only" to send opcode and address, "Receive only" to read the
> >> > response
> >> >
> >> > 2. "Transmit and Receive" to send opcode and address, "Receive only" to read
> >> > the response
> >> >
> >> > 3. "Transmit and Receive" to send opcode and address, "Transmit and Receive"
> >> > to read the response
> >> >
> >> > 4. "Transmit and Receive" only to send opcode and address
> >> >
> >> > None of the above succeed. I only succeed when using
> >> >
> >> > 5. EEPROM Read to send opcode, address. I can get the correct NOR flash
> >> > content from the response.
> >> >  
> >>
> >> I met the same issue before. The issue might be caused by the CS
> >> signal is toggled
> >> when we changed the transfer modes during opcode transmission and data
> >> receiption.
> >>
> >> According to the document I referred before:
> >> "The slave select line is held high when the DW_apb_ssi is idle or
> >> disabled."
> >>
> >> In your first 4 options, you need to disable this controller to write
> >> to the CTRLR0 register
> >> in order to switch the transfer modes. The CS line changes from low
> >> level (active) to high
> >> level (inactive) during the configuration. The NOR flash sees this CS
> >> toggle as a reset and
> >> stops outputting requested data.  
> >
> > Thanks for the information. This could explain what I saw. So how to
> > patch the spi-dw driver to support reading from NOR flash? Except
> > configure the tmode dynamically, is there any other solution?
> >
> > Thanks very much for your input,
> > Jisheng
> >  
> >>
> >> Regards,
> >> Khoa Pham
> >>  
> >> > Thanks,
> >> > Jisheng
> >> >  
> >> >>
> >> >> Regards,
> >> >> Khoa Pham
> >> >>
> >> >> On Tue, Jan 5, 2016 at 11:12 PM, Mark Brown  wrote:
> >> >>  
> >> >> > On Wed, Dec 23, 2015 at 08:29:52PM +0800, Jisheng Zhang wrote:  
> >> >> > > On Wed, 23 Dec 2015 12:15:12 +0000 Mark Brown wrote:  
> >> >> > > > On Wed, Dec 23, 2015 at 07:23:38PM +0800, Jisheng Zhang wrote:  
> >> >> >  
> >> >> > > > > Currently the spi-dw tmode is fixed to SPI_TMOD_TR if cs_control is  
> >> >> > NULL, but we  
> >> >> > > > > need to set it as SPI_TMOD_EPROMREAD to read nor flash, my solution  
> >> >> > is to add and  
> >> >> > > > > export one functions to set the tmode, then the nor flash driver  
> >> >> > call it  
> >> >> > > > > before reading and set back to SPI_TMOD_TR after done.  
> >> >> >  
> >> >> > > > What does this mean - what is TMOD and why do we need to set it to read
> >> >> > > > NOR flash?  I've no information on this controller...  
> >> >> >  
> >> >> > > TMOD is one field of DW_SPI_CTRL0. Its available value could be:  
> >> >> >  
> >> >> > > 0: Transmit and Receive
> >> >> > > 1: Transmit only
> >> >> > > 2: Receive only
> >> >> > > 3: EEPROM Read  
> >> >> >  
> >> >> > > If the one spi nor flash is connected to the SPI host, so far I can only  
> >> >> > succeed  
> >> >> > > to read the nor flash content after setting the TMOD field as 3.  
> >> >> >
> >> >> > Why?  What does this mean in practical terms at the hardware level, what
> >> >> > is "EEPROM read"?  It sounds like there's some bigger issue here.
> >> >> >  
> >> >>  
> >> >  
> >>  
> >  
> 
