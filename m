From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 12 Sep 2012 18:05:22 +0200
Subject: [PATCH] ARM: smp_twd: reprogram twd based on clk notifier
In-Reply-To: <1347005967-7604-1-git-send-email-shawn.guo@linaro.org>
References: <1347005967-7604-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <CACRpkdamYMhduj42-reu6QjQiso65=Wy_bNF37gENDBrBbQ5=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 7, 2012 at 10:19 AM, Shawn Guo <shawn.guo@linaro.org> wrote:

> -static struct notifier_block twd_cpufreq_nb = {
> -       .notifier_call = twd_cpufreq_transition,
> +static struct notifier_block twd_clk_nb = {
> +       .notifier_call = twd_rate_change,

But what happens if there is a platform which is now using this through
cpufreq and has not yet switched to the common clock? It regresses
right, because no notifications arrive anymore? Does it even compile?

These in linux-next look like they could be in trouble:

cd arch/arm
grep -r smp_twd .
./arch/arm/mach-imx/clk-imx6q.c:	clk_register_clkdev(clk[twd], NULL, "smp_twd");
./arch/arm/mach-tegra/tegra30_clocks_data.c:	CLK_DUPLICATE("twd",
"smp_twd", NULL),

Tegra seems to be a common clk implementation, but imx6 looks like
it's in trouble right?

Yours,
Linus Walleij
