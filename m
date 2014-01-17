From: eric.nelson@boundarydevices.com (Eric Nelson)
Date: Fri, 17 Jan 2014 12:13:12 -0700
Subject: More GPIO madness on iMX6 - and the crappy ARM port of Linux
In-Reply-To: <20140117184731.GE15937@n2100.arm.linux.org.uk>
References: <20140117184731.GE15937@n2100.arm.linux.org.uk>
Message-ID: <52D980C8.9020809@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 01/17/2014 11:47 AM, Russell King - ARM Linux wrote:
> So, we have this wonderful GPIO layer which abstracts GPIO stuff and
> hides stuff.  It's really wonderful, because you don't have to care
> about how the GPIOs are actually accessed in drivers anymore.
>
> However, what about the behaviour of GPIOs?
>
> What about... for example... this sequence:
>
> 	gpio_direction_output(gpio, 1);
> 	val = gpio_get_value(gpio);
>
> What value is "val"?  More importantly, what value is reflected in
> /sys/kernel/debug/gpio ?  Would it indicate that it's high or low?
>
> Now, while you can make reasonable assumptions, such as "it'll return
> that the output is being driven to the requested state" or "it'll
> return the actual state of the pin", what about this instead, which
> happens on iMX hardware - "it'll _always_ return zero".
>
> Yes, iMX6 at least has this behaviour.  For any output, val as above
> will always be zero, and /proc/sys/kernel/debug/gpio will always
> report that an output is zero... unless the SION bit has been set for
> that GPIO signal.
>
> The reason is that on hardware such as iMX6, reading the GPIO is done
> by reading the pad state register, and this register is _only_ supplied
> the state of the pad when the input path is enabled.  The input path
> is only enabled when the output is disabled, or the SION bit is set
> to force the GPIO input path.
>
> So, this brings up three obvious questions:
>
> 1. What should gpio_get_value() return for an output?

It seems that this is pretty well specified.

To quote Documentation/gpio/gpio-legacy.txt:
	>> When reading the value of an output pin, the value
	>> returned should be what's seen on the pin ... that
	>> won't always match the specified output value, because
	>> of issues including open-drain signaling and output
	>> latencies.

Documentation/gpio/gpio.txt is a little less clear, but implies
the same:
	>> If you are "driving" the signal high but
	>> gpiod_get_value(gpio) reports a low value (after
	>> the appropriate rise time passes), you know some other
	>> component is driving the shared signal low

> 2. What should be reported in /sys/kernel/debug/gpio for an output?
> 3. Should iMX6 (and similar) GPIOs always have the SION bit set in
>     their DT descriptions?
>
> Discuss.
>

Each signal accessed using the GPIO subsystem **must** have
the SION bit set and the values returned should be the value
from the PSR registers.

Regards,


Eric
