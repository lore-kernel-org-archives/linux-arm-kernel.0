From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 23 Sep 2015 01:16:15 +0200
Subject: set rockchip-specific uboot bootmode flags on reboot
In-Reply-To: <55FA9EDA.8010308@rock-chips.com>
References: <1441716187-29446-1-git-send-email-andy.yan@rock-chips.com>
 <CAPnjgZ0n7aNY7FRnoDYUBEnQAtUO1BWKs6DDzaMQyHsg1kQ1Jg@mail.gmail.com>
 <55FA9EDA.8010308@rock-chips.com>
Message-ID: <8498512.JKlZEAjChn@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,


Am Donnerstag, 17. September 2015, 19:07:06 schrieb Andy Yan:
> On 2015?09?10? 02:05, Simon Glass wrote:
> > Hi,
> > 
> > On 8 September 2015 at 16:46, Heiko St?bner <heiko@sntech.de> wrote:
> >> Hi Andy,
> >> 
> >> Am Dienstag, 8. September 2015, 20:43:07 schrieb Andy Yan:
> >>> rockchip platform have a protocol to pass the the kernel
> >>> reboot mode to bootloader by some special registers when
> >>> system reboot.By this way the bootloader can take different
> >>> action according to the different kernel reboot mode, for
> >>> example, command "reboot loader" will reboot the board to
> >>> rockusb mode, this is a very convenient way to get the board
> >>> to download mode.
> >>> 
> >>> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> >> 
> >> [...]
> >> 
> >>> @@ -0,0 +1,22 @@
> >>> +#ifndef __MACH_ROCKCHIP_LOADER_H
> >>> +#define __MACH_ROCKCHIP_LOADER_H
> >>> +
> >>> +/*high 24 bits is tag, low 8 bits is type*/
> >>> +#define SYS_LOADER_REBOOT_FLAG   0x5242C300
> >>> +
> >>> +enum {
> >>> +     BOOT_NORMAL = 0, /* normal boot */
> >>> +     BOOT_LOADER,     /* enter loader rockusb mode */
> >>> +     BOOT_MASKROM,    /* enter maskrom rockusb mode (not support now)
> >>> */
> >>> +     BOOT_RECOVER,    /* enter recover */
> >>> +     BOOT_NORECOVER,  /* do not enter recover */
> >>> +     BOOT_SECONDOS,   /* boot second OS (not support now)*/
> >>> +     BOOT_WIPEDATA,   /* enter recover and wipe data. */
> >>> +     BOOT_WIPEALL,    /* enter recover and wipe all data. */
> >>> +     BOOT_CHECKIMG,   /* check firmware img with backup part*/
> >>> +     BOOT_FASTBOOT,   /* enter fast boot mode */
> >>> +     BOOT_SECUREBOOT_DISABLE,
> >>> +     BOOT_CHARGING,   /* enter charge mode */
> >>> +     BOOT_MAX         /* MAX VALID BOOT TYPE.*/
> >>> +};
> >>> +#endif
> >> 
> >> These flags rely on code in the bootloader to actually handle the target
> >> action. Nowadays this is uboot, but still a rockchip-specific fork. And
> >> we're actively moving away from that, with the recent rk3288 addition to
> >> mainline uboot.
> >> 
> >> So unless you convince uboot people that the _underlying special
> >> functionality_ behind these flags should be part of uboot, I don't think
> >> this is going to fly.
> >> 
> >> 
> >> In a way this is similar to gpu kernel code talking to proprietary
> >> userspace libs - these are also not eligible for the kernel. (meaning
> >> stuff like the mali kernel driver not being allowed).
> > 
> > I don't want to comment on what Linux does or does not want. But I can
> > see this sort of feature being useful for devs at least. So long as it
> > is defined in a way that is not Rockchip-specific (and the above enum
> > looks pretty reasonable on that front, I think it makes sense.
> > 
> > Of course it's a bit odd to target a downstream U-Boot with a Linux
> > feature. But hopefully Rockchip's U-Boot support and development will
> > move to mainline with time.
> 
>     Is there any chance for this patch to be landed?
>     As Simon says, it is useful for development. And
>     he is upstreaming Rockchip U-boot.

Sorry that I'm still dragging my feet with this, but I'm still struggling with 
what to do.

I did talk to the arm-soc maintainers and doing this in general seems to be 
fine. Olof was very in favour, others pointed out that just passing through 
the command into the register might be the best solution - without having to 
translate stuff in the kernel.
 

So I guess the translation table (string to number) is the thing to talk 
about. I guess my worries are three-fold:

- will this actually be stable or do we get a future where this translation 
gets to be soc-specific, like "if rk3288 table_a; if rk3368 table_b ..." ?

- can we trim that down to actually supported modes?

- I forgot that we already have other mass-production bootloaders, so what 
does coreboot on veyron devices do with these register-values?


As it is probably also valid for rk3368 and following, I guess it should live 
somehow in drivers/soc/rockchip too.


Heiko

> 
> >> [...]
> >> 
> >>> +static int rockchip_reboot_notify(struct notifier_block *this,
> >>> +                               unsigned long mode, void *cmd)
> >>> +{
> >>> +     u32 flag;
> >>> +
> >>> +     rockchip_get_reboot_flag(cmd, &flag);
> >>> +     regmap_write(regmap, flag_reg, flag);
> >>> +
> >>> +     return NOTIFY_DONE;
> >>> +}
> >>> +
> >>> +static struct notifier_block rockchip_reboot_handler = {
> >>> +     .notifier_call = rockchip_reboot_notify,
> >>> +     .priority = 150,
> >>> +};
> >> 
> >> the restart handlers are meant to really only restart the system, not to
> >> execute some actions before the restart happens.
> >> 
> >> See https://lkml.org/lkml/2015/6/3/707 for a similar case.
> >> 
> >> 
> >> Heiko
> > 
> > Regards,
> > Simon
