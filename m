From: jslaby@suse.cz (Jiri Slaby)
Date: Mon, 11 Sep 2017 07:24:54 +0200
Subject: [PATCH] sysrq : fix Show Regs call trace on ARM
In-Reply-To: <20170911031142.254308-1-jibin.xu@windriver.com>
References: <20170911031142.254308-1-jibin.xu@windriver.com>
Message-ID: <8c09c309-e088-1dd6-8d6f-f8929acf0f5f@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/11/2017, 05:11 AM, Jibin Xu wrote:
...
> --- a/drivers/tty/sysrq.c
> +++ b/drivers/tty/sysrq.c
> @@ -245,8 +245,10 @@ static void sysrq_handle_showallcpus(int key)
>  	 * architecture has no support for it:
>  	 */
>  	if (!trigger_all_cpu_backtrace()) {
> -		struct pt_regs *regs = get_irq_regs();
> +		struct pt_regs *regs = NULL;
>  
> +		if (in_irq())
> +			regs = get_irq_regs();

Maybe a stupid question: how does get_irq_regs() behave in the softirq
context? I.e. what about s/in_irq/in_interrupt/?

thanks,
-- 
js
suse labs
