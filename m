From: jm@lentin.co.uk (Jamie Lentin)
Date: Wed, 02 May 2012 14:29:31 +0100
Subject: [PATCH 1/1] ARM: kirkwood: Add support for RaidSonic
In-Reply-To: <20120501195603.GW25584@lunn.ch>
References: <20120501172042.GA13233@lunn.ch>
 <alpine.DEB.2.00.1205011902150.23719@marmot.wormnet.eu>
 <20120501195603.GW25584@lunn.ch>
Message-ID: <op.wdonrhzb4cuzmg@gonzo.lentin.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 01 May 2012 20:56:03 +0100, Andrew Lunn <andrew@lunn.ch> wrote:

> On Tue, May 01, 2012 at 07:34:29PM +0100, Jamie Lentin wrote:
>> On Tue, 1 May 2012, Andrew Lunn wrote:
>>
>> >Hi Simon
>> >
>> >The patch looks good.
>> >
>> >+static void ib62x0_power_off(void)
>> >+{
>> >+       gpio_set_value(IB62X0_GPIO_POWER_OFF, 1);
>> >+}
>> >
>> >Seeing this set of a train of thought. I have a feature creep
>> >request. Nice to have, i.e. not required to acceptance. This patterns
>> >of using a GPIO line to turn the hardware off is seen quite a few
>> >times. e.g.
>> >
>> >mach-kirkwood/netspace_v2-setup.c
>> >mach-orion5x/mv2120-setup.c
>> >mach-kirkwood/d2net_v2-setup.c
>> >mach-kirkwood/netspace_v2-setup.c
>> >
>> >and a few more.
>> >
>> >How about writing a gpio-poweroff platform driver? It would take a
>> >platform_data structure which lists which GPIO line to use, and if it
>> >should be active high/low. The probe function would take control of
>> >the GPIO line, set it to inactive state, and output. It would also
>> >register a function for pm_power_off(). When that function is called,
>> >it toggles the GPIO to turn the power off.
>> >
>> >Then wrap all this up in a DT binding.
>>
>> I've been thinking about this too, would make a lot of sense. Most
>> of the gpio-poweroff driver would be easy, although registering the
>> power_off function wasn't immediately obvious.
>
> pm_power_off is a global variable. You should be able to assign it
> from anywhere.

It seemed a bit worrying setting the global within a driver when it might  
be overridden elsewhere, but I guess it's fairly unlikely a board would  
invoke several means of turning off. A grep shows several drivers that  
already do this (setting pm_power_off) anyway. I'll have a go at writing  
one later.

>
>      Andrew


-- 
Jamie Lentin
