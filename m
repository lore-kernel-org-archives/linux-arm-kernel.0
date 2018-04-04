From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 4 Apr 2018 15:12:39 +0200
Subject: [PATCH v3 2/4] mfd: add Gateworks System Controller core driver
In-Reply-To: <CAJ+vNU31f+iY5LOG6QmdJetb=pPvY_gpKoS+49FSy70U1Ksd8g@mail.gmail.com>
References: <1522250043-8065-1-git-send-email-tharvey@gateworks.com>
 <1522250043-8065-3-git-send-email-tharvey@gateworks.com>
 <CAJ+vNU3-gaTcMAzo5wB6oSfE-JQC3NBVRJS5zFMTE-nVpD4F5g@mail.gmail.com>
 <20180403164715.GA5676@lunn.ch>
 <CAJ+vNU31f+iY5LOG6QmdJetb=pPvY_gpKoS+49FSy70U1Ksd8g@mail.gmail.com>
Message-ID: <20180404131239.GD20869@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> What about the 'reset' functionality? Is there something in the power
> supply API for hooking in a GPIO based power switch (in my case it
> would be i2c) as I would think that would be common for ATX supplies?
> I didn't see anything in Documentation/power.
> 
> This is what led me to the restart handler idea. Ultimately when
> someone issues a 'reboot' I would like it to use the GSC to
> power-cycle the board.

Hi Tim

I think you end up with the same problem. By the time you need to turn
the power supply off, too much of the kernel is shut down to be able
to use I2C. And if you are in the middle of an Oops, you have no idea
of the current state. Another I2C transaction could be under way etc.
All the current reset drivers are pretty much self contained, atomic
and use KISS hardware like a GPIO.

Maybe you best bet is to see if you can find any other I2C PMICs which
the kernel supports.

    Andrew
