From: marex@denx.de (Marek Vasut)
Date: Thu, 21 Mar 2013 00:35:52 +0100
Subject: [PATCH] mxs/spi: Add SPI slave mode operation DT prop
In-Reply-To: <CA+7tXihDGgkq_FALfGW_2xzcZc4wgm_YiAMepSjT4Y2b1ULd+w@mail.gmail.com>
References: <1345776161-9778-1-git-send-email-marex@denx.de>
 <CA+7tXihDGgkq_FALfGW_2xzcZc4wgm_YiAMepSjT4Y2b1ULd+w@mail.gmail.com>
Message-ID: <201303210035.52984.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Trent Piepho,

> On Thu, Aug 23, 2012 at 7:42 PM, Marek Vasut
> 
> <marex-ynQEQJNshbs@public.gmane.org> wrote:
> > This allows user to select the slave mode of operation of the controller.
> > This is by no means standard, see the binding documentation for details,
> > there is plenty of them. Sadly, such knowledge is not provided in the
> > chip documentation. Hopefully, this mode of operation might come useful
> > for people who do know very well what they are doing, otherwise this
> > should never be touched.
> 
> Thanks for posting this, as it's something I'm trying to get it working
> too.
> 
> You're right that the Freescale documentation says almost nothing
> about slave mode.  I found some STMP36xx on the rockbox site,
> http://www.rockbox.org/wiki/pub/Main/SigmaTelSTMP3xxx/stmp36xx-Datasheet-1-
> 02_050306.pdf, however it doesn't provide any more information about slave
> mode than the imx28 RM.  In fact it's virtually the same word for word,
> other than some bits that are marked reserved in the imx28 are defined in
> stmp36xx (wonder if the FIFO stuff is still there in the imx28?).
> What STMP36xx documentation did you find that had more information?

I spammed Freescale with service requests.

> > +		   - If the SPI master generates clock at n MHz, the speed
> > +		     of the SPI slave controller must be at least 4-8 times
> > +		     faster, this is due to the controller samples the CLK
> 
> When you say the SPI slave clock must be 4x higher than the master
> clock, do you mean the rate programmed for what would be the SPI clock
> in master mode: SSP_SCK in the HW_SSP_TIMING register.  Or the rate of
> the clock to the SSP block: SSPCLK as programmed via the CLKCTRL
> block's registers, e..g. HW_CLKCTRL_SSP1?

The SPI clock (aka. sampling clock of the SCK line).

> > +		   - The DMA has to wait indefinitelly for the arriving data.
> 
> Is there a reason that this must be done?  I'd guess that after the
> SSP is told to start a transfer in slave mode it waits for the master
> to assert the SSn line and begin the transfer.  If the completion
> times out before this happens then it makes sense it wouldn't work.
> But does it still not work if the SPI transfer completes before the
> completion timeout?  Or is this necessary because in your application
> there might be a long wait before the master chooses to initiate a
> transfer after you program it on the Linux side?

The problem is the SPI block in slave mode ignores SS being pulled back up.

> In my case I have a device that is mostly a SPI slave, except it wants
> to drive the clock itself, most unfortunately.  It doesn't drive the
> slave select, rather the imx28 will still drive that (I assume I'll
> need to use a GPIO and loop it back to SSn to trick the SSP into
> thinking the "master" has asserted the slave select).  So really, I'm
> doing SPI master transactions on the Linux side, but need to put the
> SSP into slave mode to get the clock right.  This makes it quite a bit
> easier to do on Linux than a general slave mode, which is quite the
> can of worms.  I tried creating an I2C slave mode framework for
> another application but was never happy with it.  I imagine this is
> why no one has ever created a general spi slave framework for Linux.

SPI slave is hard because you can not anticipate the amount of data you will 
receive. You can not anticipate when you will receive those either.

Best regards,
Marek Vasut
