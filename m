From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Sun, 9 Jun 2013 19:03:08 +0200
Subject: N900 device tree conversion: how to do first step
In-Reply-To: <20130609164745.GB16066@amd.pavel.ucw.cz>
References: <20130609015944.GA23559@amd.pavel.ucw.cz>
 <201306091124.41251@pali> <20130609164745.GB16066@amd.pavel.ucw.cz>
Message-ID: <201306091903.09766@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 09 June 2013 18:47:45 Pavel Machek wrote:
> On Sun 2013-06-09 11:24:40, Pali Roh?r wrote:
> > On Sunday 09 June 2013 03:59:44 Pavel Machek wrote:
> > > Hi!
> > > 
> > > I'd like to convert Nokia N900 to device tree.
> > > 
> > > Unfortunately, serial port is not easily available (very
> > > special cable would be needed, does someone know where to
> > > get one?) and I don't have BDI (and very special cable
> > > would be needed, too).
> > 
> > Hello,
> > 
> > I used serial port only in qemu for debugging. Maybe you can
> > try to play with qemu first. Qemu has good n900 HW support.
> 
> Yes, qemu is helpful.
> 
> For the record: this is how you use it.
> 
> KERNEL=/data/l/linux-n900/zImage_dtb
> ./qflasher -m rx51 -x ./xloader-qemu.bin -s
> ./secondary-qemu.bin -k $KERNEL -o n900.img -p k=6072
> 
> > sd-empty
> 
> ./qemu-system-arm -s -M n900 -mtdblock n900.img -sd sd-empty
> -serial stdio -clock unix -redir tcp:5555:10.0.2.15:22
> 
> ...and this patch is needed to make it past rx51_init.
> 
> Author: Pavel <pavel@ucw.cz>
> Date:   Sun Jun 9 18:45:39 2013 +0200
> 
>     Comment out errata workaround that breaks qemu.
> 
> diff --git a/arch/arm/mach-omap2/board-rx51.c
> b/arch/arm/mach-omap2/board-rx51.c index 938e46f..0ffd7d3
> 100644
> --- a/arch/arm/mach-omap2/board-rx51.c
> +++ b/arch/arm/mach-omap2/board-rx51.c
> @@ -108,11 +108,13 @@ static void __init rx51_init(void)
>  	rx51_peripherals_init();
>  	rx51_camera_init();
> 
> +#if 0
>  #ifdef CONFIG_ARM_ERRATA_430973
>  	printk(KERN_INFO "RX-51: Enabling ARM errata 430973
> workaround.\n"); /* set IBE to 1 */
>  	rx51_secure_update_aux_cr(1 << 6, 0);
>  #endif
> +#endif
> 
>  	/* Ensure SDRC pins are mux'd for self-refresh */
>  	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);

Hm, right qemu not running in omap secure mode, so it can really 
break booting. So before calling secure code it is needed to 
check if we are really on secure device. I think this code help:

if (omap_type() == OMAP2_DEVICE_TYPE_SEC)

Can somebody confirm if above check is correct for OMAP3 HS 
device? And also if it does not pass in qemu?

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130609/fcaf77e7/attachment.sig>
