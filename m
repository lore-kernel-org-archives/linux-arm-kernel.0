From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 19 Nov 2012 19:38:03 +0100
Subject: [PATCH 4/7] arm: mvebu: move DT cpu clock nodes to the Armada XP
 specific .dtsi
In-Reply-To: <1353343963-23034-5-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353343963-23034-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1353343963-23034-5-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20121119183803.GT14643@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 05:52:40PM +0100, Thomas Petazzoni wrote:
> The cpu clock nodes have originally been added in
> armada-xp.dtsi. However, this .dtsi file is common to all SoCs in the
> Armada XP family: the MV78230, the MV78260 and the MV78460. Those SoCs
> differ in a number of ways, but one of the main difference is the
> number of CPUs: one CPU in the MV78230, two CPUs in the MV78260 and
> four CPUs in the MV78460.
> 
> Therefore, this patch moves the cpu clock DT nodes into the
> armada-xp-mv78230.dtsi, armada-xp-mv78260.dtsi and
> armada-xp-mv78460.dtsi files, instantiating the right number of CPUs
> and CPU clocks as needed.

Hi Thomas

This is only part of the story:

void __init of_cpu_clk_setup(struct device_node *node)
{
        struct cpu_clk *cpuclk;
        void __iomem *clock_complex_base = of_iomap(node, 0);
        int cpu;
        if (clock_complex_base == NULL) {
                pr_err("%s: clock-complex base register not set\n",
                        __func__);
                return;
        }

        cpuclk = kzalloc(MAX_CPU * sizeof(*cpuclk), GFP_KERNEL);
        clks = kzalloc(MAX_CPU * sizeof(*clks), GFP_KERNEL);

        if (WARN_ON(!cpuclk))
                return;
        for (cpu = 0; cpu < MAX_CPU; cpu++) {
                struct clk_init_data init;
                struct clk *clk;
                struct clk *parent_clk;
                char *clk_name = kzalloc(5, GFP_KERNEL);

                sprintf(clk_name, "cpu%d", cpu);
                parent_clk = of_clk_get(node, 0);

...

                clk = clk_register(NULL, &cpuclk[cpu].hw);
                if (WARN_ON(IS_ERR(clk)))
                        goto bail_out;
                clks[cpu] = clk;
        }

You are still registering 4 clocks as far as i can see.

    Andrew
