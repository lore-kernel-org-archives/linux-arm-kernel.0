From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 11 Jan 2017 16:42:00 +0100
Subject: [PATCH v8 2/5] i2c: Add STM32F4 I2C driver
In-Reply-To: <CAOAejn2cDzPgqvWZf7ASvtST+aDeaAebf=1aMWA9Zd8CDg4pmA@mail.gmail.com>
References: <1483607246-14771-1-git-send-email-cedric.madianga@gmail.com>
 <1483607246-14771-3-git-send-email-cedric.madianga@gmail.com>
 <20170111082208.vzu7xgpd4eakyldl@pengutronix.de>
 <CAOAejn2eOy2sn1VkE979ne23Sj9L6+kaQDNpL1EUKb2m=6sGXw@mail.gmail.com>
 <CAOAejn2cDzPgqvWZf7ASvtST+aDeaAebf=1aMWA9Zd8CDg4pmA@mail.gmail.com>
Message-ID: <20170111154200.xcxdlnnakyttumzw@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Cedric,

On Wed, Jan 11, 2017 at 03:20:41PM +0100, M'boumba Cedric Madianga wrote:
> >
> >> +              */
> >> +             reg = i2c_dev->base + STM32F4_I2C_CR1;
> >> +             stm32f4_i2c_clr_bits(reg, STM32F4_I2C_CR1_ACK);
> >> +             stm32f4_i2c_set_bits(reg, STM32F4_I2C_CR1_POS);
> >
> > You could get rid of this, when caching the value of CR1. Would save two
> > register reads here. This doesn't work for all registers, but it should
> > be possible to apply for most of them, maybe enough to get rid of the
> > clr_bits and set_bits function.
> 
> I agree at many places I could save registers read by not using
> clr_bits and set_bits function when the registers in question has been
> already read.
> But it is not enough to get rid of the clr_bits and set_bits function.
> For example when calling stm32f4_i2c_terminate_xfer(), the CR1
> register is never read before so set_bits function is useful.

I didn't double check the manual, but I would expect that CR1 isn't
modified by hardware. So you can cache the result in the driver data
structure and do the necessary modifications with that one.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
