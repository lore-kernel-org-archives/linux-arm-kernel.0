From: sassmann@kpanic.de (Stefan Assmann)
Date: Tue, 15 Jul 2014 14:59:14 +0200
Subject: [PATCH RFC 2/2] regulator: twl: Re-add clk32kg to get wifi working
In-Reply-To: <20140714181338.GR6800@sirena.org.uk>
References: <1405338655-18415-1-git-send-email-sassmann@kpanic.de>
 <1405338655-18415-3-git-send-email-sassmann@kpanic.de>
 <20140714120051.GF6800@sirena.org.uk> <53C3C77F.7080208@kpanic.de>
 <20140714181338.GR6800@sirena.org.uk>
Message-ID: <53C525A2.8080609@kpanic.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14.07.2014 20:13, Mark Brown wrote:
> On Mon, Jul 14, 2014 at 02:05:19PM +0200, Stefan Assmann wrote:
>> On 14.07.2014 14:00, Mark Brown wrote:
>
>>> No, you need to implement clocks using the clock API.  Please read the
>>> changelogs for the above commits...
>
>> Yes, that's what I expected. Got any pointers for me how to do this?
>> Never done that before, a little help would be appreciated.
>
> There should be plenty of examples in drivers/clk?

Looking at this more closely it seems to me that it's a regulator thing
after all. In the end it all boils down to a single register write.
twl_i2c_write_u8(TWL_MODULE_PM_RECEIVER, 0x41, 0x8e);
This is a write to the CLK32KG_CFG_STATE [1] register to power on the
device.

I tried moving that to omap4xxx_dt_clk_init() but that won't work
because the twl core structures aren't initialized yet.

Any suggestions?

   Stefan

[1] http://www.cjemicros.f2s.com/public/datasheets/TWL6030_Register_Map.pdf page 196
