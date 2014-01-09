From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 9 Jan 2014 11:51:10 +0800
Subject: [PATCH v4] ARM: prima2: move to generic reset controller driver
 framework
In-Reply-To: <201401071653.49964.arnd@arndb.de>
References: <1389003878-10094-1-git-send-email-21cnbao@gmail.com>
 <201401061641.03491.arnd@arndb.de>
 <CAGsJ_4zE115p011hfDgzQPTUHUYk6WoQvw=vNSJP_yi=TvVkbg@mail.gmail.com>
 <201401071653.49964.arnd@arndb.de>
Message-ID: <CAGsJ_4x=SdqCjcCwFYFXy88z0xhWaDp2rE_HXOhRxs_7miireQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014/1/7 Arnd Bergmann <arnd@arndb.de>:
> On Tuesday 07 January 2014, Barry Song wrote:
>> 2014/1/6 Arnd Bergmann <arnd@arndb.de>:
>> > On Monday 06 January 2014, Barry Song wrote:
>> >
>> >> +void __init sirfsoc_of_rstc_init(void)
>> >> +{
>> >> +     struct device_node *np = of_find_matching_node(NULL, rstc_ids);
>> >> +     if (!np) {
>> >> +             pr_err("unable to find compatible sirf rstc node in dtb\n");
>> >> +             return;
>> >> +     }
>> >> +
>> >> +     sirfsoc_rstc_base = of_iomap(np, 0);
>> >> +     if (!sirfsoc_rstc_base) {
>> >> +             pr_err("unable to map rstc cpu registers\n");
>> >> +             return;
>> >> +     }
>> >> +
>> >> +     sirfsoc_reset_controller.of_node = np;
>> >> +
>> >> +     reset_controller_register(&sirfsoc_reset_controller);
>> >> +}
>> >> +
>> >
>> > Can't this be a regular platform device? Drivers that get the reference to
>> > the reset controller should respect a -EPROBE_DEFER error message if they
>> > get initialized in the wrong order.
>>
>> Arnd, it is ok if prima2 is not a platform for automotive. here prima2
>> actually wants a "right" order for products.
>> for example, there are some local hacking to move camera for rearview
>> started earlier than other devices as this feature needs to be ready
>> as early as possible.
>> some earlier boot devices depend on reset module to be ready. so if we
>> move to regular platform driver for upstream, it still requires some
>> local hacking to move it earlier.
>
> I don't understand what you mean. It should be a matter of a few miliseconds
> at most to retry initialization, more likely in the microseconds. How big
> are the delays you are worried about?

what i am worrried about is 100ms or more. device drivers need time to
initialize and that will take time, if some devices initialization
happen before the deferred probing, the deferred probing might be
delayed 100ms.
for example, we want camera begin to show rear-view in several
hundreds of ms, there are some local hacking to move i2c and camera
probe earlier than other devices.
that means actually there is requirement for right order of probing
but not defer probing sometimes.

>
>         Arnd

-barry
