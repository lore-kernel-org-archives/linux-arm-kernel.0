From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 8 Oct 2009 19:05:37 -0400
Subject: [PATCH] ep93xx: introduce clk parent
In-Reply-To: <4ACE6332.6060702@techworks.ie>
References: <BD79186B4FD85F4B8E60E381CAEE190901CBF45C@mi8nycmail19.Mi8.com>	<BD79186B4FD85F4B8E60E381CAEE190901D42467@mi8nycmail19.Mi8.com>	<4AC3B748.5060904@bluewatersys.com>	<BD79186B4FD85F4B8E60E381CAEE190901D42C80@mi8nycmail19.Mi8.com>	<20091001145939.GA28044@n2100.arm.linux.org.uk>	<BD79186B4FD85F4B8E60E381CAEE190901D42D95@mi8nycmail19.Mi8.com>	<4ACE598E.1090908@techworks.ie><20091008213425.GA16880@n2100.arm.linux.org.uk>
	<4ACE6332.6060702@techworks.ie>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901DB7CE2@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, October 08, 2009 3:10 PM, Christian Gagneraud wrote:
> Russell King - ARM Linux wrote:
>> On Thu, Oct 08, 2009 at 10:28:46PM +0100, Christian Gagneraud wrote:
>>> I'm currently working on adding ADC support (no touchscreen for now) and 
>>> the problem is that touchscreen (ADC) and keypad use the same clock. With 
>>> this patch applied it would be possible to define the shared 
>>> ep93xx-keytch clock and add ep93xx-keypad and ep93xx-touchscreen as 
>>> children.
>> 
>> If it's a shared clock with common control, there's nothing to stop you
>> returning the same clock for both of them - that's how the clk API is
>> supposed to work.
>
> Thanks, actually i was confused, the 2 clocks share the same 
> configuration register, but have separate clock divisor and clock 
> enable. So there's no need for clock parents. I just need to create a 
> new clkdev for the TS/ADC.

Doh!

The keypad clock is already in clock.c, as is the set_rate callback.  The
necessary Syscon defines are also already in ep93xx-regs.h.  I just put
the clk parent patch into Russell's patch tracker so all you need add for
the adc clock is:

 static struct clk clk_keypad = {
	.parent		= &clk_xtali,
 	.sw_locked	= 1,
 	.enable_reg	= EP93XX_SYSCON_KEYTCHCLKDIV,
 	.enable_mask	= EP93XX_SYSCON_KEYTCHCLKDIV_KEN,
 	.set_rate	= set_keytchclk_rate,
 };
+static struct clk clk_adc = {
+	.parent		= &clk_xtali,
+	.sw_locked	= 1,
+	.enable_reg	= EP93XX_SYSCON_KEYTCHCLKDIV,
+	.enable_mask	= EP93XX_SYSCON_KEYTCHCLKDIV_TSEN,
+	.set_rate	= set_keytchclk_rate,
+};
 static struct clk clk_pwm = {
 	.rate		= EP93XX_EXT_CLK_RATE,
 };

And:

	INIT_CK("ep93xx-keypad",	NULL,		&clk_keypad),
+	INIT_CK("ep93xx-adc",		NULL,		&clk_adc),
	INIT_CK("ep93xx-fb",		NULL,		&clk_video),


Make sure you look at set_keytchclk_rate() to see how the adc
clock is configured.  Basically the only two rates that are valid
are EP93XX_KEYTCHCLK_DIV4 and EP93XX_KEYTCHCLK_DIV16.

Regards,
Hartley
