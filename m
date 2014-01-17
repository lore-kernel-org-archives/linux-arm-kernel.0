From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Fri, 17 Jan 2014 20:57:41 +0100
Subject: More GPIO madness on iMX6 - and the crappy ARM port of Linux
In-Reply-To: <20140117184731.GE15937@n2100.arm.linux.org.uk> (Russell King's
 message of "Fri, 17 Jan 2014 18:47:31 +0000")
References: <20140117184731.GE15937@n2100.arm.linux.org.uk>
Message-ID: <87ioti2xfu.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

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

this is "expected". gpio layer docs are saying that in output case, the
value may be wrong. Not intuitive but documented.

> Yes, iMX6 at least has this behaviour.  For any output, val as above
> will always be zero, and /proc/sys/kernel/debug/gpio will always
> report that an output is zero... unless the SION bit has been set for
> that GPIO signal.

afaik at least imx51/53 have some behaviour.

>
> The reason is that on hardware such as iMX6, reading the GPIO is done
> by reading the pad state register, and this register is _only_ supplied
> the state of the pad when the input path is enabled.  The input path
> is only enabled when the output is disabled, or the SION bit is set
> to force the GPIO input path.

I sent mails about this same issue for imx51 in Dec 2010 and answer were
that the SION bit should not be set for all gpios:
http://permalink.gmane.org/gmane.linux.ports.arm.kernel/100875


Arnaud
