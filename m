From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 25 Mar 2014 17:00:21 +0100
Subject: [PATCH] Xen: do hv callback accounting only on x86
In-Reply-To: <5057041.71iuvlcH4G@wuerfel>
References: <5057041.71iuvlcH4G@wuerfel>
Message-ID: <12121341.4lKFpaRMcO@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 25 March 2014 16:52:25 Arnd Bergmann wrote:
> diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
> index 5dd2ddf..8b91c256 100644
> --- a/drivers/xen/events/events_base.c
> +++ b/drivers/xen/events/events_base.c
> @@ -1235,6 +1235,7 @@ void xen_evtchn_do_upcall(struct pt_regs *regs)
>  #ifdef CONFIG_X86
>         exit_idle();
>  #endif
> +       inc_irq_stat(irq_hv_callback_count);
> 
>         __xen_evtchn_do_upcall();
> 
> diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
> index d5a3de8..dfa12a4 100644
> --- a/drivers/xen/events/events_base.c
> +++ b/drivers/xen/events/events_base.c
> @@ -1248,8 +1248,8 @@ void xen_evtchn_do_upcall(struct pt_regs *regs)
>         irq_enter();
>  #ifdef CONFIG_X86
>         exit_idle();
> -#endif
>         inc_irq_stat(irq_hv_callback_count);
> +#endif
>  
>         __xen_evtchn_do_upcall();

That was unintended: the first half of this email is actually the patch
that introduced the bug, while the second half is my workaround.
The way it's formatted, you won't be able to apply it without removing
the first half again. I'll wait if the approach is ok first and then
resend it properly if needed.

	Arnd
