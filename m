From: eric.nelson@boundarydevices.com (Eric Nelson)
Date: Fri, 17 Jan 2014 13:12:04 -0700
Subject: More GPIO madness on iMX6 - and the crappy ARM port of Linux
In-Reply-To: <87ioti2xfu.fsf@lebrac.rtp-net.org>
References: <20140117184731.GE15937@n2100.arm.linux.org.uk>
 <87ioti2xfu.fsf@lebrac.rtp-net.org>
Message-ID: <52D98E94.6000609@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/17/2014 12:57 PM, Arnaud Patard (Rtp) wrote:
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
>
>> So, we have this wonderful GPIO layer which abstracts GPIO stuff and
>> hides stuff.  It's really wonderful, because you don't have to care
>> about how the GPIOs are actually accessed in drivers anymore.
>>
>> However, what about the behaviour of GPIOs?
>>
>> What about... for example... this sequence:
>>
>> 	gpio_direction_output(gpio, 1);
>> 	val = gpio_get_value(gpio);
>>
>> What value is "val"?  More importantly, what value is reflected in
>> /sys/kernel/debug/gpio ?  Would it indicate that it's high or low?
>>
>> Now, while you can make reasonable assumptions, such as "it'll return
>> that the output is being driven to the requested state" or "it'll
>> return the actual state of the pin", what about this instead, which
>> happens on iMX hardware - "it'll _always_ return zero".
>>
>
> this is "expected". gpio layer docs are saying that in output case, the
> value may be wrong. Not intuitive but documented.
>
>> Yes, iMX6 at least has this behaviour.  For any output, val as above
>> will always be zero, and /proc/sys/kernel/debug/gpio will always
>> report that an output is zero... unless the SION bit has been set for
>> that GPIO signal.
>
> afaik at least imx51/53 have some behaviour.
>
>>
>> The reason is that on hardware such as iMX6, reading the GPIO is done
>> by reading the pad state register, and this register is _only_ supplied
>> the state of the pad when the input path is enabled.  The input path
>> is only enabled when the output is disabled, or the SION bit is set
>> to force the GPIO input path.
>
> I sent mails about this same issue for imx51 in Dec 2010 and answer were
> that the SION bit should not be set for all gpios:
> http://permalink.gmane.org/gmane.linux.ports.arm.kernel/100875
>

Thanks Arnaud,

This bit from the 2010 chain really needs some explanation:

 >> Arnaud Patard (Rtp) writes:
 >>
 >> <snip>
 >>
 >> I had done the same, but had some trouble with this.
 >> E.g. on our board GPIO1_7 is used as a generic GPIO to enable an
 >> external clock oscillator for the USBH1 ULPI PHY. When the SION bit
 >> for this pad was set, I got strange errors on the USBH1 port
 >> (disconnecting low speed devices behind a hub would stall the
 >> bus). When I removed the SION bit for that pin everything worked
 >> well.
 >>

Did you ever chase down the symptom here? Was the GPIO output not
holding a constant value such that the oscillator wasn't functioning?

Please advise,


Eric
