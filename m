From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Mon, 26 Jan 2015 11:09:55 +0100
Subject: [PATCH v2 07/12] pm: at91: the standby mode uses the same sram
 function as the suspend to memory mode
In-Reply-To: <1422265331-23236-1-git-send-email-wenyou.yang@atmel.com>
References: <1422265005-22937-1-git-send-email-wenyou.yang@atmel.com>
 <1422265331-23236-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20150126100955.GA18907@gradator.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Wenyou,


On Mon, Jan 26, 2015 at 05:42:11PM +0800, Wenyou Yang wrote:
> +static int at91_pm_verify_clocks(suspend_state_t state)
>  {
>  	unsigned long scsr;
>  	int i;
>  
> +	/* For PM_SUSPEND_STANDBY, skip verifying the clock */
> +	if (state == PM_SUSPEND_STANDBY)
> +		return 1;
> +

In my opinion we should use the select() already in place in 
at91_pm_enter() to do that:

>  static int at91_pm_enter(suspend_state_t state)
>  {
>  	at91_pinctrl_gpio_suspend();
>  
>  	switch (state) {
     (...)
> +	case PM_SUSPEND_MEM:

	/*
	 * Ensure that clocks are in a valid state.
	 */
	if (!at91_pm_verify_clocks())
		goto error;
	/* FALLTHROUGH */

> +	case PM_SUSPEND_STANDBY:
>  		/*
> -		 * Suspend-to-RAM is like STANDBY plus slow clock mode, so


Sylvain
