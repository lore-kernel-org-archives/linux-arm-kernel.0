From: gbean@codeaurora.org (Gregory Bean)
Date: Thu, 12 Aug 2010 09:39:29 -0700
Subject: [RFC] the right way to use gpiolib hooks to automate power management?
Message-ID: <4C6423C1.9060509@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi folks:

On MSM, we have a bank of gpios whose physical characteristics are
controlled via a 'gpiomux' subsystem, which sets things like drive
strength, pull-up, pull-down, gpio functional assignment, and the like.

We have a written a software driver which reference-counts these gpio
lines (via a put()/get() api), putting them in their "high-power" active
configurations when they're in use, and dropping them down into a
high-impedance low-power setting when they're not.

We can't use gpiolib for this because many of these gpios are set to
'non-gpio' mux settings: they get assigned to busses as data or address
lines (for example) and are not used as gpios after that.

However, for those gpios which are left in 'gpio mode', we DO want
gpiolib to 'do the right thing' as regards power management.  From the
following text in Documentation/gpio.txt:

   int gpio_request(unsigned gpio, const char *label);
   void gpio_free(unsigned gpio);

   ...Some platforms may also use knowledge about what GPIOs are
   active for power management, such as by powering down unused
   chip sectors and, more easily, gating off unused clocks...

I interpret from this that it is 'healthy' behavior to put a call to our
gpiomux get() in our gpio_chip's gpio_request(), and a matching call to
our gpiomux put() in gpio_free().  It seems to me that this would bring
lines out of low-power mode when they're first requested, and put them
back to sleep when they're released, exactly as we want.

Is this the right thing to be doing, or is this going to get us in
trouble? I want to make sure we're using the system as it was intended.

Thanks!
-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
