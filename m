From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 10 Apr 2015 22:57:48 +0200
Subject: [RFC PATCH v2 4/4] arm64: qcom: add cpu operations
In-Reply-To: <1428698605-13166-5-git-send-email-galak@codeaurora.org>
References: <1428698605-13166-1-git-send-email-galak@codeaurora.org>
 <1428698605-13166-5-git-send-email-galak@codeaurora.org>
Message-ID: <5280857.52XJYGkVLd@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 10 April 2015 15:43:25 Kumar Gala wrote:
> +static int qcom_cpu_boot(unsigned int cpu)
> +{
> +       int ret = 0;
> +
> +       if (per_cpu(cold_boot_done, cpu) == false) {
> +               ret = qcom_unclamp_secondary_arm_cpu(cpu);
> +               if (ret)
> +                       return ret;
> +               per_cpu(cold_boot_done, cpu) = true;
> +       }
> +       return secondary_pen_release(cpu);
> +}
> +

Please add a comment here to explain why you need a two-stage process here,
rather than just booting the CPU without the secondary_pen.

Are you working around a specific silicon bug here?

	Arnd
