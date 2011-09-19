From: olof@lixom.net (Olof Johansson)
Date: Mon, 19 Sep 2011 13:08:13 -0700
Subject: [PATCH] arm/dt: Add SoC detection macros
In-Reply-To: <3C7A7ACA8617D24290826EC008B5CD083E17B00988@HQMAIL03.nvidia.com>
References: <1315555339-12685-1-git-send-email-amartin@nvidia.com>
	<20110917102811.GC16381@n2100.arm.linux.org.uk>
	<20110917103457.GP28104@game.jcrosoft.org>
	<20110917112321.GE16381@n2100.arm.linux.org.uk>
	<3C7A7ACA8617D24290826EC008B5CD083E17B00988@HQMAIL03.nvidia.com>
Message-ID: <CAOesGMjkYecYH=+YawN=v10C+Ciu-6HuWgei-d3_8ByYLSZ9rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2011 at 10:26 AM, Allen Martin <AMartin@nvidia.com> wrote:
>> What I'm saying is that in that scenario it should not be necessary to edit the
>> kernel to invent new SoC types, and then teach it that Tegra4 is mostly the
>> same as Tegra3. ?That information should all be encoded into the DT rather
>> than the C code in the kernel.
>>
>> So, I think adding this SoC type stuff is the wrong approach to the problem.
>
> What ends up happening in practice for a lot of hw blocks inside the SoC, is that tegra4 is mostly the same as tegra3 with a few new registers and bug fixes that slightly change the programming model. ?So either we have to add device quirks to teach device tree about the differences, and pass those in as flags to the driver, or we can do SoC detection at runtime in the driver. ?It sounds like the consensus from you and Olof is that the first is preferable.

Well, my fear of making a performance-optimized implementation of this
is that it will be overused at runtime. As an example on how it should
not look when starting out on a new driver today, look at the gpio
driver for omap. It looks the way it does because they merged the 3
separate implementations together, but they have a bunch of functions
in there that have three completely different code paths depending on
which platform they are on. For those, having three different
functions, and a function pointer to reach it through, makes more
sense.

But for to-be-upstreamed SoC support for, for example, tegra3 -- a
platform that has device-tree support -- it would be better to do a
new compatible field in the device tree for it, and thus at the time
of probing of the device (in the driver) you will know if it's a
tegra2 or tegra3 gpio controller you are configuring. Based on that,
you can setup your driver to behave appropriately -- some of that
might of course still be runtime checks, but hopefully not too much of
it.

The SoC detection-at-runtime doesn't scale and map to drivers all that
cleanly either. Today you have a linear roadmap of devices where
development happens on the "family number" field. What if there is a
future T32 that is an evolution of T30 but with tegra4's gpio
controller, for example [assuming numbering is similar to today's
tegra2 t20/t25/etc]?   It's better to do the versioning per
IP/device/driver, than trying to map a global version/product number
per-driver to different behavior.


-Olof
