From: rnayak@ti.com (Rajendra Nayak)
Date: Thu, 16 Feb 2012 18:45:50 +0530
Subject: [PATCH 0/3] omap hsmmc init cleanup and section warning fixes
 for v3.4 merge window
In-Reply-To: <4F3CF7D1.8050807@ti.com>
References: <20120215182355.18884.18682.stgit@kaulin.local>
 <CACYZBRE_Vf8qDQYPRgsL03T8oy2Kv4fYRfE8U7y79Xhb1nwC2A@mail.gmail.com>
 <20120216121234.GJ15338@n2100.arm.linux.org.uk> <4F3CF7D1.8050807@ti.com>
Message-ID: <4F3D0186.2010500@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 February 2012 06:04 PM, Rajendra Nayak wrote:
>> Can you test something with these patches?
>>
>> 1. Build the gpio-twl4030.c as a module, but with HSMMC support built in
>> 2. Boot on the 4430SDP
>
> twl4030 gpio is used for card detect on OMAP3, so I tried this
> on my Beagle instead of 4430SDP.
> The kernel boots up but does not detect/enumerate the mmc card.
>
>> 3. Load the gpio-twl4030 module
>
> I was expecting this to now detect the card, but I instead got
> this error which seems to tell gpio-twl4030 has problems
> when built/used as a module, outside of the mmc issues.

Looks like I was mislead with the errors and though the twl4030
gpio probe was bailing out with errors, which its not.
It does seem to go ahead, does a mmc late init which registers
the mmc omap_device and hence does a platform_device_add, but the
device never seem to get probed. mmc driver is built in and
registered.

>
> # insmod gpio-twl4030.ko
> [   16.217864] twl4030_gpio twl4030_gpio: can't dispatch IRQs from modules
> [   16.242004] gpiochip_add: registered GPIOs 192 to 211 on device: twl4030
>
>
>> 4. Remove the gpio-twl4030 module
>> 5. Re-load the gpio-twl4030.ko module
>>
>> and report back what you get.  Thanks.
