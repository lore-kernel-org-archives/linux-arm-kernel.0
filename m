From: sassmann@kpanic.de (Stefan Assmann)
Date: Thu, 17 Jul 2014 10:36:48 +0200
Subject: [PATCH RFC 2/2] regulator: twl: Re-add clk32kg to get wifi working
In-Reply-To: <20140716212340.GZ17528@sirena.org.uk>
References: <1405338655-18415-1-git-send-email-sassmann@kpanic.de>
 <1405338655-18415-3-git-send-email-sassmann@kpanic.de>
 <20140714120051.GF6800@sirena.org.uk> <53C3C77F.7080208@kpanic.de>
 <20140714181338.GR6800@sirena.org.uk> <53C525A2.8080609@kpanic.de>
 <20140716212340.GZ17528@sirena.org.uk>
Message-ID: <53C78B20.6010602@kpanic.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16.07.2014 23:23, Mark Brown wrote:
> On Tue, Jul 15, 2014 at 02:59:14PM +0200, Stefan Assmann wrote:
>
>> Looking at this more closely it seems to me that it's a regulator thing
>> after all. In the end it all boils down to a single register write.
>> twl_i2c_write_u8(TWL_MODULE_PM_RECEIVER, 0x41, 0x8e);
>> This is a write to the CLK32KG_CFG_STATE [1] register to power on the
>> device.
>
> The register description happening to mention power doesn't mean it's
> not functionally an enable for a clock.
>
>> I tried moving that to omap4xxx_dt_clk_init() but that won't work
>> because the twl core structures aren't initialized yet.
>
>> Any suggestions?
>
> Why not just add this to (or create a new) clock driver for the chip?
>

Problem is that twl_i2c_write_u8() calls twl_get_regmap() to get the
regmap. This requires struct twl_priv to be populated which does not
happen until twl_probe has run. That hasn't happened at the point when
omap4xxx_dt_clk_init() gets called.
Is there a way to defer a clock driver until twl_probe() has run?

   Stefan
