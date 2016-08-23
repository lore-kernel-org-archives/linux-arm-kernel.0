From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 23 Aug 2016 18:39:35 +0200
Subject: [RFC PATCH v2 0/7] AC97 device/driver model revamp
In-Reply-To: <1464380819-19075-1-git-send-email-robert.jarzmik@free.fr>
 (Robert Jarzmik's message of "Fri, 27 May 2016 22:26:52 +0200")
References: <1464380819-19075-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <87twebphh4.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> It all started in the pxa device-tree submission here :
>    https://lkml.org/lkml/2016/2/25/965
>    
> It will be maintained in :
>    git fetch https://github.com/rjarzmik/linux.git work/ac97
>
> And now it transformed into this RFC, which would bring a ground for AC'97
> devices closer to the linux device/driver model.
>
> The driving ideas are still the same, and I put them in [1] for memory. This is
> the second opus of the RFC. I'm intending to stop the RFC cycle here if possible
> and have a true PATCH v1 submission after this RFC v2 unless there is a deep
> design flaw uncovered.
>
> I took into account Mark's and Takashi's remarks, I hope I forgot none. All the
> changes should be documented in the first 2 patches mainly. I also added :
>  - the AC97 link clock
>    For now, bus code doesn't disable it in suspend and re-enable in resume,
>    leaving the controller decide. I'm still pondering if for S2RAM (as opposed
>    to runtime suspend), bus code should disable the clock.
>
>  - the .h guards
>    I'm not particularly happy with my naming even for v2, feel free to propose
>    anything better, the codec.h is particularly ugly.
>
>  - statics and namespace pollution
>    I made more functions static, limiting further the namespace pollution.
>
>  - Kconfig/Makefile layout change
>    I get the feeling that the KConfig "select" flavor would have better been a
>    "depends on" one. And yet I didn't find a good way to enforce it, because of
>    the way sound/soc/codecs/Kconfig is designed, and I'm afraid to break the
>    structure by doing a "depends on AC97_BUS_NEW" in WM9713 configuration.
>
> Let's have another review cycle, that will let me test this serie more
> thoroughly, especially the suspend/resume and the reset in the resume, which
> doesn't work, and requires me to test more deeply. I'll also test by removing
> the wm9713 change to see how robust the implementation is.

Hi Mark,

It's been some time, and I'm coming back to this work, as my v4l2 work is almost
over.  I made a bit more testing, it doesn't look any worse for pxa + wm9713
couple than before.

I have a new concern with arose with this serie about the wm9713, a trouble in
how the touchscreen wm97xx-ts is probed, ie :
 - drivers/input/touchscreen/wm97xx-core.c, the wm97xx_driver structure

In the old ac97 bus, the match function was always returning "true", and the
driver did probe. With this new implementation, the ac97 is discovered and
sound/soc/codecs/wm9713.c#wm9713_ac97_probe() is called. I don't export
ac97_bus_type (nor want to do it), and only _one_ device is created upon
discovery, while the wm97xx-core.c would benefic a second ac97 device.

I'm wondering how to work around this :
 - either I add a wm97xx-ts ac97 device in wm9713_ac97_probe()
 - or I add a platform device in wm9713_ac97_probe() and add a new
   platform_driver in wm97xx-core ...
 - or something smarter

What's behind this question is : should I keep to my initial solution of 1 ac97
device discovered is bound on the ac97 to _at most_ 1 ac97 driver, or is there a
know smart way to have several drivers for one device (that sounds a bit heretic
regarding my understanding of the device/driver model but who knows ...) ?

Cheers.

--
Robert
