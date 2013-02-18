From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Feb 2013 14:39:08 +0000
Subject: [PATCH 02/08] ARM: shmobile: Rework SH73A0_SCU_BASE IOMEM() usage
In-Reply-To: <20130218134707.17303.48589.sendpatchset@w520>
References: <20130218134648.17303.97576.sendpatchset@w520>
 <20130218134707.17303.48589.sendpatchset@w520>
Message-ID: <201302181439.08639.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 February 2013, Magnus Damm wrote:
>  #define PSTR_SHUTDOWN_MODE     3
>  
> -#define SH73A0_SCU_BASE IOMEM(0xf0000000)
> +#define SH73A0_SCU_BASE 0xf0000000
>  
>  #ifdef CONFIG_HAVE_ARM_TWD
>  static DEFINE_TWD_LOCAL_TIMER(twd_local_timer, SH73A0_SCU_BASE + 0x600, 29);
> @@ -81,7 +81,7 @@ static void __init sh73a0_smp_prepare_cp
>  static void __init sh73a0_smp_init_cpus(void)
>  {
>         /* setup sh73a0 specific SCU base */
> -       shmobile_scu_base = SH73A0_SCU_BASE;
> +       shmobile_scu_base = IOMEM(SH73A0_SCU_BASE);
>  
>         shmobile_smp_init_cpus(scu_get_core_count(shmobile_scu_base));
>  }

Ok, this gets rid of the warning, but I'm a bit worried about
how it is hardwiring the fact that the SCU physical address has
the same bit pattern as the __iomem token.

While I realize that you already rely on this in a lot of places
in the shmobile code, I see a red light going off every time I read
code like this, and it is not any more logical than the previous
version.

It would be nice to keep these address spaces separate at least
in new code, mostly in order to not confuse reviewers with code
that is based on assumptions which are not generally true, but also
to be more flexible with the virtual memory layout. On a related
topic, you are using an entire 256 MB section of your virtual
address space for sh73a0 and sh7372 and 160 MB for r8a7740. Putting
less of that into the identity mapped area would free up space for
vmalloc, but it's hard to prove that doing this is correct when
you have all sorts of code using a hardcoded virtual MMIO address
token.

	Arnd
