From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 8 Oct 2009 19:25:21 -0400
Subject: [PATCH] ep93xx: introduce clk parent
In-Reply-To: <4ACE7261.1030302@techworks.ie>
References: <BD79186B4FD85F4B8E60E381CAEE190901CBF45C@mi8nycmail19.Mi8.com>	<BD79186B4FD85F4B8E60E381CAEE190901D42467@mi8nycmail19.Mi8.com>	<4AC3B748.5060904@bluewatersys.com>	<BD79186B4FD85F4B8E60E381CAEE190901D42C80@mi8nycmail19.Mi8.com>	<20091001145939.GA28044@n2100.arm.linux.org.uk><BD79186B4FD85F4B8E60E381CAEE190901D42D95@mi8nycmail19.Mi8.com>
	<4ACE598E.1090908@techworks.ie>
	<BD79186B4FD85F4B8E60E381CAEE190901DB7CDE@mi8nycmail19.Mi8.com>
	<4ACE7261.1030302@techworks.ie>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901DB7CE4@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, October 08, 2009 4:15 PM, Christian Gagneraud wrote:
> Hartley,
>
> The keypad clock is already in as is the et_keytchclk_rate too.

Saw that.  Already responded to you about it.

> Can you explain me by the way why the keypad declares the clock with 
> dev_id="ep93xx-keypad" and no con_id, but the pwm declares the clock 
> with no dev_id and with con_id="clk_pwm"
> Which of dev and con is the consumer and which one is the producer?
> I'm a bit confuse between the platform_driver.name, the clock.dev_id 
> and the clock.con_id
>
> As well I've noticed that the EP93XX keypad input driver does a 
> clock_get("clk_key"), but this clock doesn't exist. or did I miss 
> something.

No, I did...

When the input group picked up the keypad driver I didn't get the core
support files reviewed/merged.  So basically the keypad driver is
currently broken.

Patch 5578/1 was the first patch needed to fix this.  During the review
for it, the original use intended for by the driver changed.  So I'm in
the process of fixing the keypad driver.  Hopefully I'll get this all
resolved soon.

As far as the dev/con id's.

I could have created two clocks for the pwms.  One for dev_id="pwm.0" and
one for dev_id="pwm.1" which is how the two pwm ports get identified when
used.  But, since the pwm clock cannot be disabled it seemed cleaner to
just add one clock, con_id="clk_pwm", since the clock is common for both
pwm controllers.  Look at drivers/misc/ep93xx_pwm.c and you will see that
the clk_get() call passes the dev_id and the con_id.  Since there is not
a matching dev_id in the ep93xx clocks[], the match occurs based on the
con_id.

Make sense?

Regards,
Hartley
