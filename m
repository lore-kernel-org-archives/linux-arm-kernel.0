From: khilman@ti.com (Kevin Hilman)
Date: Mon, 23 Apr 2012 17:32:57 -0700
Subject: [PATCH-V3 3/3] ARM: OMAP: Make OMAP clocksource source selection
 using kernel param
In-Reply-To: <79CD15C6BA57404B839C016229A409A83E9F9AD0@DBDE01.ent.ti.com>
 (Vaibhav Hiremath's message of "Mon, 23 Apr 2012 17:35:19 +0000")
References: <1334309947-25214-1-git-send-email-hvaibhav@ti.com>
 <1334309947-25214-4-git-send-email-hvaibhav@ti.com>
 <87k41bqm0j.fsf@ti.com>
 <79CD15C6BA57404B839C016229A409A83E9F9AD0@DBDE01.ent.ti.com>
Message-ID: <87ehreezpi.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Hiremath, Vaibhav" <hvaibhav@ti.com> writes:

> On Fri, Apr 20, 2012 at 06:04:20, Hilman, Kevin wrote:

[...]

>> Also note that because you're adding an offset of 0x10 to the start, the
>> ioremap later is actually mapping 0x10 past the end.  More on the base
>> address later...
>> 
>
> Comment on top of this code will enough, isn't it?
>

No.  ioremapping() the range that goes past the end of the device is
just wrong.  But if you fix the offset as described below, that would be
fine.

[...]

>> > @@ -68,54 +66,43 @@ void read_persistent_clock(struct timespec *ts)
>> >  	*ts = *tsp;
>> >  }
>> >
>> > -int __init omap_init_clocksource_32k(void)
>> > +int __init omap_init_clocksource_32k(u32 pbase, unsigned long size)
>> 
>> Now that this takes some arguments, this function wants some kerneldoc.
>> 
>
> Should I create new documentation inside Documentation/arm/OMAP/
> with name "counter_32k"?

by kerneldoc, I mean comments in the code, not in Documenation.

IOW, just add a comment before this function in the code, but make sure
it is of the format described in Documentation/kernel-doc-nano-HOWTO.txt.

>> In particular, you should document that 'pbase' is the address of the
>> counter register, not the base of the IP.
>> 
>> That being said, I think the pbase passed in should probably be the base
>> of the IP register, not the address of the counter register. It seems to
>> me that it's at offset 0x10 on all SoCs anyways.
>> 
>> Doing that will also ensure that the ioremap'd range covers the whole
>> IP, and not from the counter register to 0x10 past the end.
>> 
>
> Yeah, you are right, I can get rid of this offset and move it to 
> counter_32k.c file.

Perfect.

Kevin
