From: dianders@chromium.org (Doug Anderson)
Date: Tue, 19 Aug 2014 08:18:54 -0700
Subject: [PATCH 1/4] ARM: rockchip: rk3288: Switch to use the proper PWM IP
In-Reply-To: <20140819071011.GC12859@ulmo>
References: <1408381749-14156-1-git-send-email-dianders@chromium.org>
 <1408381749-14156-2-git-send-email-dianders@chromium.org>
 <20140819071011.GC12859@ulmo>
Message-ID: <CAD=FV=Xr4ywGT_pPK=r6f6tfVpwbduUY7D5LK61HVtc8=JmkaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thierry,

On Tue, Aug 19, 2014 at 12:10 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Mon, Aug 18, 2014 at 10:09:06AM -0700, Doug Anderson wrote:
>> The rk3288 SoC has an option to switch all of the PWMs in the system
>> between the old IP block and the new IP block.  The new IP block is
>> working and tested and the suggested PWM to use, so setup the SoC to
>> use it and then we can pretend that the other IP block doesn't exist.
>>
>> This code could go lots of other places, but we've put it here.  Why?
>> - Pushing it to the bootloader just makes the code harder to update in
>>   the field.  If we later find a bug in the new IP block and want to
>>   change our mind about what to use we want it to be easy to update.
>> - Putting this code in the driver for IP block is a lot of extra work,
>>   device tree bindings, etc.  Now that the new IP block is validated
>>   it's likely no future SoCs will need this code.  Why pollute the PWM
>>   driver with this?  This is an rk3288 thing so it should be in rk3288
>>   code.
>> - There's a single bit that switches over PWMs, which makes it extra
>>   hard to put this under the PWM device tree nodes.
>>
>> Signed-off-by: Doug Anderson <dianders@chromium.org>
>> ---
>>  arch/arm/mach-rockchip/rockchip.c | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/arch/arm/mach-rockchip/rockchip.c b/arch/arm/mach-rockchip/rockchip.c
>> index 8ab9e0e..99133b9 100644
>> --- a/arch/arm/mach-rockchip/rockchip.c
>> +++ b/arch/arm/mach-rockchip/rockchip.c
>> @@ -24,6 +24,24 @@
>>  #include <asm/hardware/cache-l2x0.h>
>>  #include "core.h"
>>
>> +static void __init rk3288_init_machine(void)
>> +{
>> +     void *grf = ioremap(0xff770000, 0x10000);
>
> This region of memory is part of the "grf" "syscon" device (according to
> arch/arm/boot/dts/rk3288.dtsi) so the register should be accessed from
> that driver. It looks as if no such driver currently exists, but given
> the existence of the device tree node it's fair to assume that one will
> eventually be merged.

The "grf" syscon device is the "general register file".  It's a
collection of totally random registers stuffed together in one address
space.  Sometimes a single 32-bit register has things you need to
tweak for completely different subsystems.

Most drivers referene the syscon using this in dts:
  rockchip,grf = <&grf>;

Then the drivers do:
  grf = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");


See the Rockchip i2c, pinctrl, or clock drivers for examples.

I could follow the lead of those subsystem and do the same thing, but
I haven't because of the reasons talked about in the patch
description.  To summarize: I thought it was cleaner and would have
less baggage to carry to put this code in an rk3288-specific function.


There was no clean place to put rk3288-specific code such that it used
the "syscon" interface like i2c/clk/pinctrl.  ...and adding a lot of
infrastructure for something like that seems like a bit too much to
me.  As it's written the code will never need to change (the physical
address of GRF and this bit will always be right on rk3288) and
hopefully nobody will need to think about it again.  ;)


-Doug
