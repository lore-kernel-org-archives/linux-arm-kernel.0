From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 13 Apr 2012 10:08:39 -0600
Subject: [PATCH V3 2/4] pinctrl: Add SPEAr pinctrl drivers
In-Reply-To: <3d7a76d17b4366e08b45d528a245147095bbcb10.1334207964.git.viresh.kumar@st.com>
References: <cover.1334207964.git.viresh.kumar@st.com>
 <3d7a76d17b4366e08b45d528a245147095bbcb10.1334207964.git.viresh.kumar@st.com>
Message-ID: <4F884F87.8000205@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/2012 11:24 PM, Viresh Kumar wrote:
> This adds pinctrl driver for SPEAr platform. It also updates MAINTAINERS file
> for SPEAr pinctrl drivers.

> +int __devinit spear_pinctrl_probe(struct platform_device *pdev,
> +		struct spear_pinctrl_machdata *machdata)
...
> +	pmx->vbase = of_iomap(np, 0);
...
> +}
> +
> +int __devexit spear_pinctrl_remove(struct platform_device *pdev)
> +{
> +	struct spear_pmx *pmx = platform_get_drvdata(pdev);
> +
> +	pinctrl_unregister(pmx->pctl);
> +
> +	return 0;
> +}

of_iomap isn't a devm function, so youo need to unmap in remove(), and
in probe()'s error paths.

Or of course, you could just implement devm_of_iomap(); it's probably
very simple to do.
