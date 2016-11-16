From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 16 Nov 2016 08:24:59 -0800
Subject: [PATCH v2 0/3] ARM: davinci: PM: cleanup init, add DT support
In-Reply-To: <c0f1cfa2-4086-72fc-783b-d0d8c837cb08@ti.com> (Sekhar Nori's
 message of "Wed, 16 Nov 2016 16:50:09 +0530")
References: <20161115195421.19983-1-khilman@baylibre.com>
 <c0f1cfa2-4086-72fc-783b-d0d8c837cb08@ti.com>
Message-ID: <m260nnxuhw.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sekhar Nori <nsekhar@ti.com> writes:

> Hi Kevin,
>
> On Wednesday 16 November 2016 01:24 AM, Kevin Hilman wrote:
>> This series removes the fake platform_device used to initialize PM on
>> legacy davinci platforms, and also adds PM support for DT platforms.
>> 
>> Tested with legacy boot on da850-evm, and DT boot on da850-lcdk.  Used
>> RTC to wake from suspend-to-RAM: e.g. rtcwake -m mem -s 4 -d /dev/rtc0
>
> With these patches applied, I saw the following randconfig build error.
>
> arch/arm/mach-davinci/built-in.o: In function `davinci_pm_init':
> pm_domain.c:(.init.text+0x13d8): undefined reference to `da8xx_get_mem_ctlr'
> pm_domain.c:(.init.text+0x14bc): undefined reference to `da8xx_syscfg1_base'
> make: *** [vmlinux] Error 1
>
> Attached is the defconfig. I did not check to see if your patches 
> introduced it or if this is something that always existed and never 
> caught.

It looks like a new problem caused by moving those calls into pm.c.

The problem is that currently pm.o can be built even when da850 support
is not enabled, which is the case in your defconfig.

I'll hae a look at how to cleanup that dependency.

Kevin
