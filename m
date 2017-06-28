From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed, 28 Jun 2017 18:46:21 +0200
Subject: [PATCH] clk: scpi: error when clock fails to register
In-Reply-To: <76efd418-9fd5-6ac5-b4c9-c75c5df69df0@arm.com>
References: <20170628135345.9337-1-jbrunet@baylibre.com>
 <c7123c06-b75b-5209-5817-230c63c1bf49@arm.com>
 <1498664332.2337.6.camel@baylibre.com>
 <76efd418-9fd5-6ac5-b4c9-c75c5df69df0@arm.com>
Message-ID: <1498668381.2337.10.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-06-28 at 16:52 +0100, Sudeep Holla wrote:
> 
> On 28/06/17 16:38, Jerome Brunet wrote:
> > On Wed, 2017-06-28 at 16:04 +0100, Sudeep Holla wrote:
> > > 
> > > On 28/06/17 14:53, Jerome Brunet wrote:
> > > > Current implementation of scpi_clk_add just print a warning when clock
> > > > fails to register but then keep going as if nothing happened. The
> > > > provider is then registered with bogus data.
> > > > 
> > > > This may latter lead to an Oops in __clk_create_clk when
> > > > hlist_add_head(&clk->clks_node, &hw->core->clks) is called.
> > > > 
> > > 
> > > What's the path of this call ? I see one in devm_clk_hw_register
> > > but that's one which failed.
> > > 
> > 
> > bL cpu freq driver requesting the cpu clock, which failed to register. Here
> > the
> > Oops call trace:
> > 
> > [????2.202284] [<ffff00000849a058>] __clk_create_clk.part.18+0x68/0xb0
> > [????2.208494] [<ffff00000849ac2c>] __of_clk_get_from_provider+0xfc/0x140
> > [????2.214962] [<ffff000008496c28>] __of_clk_get_by_name+0x100/0x118
> > [????2.220999] [<ffff000008496c94>] clk_get+0x2c/0x78
> > [????2.225744] [<ffff000008570110>] dev_pm_opp_get_opp_table+0xb0/0x118
> > [????2.232039] [<ffff000008570940>] dev_pm_opp_add+0x20/0x68
> > [????2.237388] [<ffff0000087a0f30>] scpi_init_opp_table+0xa8/0x188
> > [????2.243252] [<ffff0000087a0558>]
> > _get_cluster_clk_and_freq_table+0x80/0x180
> > [????2.250151] [<ffff0000087a0a48>] bL_cpufreq_init+0x3f0/0x480
> > [????2.255758] [<ffff00000879eed8>] cpufreq_online+0xc0/0x658
> > [????2.261191] [<ffff00000879f500>] cpufreq_add_dev+0x78/0x88
> > [????2.266625] [<ffff00000855c2c4>] subsys_interface_register+0x84/0xc8
> > [????2.272922] [<ffff00000879e330>] cpufreq_register_driver+0x138/0x1b8
> > [????2.279218] [<ffff0000087a0b4c>] bL_cpufreq_register+0x74/0x120
> > [????2.285083] [<ffff0000087a1038>] scpi_cpufreq_probe+0x28/0x38
> > [????2.290776] [<ffff00000855fbf0>] platform_drv_probe+0x50/0xb8
> > [????2.296468] [<ffff00000855dd84>] driver_probe_device+0x21c/0x2d8
> > 
> 
> Thanks for this stack. I just worked out the same path now. I did come
> up with the patch as below. That should work if my understanding is correct.

I tried.
It does not work unfortunately. Still crashes but somewhere else:
[????2.301482] [<ffff00000849e67c>] scpi_of_clk_src_get+0x14/0x58
[????2.307261] [<ffff000008495f40>] __of_clk_get_by_name+0x100/0x118
[????2.313297] [<ffff000008495fac>] clk_get+0x2c/0x78
[????2.318044] [<ffff00000856f4d0>] dev_pm_opp_get_opp_table+0xb0/0x118
[????2.324338] [<ffff00000856fd00>] dev_pm_opp_add+0x20/0x68
[????2.329687] [<ffff0000087a04f8>] scpi_init_opp_table+0xa8/0x188
[????2.335550] [<ffff00000879fb20>] _get_cluster_clk_and_freq_table+0x80/0x180
[????2.342450] [<ffff0000087a0010>] bL_cpufreq_init+0x3f0/0x480
[????2.348056] [<ffff00000879e4a0>] cpufreq_online+0xc0/0x658
[????2.353490] [<ffff00000879eac8>] cpufreq_add_dev+0x78/0x88
[????2.358924] [<ffff00000855b684>] subsys_interface_register+0x84/0xc8
[????2.365220] [<ffff00000879d8f8>] cpufreq_register_driver+0x138/0x1b8
[????2.371516] [<ffff0000087a0114>] bL_cpufreq_register+0x74/0x120
[????2.377381] [<ffff0000087a0600>] scpi_cpufreq_probe+0x28/0x38
[????2.383076] [<ffff00000855efb0>] platform_drv_probe+0x50/0xb8
[????2.388766] [<ffff00000855d144>] driver_probe_device+0x21c/0x2d8

I have not looked at ALL the clock providers, but I have seen a few and I don't
remember seeing any which fails, at some point, to register a clocks and still
register successfully. 

It seems strange to continue with a broken controller.

> 
> > But that's not the point. The point is there is path in clk-scpi driver
> > which
> > registers uninitialized data in the clock provider. That's not good.?
> > 
> > > Also one of the reason for keeping it continuing is, if firmware fails
> > > on some non-critical clock, that's fine rather than punishing the entire
> > > set of clocks and may even fail the boot.
> > 
> > I understand, but you have no way to know whether a clock is critical or not
> > so?
> > this explanation looks a bit weak, plus it does not keep the boot from
> > failing
> > ... not for me at least.
> > 
> > As explained this approach is registering corrupt data in the provider when
> > failing. It makes the kernel Oops, it shall be fixed.
> > 
> 
> Agreed, I want to look at ways to fix that, hence requested you more data.
> 
> > If you have a better solution later on, I don't think there would be any
> > problem
> > to revert this patch.
> > 
> 
> Sure I am not against the patch as a fix. I was just trying to better
> understand the problem. I had seen the usefulness of skipping on Juno
> platforms
> in earlier days. Also I am now working on the new SCMI[1] specification
> and just want to cover this.
> 
> ---
> 
> diff --git i/drivers/clk/clk-scpi.c w/drivers/clk/clk-scpi.c
> index 96d37175d0ad..d83c0b84798d 100644
> --- i/drivers/clk/clk-scpi.c
> +++ w/drivers/clk/clk-scpi.c
> @@ -245,11 +245,14 @@ static int scpi_clk_add(struct device *dev, struct
> device_node *np,
> ????????????????sclk->id = val;
> 
> ????????????????err = scpi_clk_ops_init(dev, match, sclk, name);
> -???????????????if (err)
> +???????????????if (err) {
> ????????????????????????dev_err(dev, "failed to register clock '%s'\n",
> name);
> -???????????????else
> +???????????????????????clk_data->clk[idx] = NULL;
> +???????????????????????devm_kfree(dev, sclk);
> +???????????????} else {
> ????????????????????????dev_dbg(dev, "Registered clock '%s'\n", name);
> -???????????????clk_data->clk[idx] = sclk;
> +???????????????????????clk_data->clk[idx] = sclk;
> +???????????????}
> ????????}
> 
> ????????return of_clk_add_hw_provider(np, scpi_of_clk_src_get, clk_data);
> 
