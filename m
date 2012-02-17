From: rnayak@ti.com (Rajendra Nayak)
Date: Fri, 17 Feb 2012 15:29:55 +0530
Subject: [PATCH 0/3] omap hsmmc init cleanup and section warning fixes
 for v3.4 merge window
In-Reply-To: <4F3E1ED5.6090305@ti.com>
References: <20120215182355.18884.18682.stgit@kaulin.local>
 <CACYZBRE_Vf8qDQYPRgsL03T8oy2Kv4fYRfE8U7y79Xhb1nwC2A@mail.gmail.com>
 <20120216121234.GJ15338@n2100.arm.linux.org.uk> <4F3CF7D1.8050807@ti.com>
 <4F3D0186.2010500@ti.com> <20120216135151.GK15338@n2100.arm.linux.org.uk>
 <20120217091433.GL15338@n2100.arm.linux.org.uk> <4F3E1ED5.6090305@ti.com>
Message-ID: <4F3E251B.6040404@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 17 February 2012 03:03 PM, Rajendra Nayak wrote:
> Sorry, I did'nt repond back because I wanted to get this resolved
> completely before I did.
>
> (3) did not probe the inserted mmc device because the driver was
> doing a platform_driver_probe() and not a platform_driver_register().
>
> Once I fixed that and removed the __init from probe, I then hit a
> failure with gpio_to_irq() call in the mmc driver probe.
>
> This was beacuse the twl gpio driver does not register irqs as said by
> this error at driver load...
>  >>>> [   16.217864] twl4030_gpio twl4030_gpio: can't dispatch IRQs from
> modules
> ... apparently because there is no way to unregister a irq once the
> module is unloaded.
>
> That makes sdmmc pretty much unusable if twl gpio is built as a module.
>
>>
>> Tony: I think there's a bug here - if the gpio-twl4030 module is
>> inserted,
>> removed and re-inserted, I think we'll end up creating the devices for
>> MMC
>> twice with the same name, resulting in sysfs complaining very loudly.
>
> I still went ahead and tried (4) becasue I knew I would hit the above
> issue. However I end up with a rmmod complaining 'resource temporarily
> unavailable' because I see there are 3 gpio_requests, which I found
> were from the .setup callback in the board file (I am using beagle).
> The beagle board file does not seem to however register a .teardown
> hook provided by twl4030 gpio platform_data structure to do a gpio_free.
> So I am now trying to get the teardown function clean stuff up including
> unregister the mmc device, which should also fix the problem with
> multiple mmc device register that you reported with insmod/rmmod/insmod
>   sequence.

hmm, rmmod does not even seem to trigger the drivers .remove if there
are outstanding requests on the module, so a pdata->teardown called
from within the .remove does not help to get the gpio_requests done
from the board file cleaned.
