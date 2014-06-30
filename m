From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 30 Jun 2014 08:43:21 +0200
Subject: [PATCH] Fixes gemmi_idle in file idle.c
In-Reply-To: <1404096760-5239-1-git-send-email-xerofoify@gmail.com>
References: <1404096760-5239-1-git-send-email-xerofoify@gmail.com>
Message-ID: <72959333.SxQIV7k7ca@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 29 June 2014 22:52:40 Nicholas Krause wrote:
> disables the IRQ line in gemmi_idle before calling cpu_do_idle.
> In addition, according to the Fixme message in this file fixes
> races that may occur due to not disabling the IRQ before calling
> cpu_do_idle.
> 
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>

Have you actually read the comment above the function?

> diff --git a/arch/arm/mach-gemini/idle.c b/arch/arm/mach-gemini/idle.c
> index ddf8ec9..2880f5a 100644
> --- a/arch/arm/mach-gemini/idle.c
> +++ b/arch/arm/mach-gemini/idle.c
> @@ -17,8 +17,7 @@ static void gemini_idle(void)
>          * disabled.
>          */
>  
> -       /* FIXME: Enabling interrupts here is racy! */
> -       local_irq_enable();
> +       local_irq_disable();
>         cpu_do_idle();
>  }

This has the same effect as deleting the entire file. Doing that
is probably the right thing now that 8182a34d85698 ("ARM: 7760/1:
cpu_fa526_do_idle: remove WFI") has been merged, but that needs
a better changeset description to explain why it was needed before
and is not needed any more.

Please submit a new patch doing that.

	Arnd
