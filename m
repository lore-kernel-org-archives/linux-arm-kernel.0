From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Jan 2011 14:47:53 +0000
Subject: [PATCH v2] arm: Configure reference clock for Versatile
	Express timers
In-Reply-To: <1295373883-21513-1-git-send-email-pawel.moll@arm.com>
References: <1295373883-21513-1-git-send-email-pawel.moll@arm.com>
Message-ID: <20110124144753.GB22949@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 18, 2011 at 06:04:43PM +0000, Pawel Moll wrote:
>  static void __init v2m_timer_init(void)
>  {
> +	u32 scctrl;
> +
>  	versatile_sched_clock_init(MMIO_P2V(V2M_SYS_24MHZ), 24000000);
>  
> -	writel(0, MMIO_P2V(V2M_TIMER0) + TIMER_CTRL);
> -	writel(0, MMIO_P2V(V2M_TIMER1) + TIMER_CTRL);
> +	/* Select 1MHz TIMCLK as the reference clock for SP804 timers */
> +	scctrl = readl(MMIO_P2V(V2M_SYSCTL + SCCTRL));
> +	scctrl |= SCCTRL_TIMEREN0SEL_TIMCLK;
> +	scctrl |= SCCTRL_TIMEREN1SEL_TIMCLK;
> +	writel(scctrl, MMIO_P2V(V2M_SYSCTL + SCCTRL));

BTW, why are you removing the initialization of TIMER_CTRL ?  You don't
describe why you do this in the commit log so I suspect it's a mistake.
