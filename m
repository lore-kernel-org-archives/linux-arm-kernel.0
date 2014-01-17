From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 17 Jan 2014 17:52:46 +0100
Subject: [PATCH V3 3/3] power: reset: use syscon driver to parse reboot
 register from scu
In-Reply-To: <1389748055-23534-4-git-send-email-fkan@apm.com>
References: <1389748055-23534-1-git-send-email-fkan@apm.com>
 <1389748055-23534-4-git-send-email-fkan@apm.com>
Message-ID: <201401171752.47393.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 15 January 2014, Feng Kan wrote:
> +static int __init xgene_reboot_init(void)
>  {
>         arm_pm_restart = xgene_restart;
>         return 0;
>  }
>  device_initcall(xgene_reboot_init);

This won't work on a generic kernel, since you unconditionally set the
pm_restart function to your own, which is broken for everything else.

Please keep the platform_driver to attach to the reboot device
as you had before. It might be good to turn this into a generic
"syscon-reset" driver that gets both the register number and
the contents to write from the device node.

	Arnd
