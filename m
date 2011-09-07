From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 7 Sep 2011 21:50:44 +0800
Subject: [PATCH 6/6] arm/imx6q: add suspend/resume support
In-Reply-To: <1315303120-24203-7-git-send-email-shawn.guo@linaro.org>
References: <1315303120-24203-1-git-send-email-shawn.guo@linaro.org>
	<1315303120-24203-7-git-send-email-shawn.guo@linaro.org>
Message-ID: <CAGsJ_4x6cUWey=jCxY-LaazxB=WCRAH0tFsKdpJHgy=iMFkjuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +
> +static int imx6q_pm_enter(suspend_state_t state)
> +{
> + ? ? ? switch (state) {
> + ? ? ? case PM_SUSPEND_MEM:
> + ? ? ? ? ? ? ? imx_local_timer_pre_suspend();
> + ? ? ? ? ? ? ? imx_gpc_pre_suspend();
> + ? ? ? ? ? ? ? outer_flush_all();
> + ? ? ? ? ? ? ? outer_disable();
> + ? ? ? ? ? ? ? imx_set_cpu_jump(0, v7_cpu_resume);
> +
> + ? ? ? ? ? ? ? /* Zzz ... */
> + ? ? ? ? ? ? ? cpu_suspend(0, imx6q_suspend_finish);
> +
> + ? ? ? ? ? ? ? imx_smp_prepare();
> + ? ? ? ? ? ? ? l2x0_of_init(0, ~0UL);

it is pretty clear and good. i think we can refine
arch/arm/mach-prima2/pm.c to the way you are suspending/resuming l2.
on prima2, l2 will totally lose power in suspend cycle. i remember you
once said imx6q will retain l2 in suspend cycle?

> + ? ? ? ? ? ? ? imx_gpc_post_resume();
> + ? ? ? ? ? ? ? imx_local_timer_post_resume();
> + ? ? ? ? ? ? ? break;
> + ? ? ? default:
> + ? ? ? ? ? ? ? return -EINVAL;
> + ? ? ? }
> +
> + ? ? ? return 0;
> +}
thanks
barry
