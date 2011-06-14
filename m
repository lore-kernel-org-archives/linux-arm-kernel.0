From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Tue, 14 Jun 2011 07:50:45 +0200
Subject: [PATCH] ARM: smp_twd: Reconfigure clockevents after cpufreq change
In-Reply-To: <1306919711-30965-1-git-send-email-linus.walleij@stericsson.com>
References: <1306919711-30965-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <BANLkTikEx0+SpwiWHqLNcs0oaLoN4LccHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Colin, Per Fransson noted this:

> From: Colin Cross <ccross@android.com>

> +/*
> + * Updates clockevent frequency when the cpu frequency changes.
> + * Called on the cpu that is changing frequency with interrupts disabled.
> + */
> +static void twd_update_frequency(void *data)
> +{
> + ? ? ? twd_timer_rate = clk_get_rate(twd_clk);
> +
> + ? ? ? clockevents_update_freq(__get_cpu_var(twd_ce), twd_timer_rate);
> +}

Will only update the clockevent on the CPU where the cpufreq notifier
gets called will it not? It's not called on each CPU AFAICT.

So this function has to traverse all CPUs in twd_ce.

Thanks,
Linus Walleij
