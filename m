From: tony@atomide.com (Tony Lindgren)
Date: Wed, 12 Sep 2018 10:09:15 -0700
Subject: [PATCH] gpio: omap: Add level wakeup handling for omap4 based SoCs
In-Reply-To: <20180910200624.4494-1-tony@atomide.com>
References: <20180910200624.4494-1-tony@atomide.com>
Message-ID: <20180912170915.GK5662@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [180910 20:10]:
> +static void __maybe_unused
> +omap4_gpio_disable_level_quirk(struct gpio_bank *bank)
> +{
> +	/* Restore level registers after idle */
> +	writel_relaxed(bank->context.leveldetect0,
> +		       bank->base + bank->regs->leveldetect0);
> +	writel_relaxed(bank->context.leveldetect1,
> +		       bank->base + bank->regs->leveldetect1);
> +
> +	/* Clear wake after idle */
> +	writel_relaxed(0, bank->base + bank->regs->wkup_en);

	/* Reset saved wkup_en, it will be set for next idle again */
	bank->context.wake_en = 0;
> +}

Clearing the saved wkup_en is needed above I noticed
testing again with gpio4 which has pdata->loses_context
set.

Otherwise runtime_resume will write to wkup_en enabling
it for runtime which will the next idle fail.

Regards,

Tony
