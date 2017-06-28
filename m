From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 28 Jun 2017 18:07:14 +0100
Subject: [PATCH] clk: scpi: error when clock fails to register
In-Reply-To: <1498668381.2337.10.camel@baylibre.com>
References: <20170628135345.9337-1-jbrunet@baylibre.com>
 <c7123c06-b75b-5209-5817-230c63c1bf49@arm.com>
 <1498664332.2337.6.camel@baylibre.com>
 <76efd418-9fd5-6ac5-b4c9-c75c5df69df0@arm.com>
 <1498668381.2337.10.camel@baylibre.com>
Message-ID: <3e77fd3c-9807-10d4-3a8c-cab8b5562f6c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 28/06/17 17:46, Jerome Brunet wrote:
> On Wed, 2017-06-28 at 16:52 +0100, Sudeep Holla wrote:

[..]

>>
>> Thanks for this stack. I just worked out the same path now. I did come
>> up with the patch as below. That should work if my understanding is correct.
> 
> I tried.

Thanks.

> It does not work unfortunately. Still crashes but somewhere else:
> [    2.301482] [<ffff00000849e67c>] scpi_of_clk_src_get+0x14/0x58
> [    2.307261] [<ffff000008495f40>] __of_clk_get_by_name+0x100/0x118
> [    2.313297] [<ffff000008495fac>] clk_get+0x2c/0x78
> [    2.318044] [<ffff00000856f4d0>] dev_pm_opp_get_opp_table+0xb0/0x118
> [    2.324338] [<ffff00000856fd00>] dev_pm_opp_add+0x20/0x68
> [    2.329687] [<ffff0000087a04f8>] scpi_init_opp_table+0xa8/0x188
> [    2.335550] [<ffff00000879fb20>] _get_cluster_clk_and_freq_table+0x80/0x180
> [    2.342450] [<ffff0000087a0010>] bL_cpufreq_init+0x3f0/0x480
> [    2.348056] [<ffff00000879e4a0>] cpufreq_online+0xc0/0x658
> [    2.353490] [<ffff00000879eac8>] cpufreq_add_dev+0x78/0x88
> [    2.358924] [<ffff00000855b684>] subsys_interface_register+0x84/0xc8
> [    2.365220] [<ffff00000879d8f8>] cpufreq_register_driver+0x138/0x1b8
> [    2.371516] [<ffff0000087a0114>] bL_cpufreq_register+0x74/0x120
> [    2.377381] [<ffff0000087a0600>] scpi_cpufreq_probe+0x28/0x38
> [    2.383076] [<ffff00000855efb0>] platform_drv_probe+0x50/0xb8
> [    2.388766] [<ffff00000855d144>] driver_probe_device+0x21c/0x2d8
> 

Looks like a different route and I know why. I have added an extra check
now which should work if I have not missed anything more.

> I have not looked at ALL the clock providers, but I have seen a few and I don't
> remember seeing any which fails, at some point, to register a clocks and still
> register successfully. 
> 

No problem, as I said I am fine with the patch you sent as a fix for now
but just curious to know what are the issues to be fixed to continue
supporting that feature. Please bear with me.

> It seems strange to continue with a broken controller.
> 

I would have agreed if it was single driver or h/w controlled by Linux.
Since it's in the firmware, we should allow the working clocks/opps to
work though few are broken. It's not good if we had to disable
everything if some piece of firmware is not yet ready or broken.
But again, we can get it working later, for now, I am fine with you patch.

Regards,
Sudeep

---

diff --git i/drivers/clk/clk-scpi.c w/drivers/clk/clk-scpi.c
index 96d37175d0ad..a0b9b4c84be3 100644
--- i/drivers/clk/clk-scpi.c
+++ w/drivers/clk/clk-scpi.c
@@ -192,7 +192,7 @@ scpi_of_clk_src_get(struct of_phandle_args *clkspec,
void *data)

        for (count = 0; count < clk_data->clk_num; count++) {
                sclk = clk_data->clk[count];
-               if (idx == sclk->id)
+               if (sclk && idx == sclk->id)
                        return &sclk->hw;
        }

@@ -245,11 +245,14 @@ static int scpi_clk_add(struct device *dev, struct
device_node *np,
                sclk->id = val;

                err = scpi_clk_ops_init(dev, match, sclk, name);
-               if (err)
+               if (err) {
                        dev_err(dev, "failed to register clock '%s'\n",
name);
-               else
+                       clk_data->clk[idx] = NULL;
+                       devm_kfree(dev, sclk);
+               } else {
                        dev_dbg(dev, "Registered clock '%s'\n", name);
-               clk_data->clk[idx] = sclk;
+                       clk_data->clk[idx] = sclk;
+               }
        }

        return of_clk_add_hw_provider(np, scpi_of_clk_src_get, clk_data);
