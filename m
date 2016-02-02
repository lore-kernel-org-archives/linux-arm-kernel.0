From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 02 Feb 2016 22:34:22 +0100
Subject: [PATCH] ARM: mx25: Add basic suspend/resume support
In-Reply-To: <1454447886-4045-1-git-send-email-festevam@gmail.com>
References: <1454447886-4045-1-git-send-email-festevam@gmail.com>
Message-ID: <4987443.OL55qNe4Wb@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 02 February 2016 19:18:06 Fabio Estevam wrote:
> +#ifdef CONFIG_PM
> +static int imx25_suspend_enter(suspend_state_t state)
> +{
> +       switch (state) {
> +       case PM_SUSPEND_MEM:
> +               cpu_do_idle();
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +#else
> +static inline int imx25_suspend_enter(suspend_state_t state)
> +{
> +       return 0;
> +}
> +#endif
> 

Better remove the #ifdef by doing

void __init imx25_pm_init(void)
{
	if (IS_ENABLED(CONFIG_PM))
		suspend_set_ops(&imx25_suspend_ops);
}

or put the IS_ENABLED() check inside of imx25_suspend_enter().

	Arnd
