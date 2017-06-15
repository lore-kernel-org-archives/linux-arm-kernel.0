From: ylhuajnu@163.com (Yao Lihua)
Date: Thu, 15 Jun 2017 22:42:30 +0800
Subject: [RFT 1/2] pinctrl: samsung: Fix NULL pointer exception on
 external interrupts on S3C24xx
In-Reply-To: <20170614131828.28683-1-krzk@kernel.org>
References: <20170614131828.28683-1-krzk@kernel.org>
Message-ID: <44ca46f9-0607-d750-4f26-eab717518fd9@163.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

Another Oops on S3C6410.

[    2.842434] Unable to handle kernel NULL pointer dereference at virtual 
address 00000900
[    2.848477] pgd = c0004000
[    2.851165] [00000900] *pgd=00000000
[    2.854738] Internal error: Oops: 5 [#1] PREEMPT ARM
[    2.859669] Modules linked in:
[    2.862716] CPU: 0 PID: 1 Comm: swapper Not tainted 4.12.0-rc4 #118
[    2.868953] Hardware name: Samsung S3C64xx (Flattened Device Tree)
[    2.875115] task: cf890000 task.stack: cf88e000
[    2.879642] PC is at s3c64xx_eint0_irq_set_type+0x94/0xec
[    2.885013] LR is at s3c64xx_eint0_irq_set_type+0x94/0xec
[    2.890393] pc : [<c02f3c20>]    lr : [<c02f3c20>]    psr: 20000093
[    2.890393] sp : cf88fd18  ip : 00000590  fp : cf213e10
[    2.901837] r10: 00000000  r9 : cf212234  r8 : 00000006
[    2.907044] r7 : cf8d8710  r6 : 00000900  r5 : cf83fbd8  r4 : cf212210
[    2.913551] r3 : 00000001  r2 : cf88e000  r1 : cf88e004  r0 : 00000019
[    2.920060] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
[    2.927263] Control: 00c5387d  Table: 50004008  DAC: 00000051
[    2.932990] Process swapper (pid: 1, stack limit = 0xcf88e188)
[    2.938802] Stack: (0xcf88fd18 to 0xcf890000)
[    2.943146] fd00: cf21228c cf212200
[    2.951309] fd20: c02f3b8c 00000000 c07ba9e4 00000003 60000013 c005bae8 
60000013 cf21225c
[    2.959465] fd40: 00000050 cf212200 cf076900 00000050 cf21225c c005c094 
00000001 00000050
[    2.967622] fd60: 00000050 00000000 00000000 cf20bc3c cf076900 cf212210 
cf212200 c005c39c
[    2.975776] fd80: 00000000 00000083 00000050 c0bb49a8 00000083 c03c35e0 
cf20bc3c cf20bc3c
[    2.983934] fda0: cf98ee10 c005c49c c0bb49a8 cf20bc3c cf1e3ef0 c0bb49a8 
00000050 c03c35e0
[    2.992090] fdc0: 00000083 c005e598 cf20bc3c c0530fe8 cf20bc10 cf213e2c 
00000000 c0bb49a8
[    3.000245] fde0: cf20bc10 cf98ee10 00000083 c03c2e80 c0bb49a8 cf20bc3c 
00000000 c017f644
[    3.008401] fe00: 00000000 00000000 cf20a400 cf20bc3c cfdb68a0 00000000 
c03c35e0 cf98ee00
[    3.016558] fe20: cf2150f0 cf20bc6c 00000001 cf98ee10 c03c2be8 c07c61c8 
c07c61b4 c07c61c8
[    3.024712] fe40: 00000000 00000001 c08120d0 c034d508 c034d4b4 cf98ee10 
c08120d0 00000000
[    3.032869] fe60: c08120d8 c034b8c4 c058517c 00000000 cf98efa0 00000001 
c058517c cf98ee10
[    3.041025] fe80: c07c61c8 cf98ee44 00000000 00000000 c0760ff8 00000000 
c071d4fc c034ba18
[    3.049181] fea0: c07c61c8 c034b974 00000000 c0349f44 cf808a70 cf9b4e20 
c07c61c8 cf1de4e0
[    3.057337] fec0: c07c1848 c034ae98 c06aa8a8 c07c61c8 00000007 c07c61c8 
00000007 c0749370
[    3.065494] fee0: c07e0000 c034c570 c034cecc c0767048 00000007 c0009824 
0000004e c05338c4
[    3.073648] ff00: cf8d8000 00000000 00000000 00000000 0000009e 00000000 
cfffcdbd 00000000
[    3.081805] ff20: 0000009e 0000009e cfffcdc4 c003b714 c06ef210 00000000 
00000007 00000007
[    3.089961] ff40: cfffcdc0 cfffcdbd 00000000 dae6109a c0756860 00000007 
c0756840 c07e0000
[    3.098117] ff60: 0000009e 00000000 c071d4fc c071dda0 00000007 00000007 
00000000 c071d4fc
[    3.106272] ff80: 00000000 00000000 c052ae90 00000000 00000000 00000000 
00000000 00000000
[    3.114430] ffa0: 00000000 c052ae98 00000000 c000f7b8 00000000 00000000 
00000000 00000000
[    3.122584] ffc0: 00000000 00000000 00000000 00000000 00000000 00000000 
00000000 00000000
[    3.130742] ffe0: 00000000 00000000 00000000 00000000 00000013 00000000 
ffffffff ffffffff
[    3.138927] [<c02f3c20>] (s3c64xx_eint0_irq_set_type) from [<c005bae8>] 
(__irq_set_trigger+0x60/0x154)
[    3.148195] [<c005bae8>] (__irq_set_trigger) from [<c005c094>] 
(__setup_irq+0x4b8/0x5ac)
[    3.156259] [<c005c094>] (__setup_irq) from [<c005c39c>] 
(request_threaded_irq+0x120/0x19c)
[    3.164589] [<c005c39c>] (request_threaded_irq) from [<c005c49c>] 
(request_any_context_irq+0x84/0x88)
[    3.173789] [<c005c49c>] (request_any_context_irq) from [<c005e598>] 
(devm_request_any_context_irq+0x60/0xa8)
[    3.183694] [<c005e598>] (devm_request_any_context_irq) from [<c03c2e80>] 
(gpio_keys_probe+0x298/0x85c)
[    3.193065] [<c03c2e80>] (gpio_keys_probe) from [<c034d508>] 
(platform_drv_probe+0x54/0xa4)
[    3.201383] [<c034d508>] (platform_drv_probe) from [<c034b8c4>] 
(driver_probe_device+0x248/0x2f8)
[    3.210229] [<c034b8c4>] (driver_probe_device) from [<c034ba18>] 
(__driver_attach+0xa4/0xa8)
[    3.218645] [<c034ba18>] (__driver_attach) from [<c0349f44>] 
(bus_for_each_dev+0x64/0x88)
[    3.226800] [<c0349f44>] (bus_for_each_dev) from [<c034ae98>] 
(bus_add_driver+0x16c/0x1fc)
[    3.235047] [<c034ae98>] (bus_add_driver) from [<c034c570>] 
(driver_register+0x78/0xf4)
[    3.243028] [<c034c570>] (driver_register) from [<c0009824>] 
(do_one_initcall+0x50/0x194)
[    3.251192] [<c0009824>] (do_one_initcall) from [<c071dda0>] 
(kernel_init_freeable+0x174/0x244)
[    3.259862] [<c071dda0>] (kernel_init_freeable) from [<c052ae98>] 
(kernel_init+0x8/0xf0)
[    3.267935] [<c052ae98>] (kernel_init) from [<c000f7b8>] 
(ret_from_fork+0x14/0x3c)

> diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
> index f542642eed8d..a25c3ffae25c 100644
> --- a/drivers/pinctrl/samsung/pinctrl-samsung.c
> +++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
> @@ -1013,6 +1013,11 @@ samsung_pinctrl_get_soc_data(struct samsung_pinctrl_drv_data *d,
>   		bank->eint_base = virt_base[0];
>   		bank->pctl_base = virt_base[bdata->pctl_res_idx];
>   	}
> +	/*
> +	 * For legacy platforms which need to access IO memory through
> +	 * samsung_pinctrl_drv_data:
> +	 */
> +	d->virt_base = virt_base[bdata->pctl_res_idx];
>   
>
     for (i = 0; i < ctrl->nr_banks; ++i, ++bdata, ++bank) {
         ......
     }
     /*
      * For legacy platforms which need to access IO memory through
      * samsung_pinctrl_drv_data:
      */
     d->virt_base = virt_base[bdata->pctl_res_idx];
                                                     ^
                                                      **bdata** is invalid here.


Thanks!
Lihua
