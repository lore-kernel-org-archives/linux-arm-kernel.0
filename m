From: djkurtz@chromium.org (Daniel Kurtz)
Date: Thu, 17 Dec 2015 10:52:48 +0800
Subject: [PATCH v2] soc: mediatek: SCPSYS: use module_platform_driver
In-Reply-To: <56715136.3060908@gmail.com>
References: <1450263656-12513-1-git-send-email-s.hauer@pengutronix.de>
 <1562792.sV6cmsyeOM@wuerfel> <56715136.3060908@gmail.com>
Message-ID: <CAGS+omA1mgmFH_JXffUTC-aq3rOy7dRYsdveiJ8LcnB5gg0ELw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sasha, Matthias,

On Wed, Dec 16, 2015 at 7:55 PM, Matthias Brugger
<matthias.bgg@gmail.com> wrote:
>
>
> On 16/12/15 12:22, Arnd Bergmann wrote:
>>
>> On Wednesday 16 December 2015 12:00:56 Sascha Hauer wrote:
>>>
>>> With regulator support to the scpsys driver needs to be able to defer
>>> probe. Probe deferral is incompatible with module_platform_driver_probe,
>>> so use module_platform_driver. module_platform_driver_probe sets the
>>> suppress_bind_attrs. To prevent unbinding the device with
>>> module_platform_driver we have to set the flag explicitly in the driver
>>> now.
>>>
>>> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>>> ---
>>>
>>
>> Looks good now,
>>
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>>
>
> Applied to v4.4-next/soc

This patch does not compile on my system.

With "CONFIG_DEBUG_SECTION_MISMATCH=y" I see:

WARNING: vmlinux.o(.data+0x387c8): Section mismatch in reference from
the variable scpsys_drv to the function .init.text:scpsys_probe()
The variable scpsys_drv references
the function __init scpsys_probe()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

FATAL: modpost: Section mismatches detected.
Set CONFIG_SECTION_MISMATCH_WARN_ONLY=y to allow them.


The problem is that scpsys_probe() is still __init, but it references
scp_domain_data[] which is __initconst.
However, scpsys_drv is not __initdata, so it cannot contain a pointer
to an __init function.

The only way I know to fix this is by dropping the __init & __initconst.
This is rather unfortunate.
Is there another way where we can use -EPROBE_DEFER and still preserve
__init / __initconst ?

Also, since scpsys' Kconfig is "bool" not "tristate" it isn't a real
module so I think we should use:
builtin_platform_driver not module_platform_driver

CC'ing Paul Gortmaker who seems to be on a mass
builtin_platform_driver conversion at the moment, see:
https://lkml.org/lkml/2015/12/9/952

-Dan
