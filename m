From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 20 Mar 2014 09:49:00 +0800
Subject: [PATCH 12/62] ARM: hisi: fix building without CONFIG_HOTPLUG_CPU
In-Reply-To: <1395257399-359545-13-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-13-git-send-email-arnd@arndb.de>
Message-ID: <CAN1soZyj_e9LBf3H6nBGGYRT5at7ZeY_Dr4QJeoQKSpMHPePhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 20, 2014 at 3:29 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> The hisi SMP code always uses the hi3xxx_set_cpu() function
> defined in the hotplug.c file, so we cannot build without
> this when CONFIG_SMP is enabled. This patch slightly restructures
> the code so we always build the parts of hotplug.c that we need
> but just leave out the CPU disable logic if CONFIG_HOTPLUG_CPU
> is turned off.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> ---
>  arch/arm/mach-hisi/Makefile  | 3 +--
>  arch/arm/mach-hisi/hotplug.c | 2 ++
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-hisi/Makefile b/arch/arm/mach-hisi/Makefile
> index 6870058..2ae1b59 100644
> --- a/arch/arm/mach-hisi/Makefile
> +++ b/arch/arm/mach-hisi/Makefile
> @@ -3,5 +3,4 @@
>  #
>
>  obj-y  += hisilicon.o
> -obj-$(CONFIG_SMP)              += platsmp.o
> -obj-$(CONFIG_HOTPLUG_CPU)      += hotplug.o
> +obj-$(CONFIG_SMP)              += platsmp.o hotplug.o
> diff --git a/arch/arm/mach-hisi/hotplug.c b/arch/arm/mach-hisi/hotplug.c
> index b909854..abd441b 100644
> --- a/arch/arm/mach-hisi/hotplug.c
> +++ b/arch/arm/mach-hisi/hotplug.c
> @@ -178,6 +178,7 @@ static inline void cpu_enter_lowpower(void)
>           : "cc");
>  }
>
> +#ifdef CONFIG_HOTPLUG_CPU
>  void hi3xxx_cpu_die(unsigned int cpu)
>  {
>         cpu_enter_lowpower();
> @@ -198,3 +199,4 @@ int hi3xxx_cpu_kill(unsigned int cpu)
>         hi3xxx_set_cpu(cpu, false);
>         return 1;
>  }
> +#endif
> --
> 1.8.3.2
>

Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
