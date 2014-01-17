From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 17 Jan 2014 18:47:31 +0000
Subject: More GPIO madness on iMX6 - and the crappy ARM port of Linux
Message-ID: <20140117184731.GE15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So, we have this wonderful GPIO layer which abstracts GPIO stuff and
hides stuff.  It's really wonderful, because you don't have to care
about how the GPIOs are actually accessed in drivers anymore.

However, what about the behaviour of GPIOs?

What about... for example... this sequence:

	gpio_direction_output(gpio, 1);
	val = gpio_get_value(gpio);

What value is "val"?  More importantly, what value is reflected in
/sys/kernel/debug/gpio ?  Would it indicate that it's high or low?

Now, while you can make reasonable assumptions, such as "it'll return
that the output is being driven to the requested state" or "it'll
return the actual state of the pin", what about this instead, which
happens on iMX hardware - "it'll _always_ return zero".

Yes, iMX6 at least has this behaviour.  For any output, val as above
will always be zero, and /proc/sys/kernel/debug/gpio will always
report that an output is zero... unless the SION bit has been set for
that GPIO signal.

The reason is that on hardware such as iMX6, reading the GPIO is done
by reading the pad state register, and this register is _only_ supplied
the state of the pad when the input path is enabled.  The input path
is only enabled when the output is disabled, or the SION bit is set
to force the GPIO input path.

So, this brings up three obvious questions:

1. What should gpio_get_value() return for an output?
2. What should be reported in /sys/kernel/debug/gpio for an output?
3. Should iMX6 (and similar) GPIOs always have the SION bit set in
   their DT descriptions?

Discuss.

Since I've wasted all afternoon trying to chase down why the GPIOs
controlling the regulators for USB appear to be disabled when reading
/sys/kernel/debug/gpio, I'm *FAR* from impressed by the current
confusing behaviour - and it's another nail in the "why the ARM Linux
kernel is turning to shit" coffin.  I'm pleased to know that according
to google+, I'm not the only one with these feelings - so it's about
time we started fixing some of these idiotic and crap behaviours in
these layers of subsystems which make platform support unnecessarily
difficult.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
