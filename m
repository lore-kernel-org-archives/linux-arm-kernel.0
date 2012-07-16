From: jon-hunter@ti.com (Jon Hunter)
Date: Mon, 16 Jul 2012 10:56:24 -0500
Subject: [RFC RESEND 1/4] arm/dts: OMAP: Add timer nodes
In-Reply-To: <5000D647.4090200@gmail.com>
References: <1342218413-30116-1-git-send-email-jon-hunter@ti.com>
 <1342218413-30116-2-git-send-email-jon-hunter@ti.com>
 <5000D647.4090200@gmail.com>
Message-ID: <500439A8.1050705@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 07/13/2012 09:15 PM, Rob Herring wrote:
> On 07/13/2012 05:26 PM, Jon Hunter wrote:
>> Add the 12 GP timers nodes present in OMAP3.
>> Add the 11 GP timers nodes present in OMAP4.
>>
>> Add documentation for timer properties specific to OMAP.
>>
>> For each timer an alias is being added. The purpose for doing this is because
>> the OMAP dmtimer driver uses an ID to distinguish between the different timer
>> instances. For example, a timer can be requested by its ID. By adding an alias
>> for each timer we can then use the function of_alias_get_id() to extract the
>> ID for each timer from the alias name. The same method is used for the TTY
>> serial devices. If it is preferred that such an alias is not added and there
>> is a better way to pass an ID from device-tree let me know.
> 
> I'm not sure this is really a good use of aliases. UARTs use aliases
> because it is important that the UART number to tty number is known and
> fixed. IIUC, as an example you are picking timer1 because it has
> properties X, Y and Z. If so, then you should describe those h/w
> properties within the timer nodes so you can pick which timer to use
> based on it's h/w properties.

Thanks for the feedback. What you suggest could definitely work for most
timers. The only item that I would need to resolve here is the handling
of system timers (ie. those used for clockevents and clocksource). These
system timers (for OMAP) are reserved during early boot based upon the
timer ID today and so this is before the actual main timer driver has
been probed and all the attributes of the timers has been read for
device-tree.

One thought would be to move the reservation of the system timers out of
the kernel and into device-tree itself. Then we query device tree on
start-up to see which we should use. I am wondering if this could be a
better use of alias? For example, say I want to use timer1 as my
clockevent timer and so I could have an alias of ...

alias {
	clockevent_timer = &timer1;
}

However, I am not sure if this is even correct, because there does not
appear to be an API to search the aliases by name and return the
phandle, just of_alias_get_id(). Alternatively, I could add another
property called "ti,timer-clockevent" that is populated for the timer
used as the clockevent timer.

Tony, Tarun,

How would you feel on replacing omap_dmtimer_request_specific(int id)
with say omap_dm_timer_request_by_cap(int cap)?

I was thinking of changing the name so that it is clear that the API has
changed. The "int cap" passed to the above function would be an OR of
the appropriate the capabilities flags we have in dmtimer.h ...

/* timer capabilities used in hwmod database */
#define OMAP_TIMER_SECURE                               0x80000000
#define OMAP_TIMER_ALWON                                0x40000000
#define OMAP_TIMER_HAS_PWM                              0x20000000
...

Cheers
Jon
