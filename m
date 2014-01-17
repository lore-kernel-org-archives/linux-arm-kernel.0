From: eric.nelson@boundarydevices.com (Eric Nelson)
Date: Fri, 17 Jan 2014 12:33:43 -0700
Subject: More GPIO madness on iMX6 - and the crappy ARM port of Linux
In-Reply-To: <52D980C8.9020809@boundarydevices.com>
References: <20140117184731.GE15937@n2100.arm.linux.org.uk>
 <52D980C8.9020809@boundarydevices.com>
Message-ID: <52D98597.6010409@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 01/17/2014 12:13 PM, Eric Nelson wrote:
> Hi Russell,
>
> On 01/17/2014 11:47 AM, Russell King - ARM Linux wrote:
>>
 >> <snip>
>>
>> So, this brings up three obvious questions:
>>
>> 1. What should gpio_get_value() return for an output?
>
> It seems that this is pretty well specified.
>
> To quote Documentation/gpio/gpio-legacy.txt:
>      >> When reading the value of an output pin, the value
>      >> returned should be what's seen on the pin ... that
>      >> won't always match the specified output value, because
>      >> of issues including open-drain signaling and output
>      >> latencies.
>
> Documentation/gpio/gpio.txt is a little less clear, but implies
> the same:
>      >> If you are "driving" the signal high but
>      >> gpiod_get_value(gpio) reports a low value (after
>      >> the appropriate rise time passes), you know some other
>      >> component is driving the shared signal low
>
>> 2. What should be reported in /sys/kernel/debug/gpio for an output?
>> 3. Should iMX6 (and similar) GPIOs always have the SION bit set in
>>     their DT descriptions?
>>
>> Discuss.
>>
>
> Each signal accessed using the GPIO subsystem **must** have
> the SION bit set and the values returned should be the value
> from the PSR registers.
>

Because the MUX registers are very consistent, it appears
that a fix for this that sets the SION bit is simple (almost
mechanical) in the imx*pinfunc.h files.

It seems that each of the declarations matching

	#define MX*GPIO_something

should have bit four set in the mux_mode column.

I'd be happy to work up a patch if there's agreement here
(and I can't think of any rationale for not setting these).

Regards,


Eric
