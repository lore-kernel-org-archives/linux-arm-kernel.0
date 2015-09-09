From: andy.yan@rock-chips.com (Andy Yan)
Date: Wed, 9 Sep 2015 09:08:55 +0800
Subject: set rockchip-specific uboot bootmode flags on reboot
In-Reply-To: <9364768.6AeuYh3EEP@diego>
References: <1441716187-29446-1-git-send-email-andy.yan@rock-chips.com>
 <9364768.6AeuYh3EEP@diego>
Message-ID: <55EF86A7.10306@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko:

On 2015???09???09??? 06:46, Heiko St??bner wrote:
> Hi Andy,
>
> Am Dienstag, 8. September 2015, 20:43:07 schrieb Andy Yan:
>> rockchip platform have a protocol to pass the the kernel
>> reboot mode to bootloader by some special registers when
>> system reboot.By this way the bootloader can take different
>> action according to the different kernel reboot mode, for
>> example, command "reboot loader" will reboot the board to
>> rockusb mode, this is a very convenient way to get the board
>> to download mode.
>>
>> Signed-off-by: Andy Yan<andy.yan@rock-chips.com>
> [...]
>
>> @@ -0,0 +1,22 @@
>> +#ifndef __MACH_ROCKCHIP_LOADER_H
>> +#define __MACH_ROCKCHIP_LOADER_H
>> +
>> +/*high 24 bits is tag, low 8 bits is type*/
>> +#define SYS_LOADER_REBOOT_FLAG   0x5242C300
>> +
>> +enum {
>> +	BOOT_NORMAL = 0, /* normal boot */
>> +	BOOT_LOADER,     /* enter loader rockusb mode */
>> +	BOOT_MASKROM,    /* enter maskrom rockusb mode (not support now) */
>> +	BOOT_RECOVER,    /* enter recover */
>> +	BOOT_NORECOVER,  /* do not enter recover */
>> +	BOOT_SECONDOS,   /* boot second OS (not support now)*/
>> +	BOOT_WIPEDATA,   /* enter recover and wipe data. */
>> +	BOOT_WIPEALL,    /* enter recover and wipe all data. */
>> +	BOOT_CHECKIMG,   /* check firmware img with backup part*/
>> +	BOOT_FASTBOOT,   /* enter fast boot mode */
>> +	BOOT_SECUREBOOT_DISABLE,
>> +	BOOT_CHARGING,   /* enter charge mode */
>> +	BOOT_MAX         /* MAX VALID BOOT TYPE.*/
>> +};
>> +#endif
> These flags rely on code in the bootloader to actually handle the target
> action. Nowadays this is uboot, but still a rockchip-specific fork. And we're
> actively moving away from that, with the recent rk3288 addition to mainline
> uboot.
? ?  Sorry, I don't know about this action before, but this is really a 
very convenient way
? ?  to get machine enter download mode, it seems that many Android devices
? ?  have this function to support commands like "reboot recovery", 
"reboot fastboot".
? ?  Why should we moving away from that?
> So unless you convince uboot people that the _underlying special
> functionality_ behind these flags should be part of uboot, I don't think this
> is going to fly.
>
>
> In a way this is similar to gpu kernel code talking to proprietary userspace
> libs - these are also not eligible for the kernel. (meaning stuff like the
> mali kernel driver not being allowed).
>
> [...]
>
>> +static int rockchip_reboot_notify(struct notifier_block *this,
>> +				  unsigned long mode, void *cmd)
>> +{
>> +	u32 flag;
>> +
>> +	rockchip_get_reboot_flag(cmd, &flag);
>> +	regmap_write(regmap, flag_reg, flag);
>> +
>> +	return NOTIFY_DONE;
>> +}
>> +
>> +static struct notifier_block rockchip_reboot_handler = {
>> +	.notifier_call = rockchip_reboot_notify,
>> +	.priority = 150,
>> +};
> the restart handlers are meant to really only restart the system, not to
> execute some actions before the restart happens.
>
> Seehttps://lkml.org/lkml/2015/6/3/707  for a similar case.
>
    So maybe I can use reboot notifier here?
   Thank you.
> Heiko
>
>
>
