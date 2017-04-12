From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Wed, 12 Apr 2017 12:03:26 +0800
Subject: [RFC PATCH 0/3] clk: introduce clk_bulk_get accessories
Message-ID: <1491969809-20154-1-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These helper function allows drivers to get several clk consumers in
one operation.  If any of the clk cannot be acquired then any clks
that were got will be put before returning to the caller.

The idea firstly came out when i wanted to clean up and optimize
imx6q-cpufreq driver which needs to handle a lot of clocks as it
becomes a bit mess.

e.g. drivers/cpufreq/imx6q-cpufreq.c

You will see we need get 7 clocks during driver probe.
(Add there will be more, e.g. pll1, pll1_bypass, pll1_bypass_src,
in the future when adding busfreq support).

static int imx6q_cpufreq_probe(struct platform_device *pdev)
{
....
	arm_clk = clk_get(cpu_dev, "arm");
	pll1_sys_clk = clk_get(cpu_dev, "pll1_sys");
	pll1_sw_clk = clk_get(cpu_dev, "pll1_sw");
	step_clk = clk_get(cpu_dev, "step");
	pll2_pfd2_396m_clk = clk_get(cpu_dev, "pll2_pfd2_396m");
	if (IS_ERR(arm_clk) || IS_ERR(pll1_sys_clk) || IS_ERR(pll1_sw_clk) ||
	    IS_ERR(step_clk) || IS_ERR(pll2_pfd2_396m_clk)) {
		dev_err(cpu_dev, "failed to get clocks\n");
		ret = -ENOENT;
		goto put_clk;
	}

	if (of_machine_is_compatible("fsl,imx6ul")) {
		pll2_bus_clk = clk_get(cpu_dev, "pll2_bus");
		secondary_sel_clk = clk_get(cpu_dev, "secondary_sel");
		if (IS_ERR(pll2_bus_clk) || IS_ERR(secondary_sel_clk)) {
			dev_err(cpu_dev, "failed to get clocks specific to imx6ul\n");
			ret = -ENOENT;
			goto put_clk;
		}
	}
....
put_clk: 
        if (!IS_ERR(arm_clk))
                clk_put(arm_clk);
        if (!IS_ERR(pll1_sys_clk))
                clk_put(pll1_sys_clk);
	...........
}

Together with the err path handling for each clocks, it does make
things a bit ugly.

Since we already have regulator_bulk_get accessories, i thought we
probably could introduce clk_bulk_get as well to handle such case to
ease the driver owners' life. 

Besides IMX cpufreq driver, there is also some similar cases
in kernel which could befinit from this api as well.
e.g.
drivers/cpufreq/tegra124-cpufreq.c
drivers/cpufreq/s3c2412-cpufreq.c
sound/soc/samsung/smdk_spdif.c
arch/arm/mach-omap1/serial.c
...

And actually, if we handle clocks more than 3, then it might be
worthy to try, which there is quite many manay in kernel and
that probably could save a lot codes.

This is a RFC patch intending to bring up the idea to discuss.

Comments are welcome and appreciated!

Dong Aisheng (3):
  clk: add clk_bulk_get accessories
  clk: add managed version of clk_bulk_get
  cpufreq: imx6q: refine clk operations

 drivers/clk/clk-devres.c        |  36 +++++++++++
 drivers/clk/clk.c               |  99 +++++++++++++++++++++++++++++
 drivers/clk/clkdev.c            |  42 +++++++++++++
 drivers/cpufreq/imx6q-cpufreq.c | 119 ++++++++++++++++-------------------
 include/linux/clk.h             | 135 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 365 insertions(+), 66 deletions(-)

-- 
2.7.4
