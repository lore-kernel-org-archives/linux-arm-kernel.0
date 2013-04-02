From: tpiepho@gmail.com (Trent Piepho)
Date: Mon, 1 Apr 2013 17:07:42 -0700
Subject: [PATCH 4/5] spi/mxs: Remove bogus setting of ssp clk rate field
In-Reply-To: <201304020137.39154.marex@denx.de>
References: <1364570381-17605-1-git-send-email-tpiepho@gmail.com>
 <201304020116.04781.marex@denx.de>
 <CA+7tXihhL2ETT+AgvX5KASZOOgi6bucModE88ztY9Q8U1gDbOQ@mail.gmail.com>
 <201304020137.39154.marex@denx.de>
Message-ID: <CA+7tXihfDnmkTJGzk_yvRKYwb5mJzzLJVV+XupCEGnmpQdKDLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 1, 2013 at 4:37 PM, Marek Vasut <marex@denx.de> wrote:
>> On Mon, Apr 1, 2013 at 4:16 PM, Marek Vasut <marex@denx.de> wrote:
>> >> The ssp struct has a clock rate field, to provide the actual value, in
>> >> Hz, of the SSP output clock (the rate of SSP_SCK) after
>> >> mxs_ssp_set_clk_rate() is called.  It should be read-only, except for
>> >> mxs_ssp_set_clk_rate().
>> >>
>> >> For some reason the spi-mxs driver decides to write to this field on
>> >> init, and sets it to the value of the SSP input clock (clk_sspN, from
>> >> the MXS clocking block) in kHz.  It shouldn't be setting the value, and
>> >> certainly shouldn't be setting it with the wrong clock in the wrong
>> >> units.
>> >
>> > I suspect this patch should also fix drivers/clk/mxs/clk-ssp.c then?
>>
>> Why do you say that?  I see no problem with clk-ssp.c, as setting the
>> clk_rate field in the ssp struct to the actual programmed rate makes
>> sense.  The code in spi-mxs.c just makes no sense.  I suspect it was
>> added by mistake when porting the driver.
>
> Either remove it altogether if it's unused OR make sure it's inited to some sane
> value from the start.

This field doesn't need to be initted by a user of the common SSP
clock code, as it is not an input to that code.  It is set by the SSP
clock code.  After the SSP clock is programmed, it can be read to find
the true SSP rate.  There is no need for any user of the SSP code to
set the clk_rate field, and other than this one incorrect line, no
user does so.  It's not used currently in the SPI driver at all, but
it certainly could be.  The SSP code is shared with the MMC driver
that can drive an SSP port in SD/MMC mode.  The mxs-mmc code does need
the actual SSP clock and does use the field.  That code does not write
to ssp->clk_rate, because as I have said, it is in output from the SSP
clock code.

Since the ssp struct is part of the spi master device data, it would
be initialized to zero when allocated by spi_master_alloc().  The SPI
clock isn't part of the spi master, but of a spi slave and a spi
transfer.  Thus there is no sensible value to initialize the spi clock
to at the time the spi master is created.  Which is fine.  The code
doesn't try to and other spi drivers don't either.  At the time a spi
slave is created the spi clock could be programmed.  But that would
introduce a race.  The proper thing to do, and what the driver does,
is to program the spi clock with the requested clock for a spi
transfer.
