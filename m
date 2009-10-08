From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 8 Oct 2009 18:40:23 -0400
Subject: [PATCH] ep93xx: introduce clk parent
In-Reply-To: <4ACE598E.1090908@techworks.ie>
References: <BD79186B4FD85F4B8E60E381CAEE190901CBF45C@mi8nycmail19.Mi8.com>	<BD79186B4FD85F4B8E60E381CAEE190901D42467@mi8nycmail19.Mi8.com>	<4AC3B748.5060904@bluewatersys.com>	<BD79186B4FD85F4B8E60E381CAEE190901D42C80@mi8nycmail19.Mi8.com>	<20091001145939.GA28044@n2100.arm.linux.org.uk><BD79186B4FD85F4B8E60E381CAEE190901D42D95@mi8nycmail19.Mi8.com>
	<4ACE598E.1090908@techworks.ie>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901DB7CDE@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, October 08, 2009 2:29 PM, Christian Gagneraud wrote:
> Hi,
> 
> What's the status of this patch? It does not appear on the patch 
> tracker, and it's not in linus tree (or I'm missing something).
> 
> I'm currently working on adding ADC support (no touchscreen for now) 
> and the problem is that touchscreen (ADC) and keypad use the same 
> clock. With this patch applied it would be possible to define the 
> shared ep93xx-keytch clock and add ep93xx-keypad and 
> ep93xx-touchscreen as children.

Christian,

I have a patch for clock.c that adds the keypad clock.  This will
also give you what you need to configure the adc clock.  Hopefully
I will get a chance to post that patch in the next couple days.

As Russell already mentioned, the clk parent patch does not effect
the adc clock.  The common clock between them is actually the external
crystal.

The only thing they share is the configuration register used to set
the clock divisor and to enable the clock.  For the adc clock you
will just need to add:

+static struct clk clk_adc = {
+	.parent		= &clk_xtali,
+	.sw_locked	= 1,
+	.enable_reg	= EP93XX_SYSCON_KEYTCHCLKDIV,
+	.enable_mask	= EP93XX_SYSCON_KEYTCHCLKDIV_TSEN,
+	.set_rate	= set_keytchclk_rate,
+};

And of course the proper INIT_CK() for clk_adc.  The set_rate
callback will be the same one used for the keypad, which will
be in my coming patch.

Regards,
Hartley
