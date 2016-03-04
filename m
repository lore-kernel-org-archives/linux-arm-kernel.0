From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 4 Mar 2016 10:03:35 -0800
Subject: [RFC v3 04/12] ARM: cpuidle: Add runtime PM support for CPUs
In-Reply-To: <1456866931-37851-6-git-send-email-lina.iyer@linaro.org>
References: <1456866931-37851-1-git-send-email-lina.iyer@linaro.org>
 <1456866931-37851-6-git-send-email-lina.iyer@linaro.org>
Message-ID: <20160304180335.GA16665@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/01, Lina Iyer wrote:
> @@ -46,12 +49,20 @@ static int arm_enter_idle_state(struct cpuidle_device *dev,
>  	ret = cpu_pm_enter();
>  	if (!ret) {
>  		/*
> +		 * Call runtime PM suspend on our device
> +		 * Notify RCU to pay attention to critical sections
> +		 * called from within runtime PM.
> +		 */

I was thinking something more along the lines of 

		/*
		 * RCU is idle at this point but runtime PM uses
		 * tracepoints which use RCU so we must resume RCU
		 * while we use runtime PM here.
		 */

> +		RCU_NONIDLE(pm_runtime_put_sync_suspend(cpu_dev));
> +

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
