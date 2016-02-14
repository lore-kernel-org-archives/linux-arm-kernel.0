From: linux@roeck-us.net (Guenter Roeck)
Date: Sun, 14 Feb 2016 13:08:42 -0800
Subject: arm qemu test failures due to 'driver-core: platform: probe
 of-devices only using list of compatibles'
In-Reply-To: <20160214195501.GA12289@pengutronix.de>
References: <20160214165010.GA3189@roeck-us.net>
 <20160214195501.GA12289@pengutronix.de>
Message-ID: <56C0ECDA.1000203@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/14/2016 11:55 AM, Uwe Kleine-K?nig wrote:
> [adding lakml and rmk to Cc]
>
> Hello Guenter,
>
> On Sun, Feb 14, 2016 at 08:50:10AM -0800, Guenter Roeck wrote:
>> Uwe,
>>
>> Your patch 'driver-core: platform: probe of-devices only using list of
>> compatibles' causes the following qemu tests to crash in -next.
>>
>> arm:vexpress-a9:vexpress_defconfig:vexpress-v2p-ca9
>> arm:vexpress-a15:vexpress_defconfig:vexpress-v2p-ca15-tc1
>> arm:vexpress-a9:multi_v7_defconfig:vexpress-v2p-ca9
>> arm:vexpress-a15:multi_v7_defconfig:vexpress-v2p-ca15-tc1
>>
>> Crash log:
>>
>> VFS: Cannot open root device "mmcblk0" or unknown-block(0,0): error -6
>> Please append a correct "root=" boot option; here are the available partitions:
>> 1f00          131072 mtdblock0  (driver?)
>> 1f01           32768 mtdblock1  (driver?)
>> Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
>>
>> ie the mmc driver no longer instantiates. Reverting the patch fixes the problem.
>
> The driver is drivers/mmc/host/mmci.c, right? and the relevant device
> tree snippet is:
>
> 	mmci at 05000 {
> 		compatible = "arm,pl180", "arm,primecell";
> 		...
> 	};
>

Yes, I think so, or one of the many other similar mmc entries.

> ? So the unexpected abnormality here is that even though this device is
> instantiated by dt, the driver doesn't provide any compatibles.
> Either my expectation is wrong, then 67d02a1bbb33455 should be reverted
> (or handle this case in a different way), or the mmci driver should
> declare compatibles (but then it needs to be a platform driver and not
> an amba driver?).
>

No idea what the correct solution would be. I do see

         if (of_device_is_compatible(bus, "arm,primecell")) {
                 /*
                  * Don't return an error here to keep compatibility with older
                  * device tree files.
                  */
                 of_amba_device_create(bus, bus_id, platform_data, parent);
                 return 0;
         }

in drivers/of/platform.c, which suggests some special handling for amba
devices. No idea if and how that is related, but I do have some concern
that fixing the problem for mmc alone might not fix it for all the other
devices instantiated with "arm,primecell". After all, my boot tests are
really rudimentary (it boots, therefore it works).

Thanks,
Guenter
