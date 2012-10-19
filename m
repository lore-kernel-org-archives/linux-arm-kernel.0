From: tony@atomide.com (Tony Lindgren)
Date: Thu, 18 Oct 2012 19:38:18 -0700
Subject: [PATCH 01/10] pinctrl: use postcore_initcall
In-Reply-To: <CAN1soZy17wO2s7WoRSRod8k5Zh7fuUc1gxhQiHEb0=zwLhyj6A@mail.gmail.com>
References: <1350551224-12857-1-git-send-email-haojian.zhuang@gmail.com>
 <5080802B.3000209@wwwdotorg.org>
 <20121018222802.GG30550@atomide.com>
 <CAN1soZy17wO2s7WoRSRod8k5Zh7fuUc1gxhQiHEb0=zwLhyj6A@mail.gmail.com>
Message-ID: <20121019023818.GO30550@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Haojian Zhuang <haojian.zhuang@gmail.com> [121018 19:17]:
> On Fri, Oct 19, 2012 at 6:28 AM, Tony Lindgren <tony@atomide.com> wrote:
> >
> > Specifically could you decribe the cases where this issue happens?
> > Also check if one of your client drivers has some early initcall
> > that's no longer needed.
> 
> Yes, the special case is PMIC. Most of PMIC are based on I2C/SPI bus.
> It means that I2C/SPI bus driver should be initialized firstly. For example,
> we could find that PMIC mfd driver are initialized in subsys init call level.
> It means that pinctrl should be initialized earlier than I2C/SPI bus driver.
> Otherwise, pins of I2C bus may not be configured as I2C function since
> pinctrl driver is module init call level.

Hmm, the order in drivers/Makefile is already:

pinctrl/
i2c/

Maybe check that your i2c drivers don't have non-standard initcalls?

Also the i2c drivers may need to return -EPROBE_DEFER?

Regards,

Tony
