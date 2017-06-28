From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed, 28 Jun 2017 17:38:52 +0200
Subject: [PATCH] clk: scpi: error when clock fails to register
In-Reply-To: <c7123c06-b75b-5209-5817-230c63c1bf49@arm.com>
References: <20170628135345.9337-1-jbrunet@baylibre.com>
 <c7123c06-b75b-5209-5817-230c63c1bf49@arm.com>
Message-ID: <1498664332.2337.6.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-06-28 at 16:04 +0100, Sudeep Holla wrote:
> 
> On 28/06/17 14:53, Jerome Brunet wrote:
> > Current implementation of scpi_clk_add just print a warning when clock
> > fails to register but then keep going as if nothing happened. The
> > provider is then registered with bogus data.
> > 
> > This may latter lead to an Oops in __clk_create_clk when
> > hlist_add_head(&clk->clks_node, &hw->core->clks) is called.
> > 
> What's the path of this call ? I see one in devm_clk_hw_register
> but that's one which failed.
> 

bL cpu freq driver requesting the cpu clock, which failed to register. Here the
Oops call trace:

[????2.202284] [<ffff00000849a058>] __clk_create_clk.part.18+0x68/0xb0
[????2.208494] [<ffff00000849ac2c>] __of_clk_get_from_provider+0xfc/0x140
[????2.214962] [<ffff000008496c28>] __of_clk_get_by_name+0x100/0x118
[????2.220999] [<ffff000008496c94>] clk_get+0x2c/0x78
[????2.225744] [<ffff000008570110>] dev_pm_opp_get_opp_table+0xb0/0x118
[????2.232039] [<ffff000008570940>] dev_pm_opp_add+0x20/0x68
[????2.237388] [<ffff0000087a0f30>] scpi_init_opp_table+0xa8/0x188
[????2.243252] [<ffff0000087a0558>] _get_cluster_clk_and_freq_table+0x80/0x180
[????2.250151] [<ffff0000087a0a48>] bL_cpufreq_init+0x3f0/0x480
[????2.255758] [<ffff00000879eed8>] cpufreq_online+0xc0/0x658
[????2.261191] [<ffff00000879f500>] cpufreq_add_dev+0x78/0x88
[????2.266625] [<ffff00000855c2c4>] subsys_interface_register+0x84/0xc8
[????2.272922] [<ffff00000879e330>] cpufreq_register_driver+0x138/0x1b8
[????2.279218] [<ffff0000087a0b4c>] bL_cpufreq_register+0x74/0x120
[????2.285083] [<ffff0000087a1038>] scpi_cpufreq_probe+0x28/0x38
[????2.290776] [<ffff00000855fbf0>] platform_drv_probe+0x50/0xb8
[????2.296468] [<ffff00000855dd84>] driver_probe_device+0x21c/0x2d8

But that's not the point. The point is there is path in clk-scpi driver which
registers uninitialized data in the clock provider. That's not good.?

> Also one of the reason for keeping it continuing is, if firmware fails
> on some non-critical clock, that's fine rather than punishing the entire
> set of clocks and may even fail the boot.

I understand, but you have no way to know whether a clock is critical or not so 
this explanation looks a bit weak, plus it does not keep the boot from failing
... not for me at least.

As explained this approach is registering corrupt data in the provider when
failing. It makes the kernel Oops, it shall be fixed.

If you have a better solution later on, I don't think there would be any problem
to revert this patch.
