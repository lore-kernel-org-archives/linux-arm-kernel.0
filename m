From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 22 Feb 2014 12:19:07 +0100
Subject: [PATCH v7 4/8] ARM: sunxi: Add driver for SD/MMC hosts found
 on Allwinner sunxi SoCs
In-Reply-To: <20140222083128.GH3931@lukather>
References: <20140217095907.15040.81893.stgit@pagira.o2s.ch>
 <20140217100234.15040.84232.stgit@pagira.o2s.ch>
 <20140218153731.GK3142@lukather> <5303C751.5090809@redhat.com>
 <20140219094615.GT3142@lukather> <5304A042.7090903@redhat.com>
 <20140222083128.GH3931@lukather>
Message-ID: <530887AB.1030805@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02/22/2014 09:31 AM, Maxime Ripard wrote:

<snip>

>>>>> This should be before the registration. Otherwise, you're racy.
>>>>
>>>> Nope, we only need this to get the data on sunxi_mmc_remove,
>>>> everywhere else the data is found through the mmc-host struct.
>>>
>>> Still, if anyone makes a following patch using the platform_device
>>> for some reason, we will have a race condition, without any way to
>>> notice it.
>>>
>>> Plus, you're doing all the other bits of initialization of your
>>> structures much earlier, why not be consistent and having all of
>>> them at the same place?
>>
>> Most platform drivers I've worked on do platform_set_drvdata as late
>> as possible, so that the drvdata does not get set and never cleared
>> in error paths.
>
> You don't actually have to clear it,

Erm, yes and no, you used to have to manually clear it, so as to not
leave a dangling pointer in there, which may confuse things later.

But since a few kernel releases, the driver core will explicitly
clear it on probe failure, since many many drivers got this wrong.
I know this because I wrote the driver core patch doing the clearing :)

So in drivers which used to get it right, you will see the
platform_set_drvdata call quite late and it being so late
in the sunxi-mmc.c driver is old habits dying hard.

But you're right that this is no longer needed, still I see little
reason to move it up, but if you really want it to be moved up,
I'm fine with that.

> and some frameworks actually require you to call dev_set_drvdata before registration, so that
> statement looks quite odd to me.

And the proper thing to do when using those frameworks was to
manually clear drvdata again on probe failure. Anyways this is
all handled in the driver core now, so this whole discussion
is moot anyways. I was merely trying to explain where my
preference for doing the dev_set_drvdata call as late as
possible comes from.

Regards,

Hans
