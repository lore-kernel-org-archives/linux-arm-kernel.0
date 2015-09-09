From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 09 Sep 2015 09:06:06 +0900
Subject: [PATCH] ARM: exynos_defconfig: Enable USB Video Class support
In-Reply-To: <55EEE370.9040705@osg.samsung.com>
References: <1441662323-15468-1-git-send-email-javier@osg.samsung.com>
 <55EE9820.2010202@samsung.com> <55EE9F1A.9030703@osg.samsung.com>
 <55EEDECA.4040407@samsung.com> <55EEE370.9040705@osg.samsung.com>
Message-ID: <55EF77EE.10301@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08.09.2015 22:32, Javier Martinez Canillas wrote:

(...)

>  
>> Let me rephrase my question into:
>> 1. What is worth enabling in exynos_defconfig? USB devices? I would
>> argue, except they are needed to boot.
> 
> Ok, I understand your concern. The question is where we draw the line.
> 
>> So maybe enable everything which Exynos boards have hard-wired? That
>> would make some sense... but we're making kernel larger.
>>
> 
> In the case of this WebCam, it's not a typical USB device in the sense
> that is built in the Chromebook and not something that's plugged on an
> external USB port.

Right, that is the difference from regular USB devices.

>  
>> 2. Maybe enable only what is a typical use case (including typical
>> testing cases)? Then we would have to define what "typical" means. For
>> example battery would be typical but camera would not.
>>
> 
> There are a lot of board specific drivers that we currently enable as
> built-in like hwmon sensors or iio devices that are likely only present
> on a single board or a family of boards.
> 
> So then I think all those drivers should be changed as a module as well,
> unless are critical for the board operation (i.e: thermal or fan drivers).

Actually I think we should not judge by number of board using given
component but its usefulness in general exynos_defconfig case. Even when
something is used on just one board but it is important for that board,
then it should be built-in.

For example hwmon monitoring stuff to get information about board
condition. Other example are leds on Odroid - to get visible condition
of the board.

This don't have to be critical, but just important for testing.

Additionally such components can be accessed usually from limited
user-space, e.g. system booted to console or SSH.

If using a component requires more complex user-space (e.g. any kind of
window system), then probably already modules could be easily used. In
such cases I would expect the boot is not from network but from MMC and
there is a full-blown distro working.


>> 3. Argh, so maybe, if we agree that not everything is worth being
>> enabled, that additional stuff could be build as module?
>>
> 
> Yes, I don't see anything wrong to enable more stuff as a module if
> that will give more build / test coverage.
> 
> The goal of kernelci is to add functional tests so besides testing
> if a given kernel booted correctly, it's going to test if for example
> USB enumeration is working and has no regressions. For that use case
> is interesting to have support for the built-in USB devices like this
> camera (either as built-in or as a module).

Okay, so we have some agreement that other stuff which is not important
but still hard-wired on Exynos boards (built into the board), can be
enabled as a module. So now we we have to draw the line which is
"important enough" to built-in and which is not so it could be as module.

>From my point of view media in general (cameras, tuners etc.) should be
put in the second category (module), especially that in usual to test
them you would have to boot system to a full graphical mode. Can you
test them from SSH connection? Maybe you could test DVB tuners by
reading status of packets but still output won't be visible.

Any comments from other interested parties?

Best regards,
Krzysztof
