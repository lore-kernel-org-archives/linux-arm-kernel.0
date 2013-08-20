From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 20 Aug 2013 23:44:04 +0200
Subject: [PATCH] ARM: tegra: split tegra_pmc_init() in two
In-Reply-To: <1377034065-26373-1-git-send-email-swarren@wwwdotorg.org>
References: <1377034065-26373-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <5213E324.2020000@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/20/2013 11:27 PM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>
> Tegra's board file currently initializes clocks much earlier than those
> for most other ARM SoCs. The reason is:
>
> * The PMC HW block is involved in the path of some interrupts (i.e. it
> inverts, or not, the IRQ input pin dedicated to the PMIC).
>
> * So, that part of the PMC must be initialized early so that the IRQ
> polarity is correct.
>
> * The PMC initialization is currently monolithic, and the PMC has some
> clock inputs, so the init routine ends up calling of_clk_get_by_name(),
> and hence clocks must be set up early too.
>
> In order to defer clock initialization to the more typical location,
> split out the portions of tegra_pmc_init() that are truly IRQ-related
> into a separate tegra_pmc_init_irq(), which can be called from the
> machine descriptor's .init_irq() function, and defer the rest until
> the machine descriptor's .init_machine() function. This allows the
> clock initiliazation to happen from the machine descriptor's
> .init_time() function, as is typical.
>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> Sebastian, this should help with your of_clock_init() series. Feel free
> to include this patch in your series unless someone raises objections to
> it. It's based on next-20130819, but I think it should apply many other
> places without any issue, and certainly on top of wherever Tegra's
> for-3.12/soc branch got applies within the arm-soc git repo. If you want
> me to take it for 3.13, just let me know.

Stephen,

thanks for looking into it so fast. I prefer to include it and send it
with the other patches. Besides tegra, also imx, mvebu, and vexpress
required to move things around a bit, so I wait for the someone to
comment on their mach changes first.

For the final patch set, I guess your Signed-off on this is sufficient
to convince Olof or Russell to take it.

Sebastian
