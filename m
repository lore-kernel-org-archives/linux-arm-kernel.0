From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 17 Apr 2017 17:44:47 -0400
Subject: [PATCH v8 10/15] ACPI: platform-msi: retrieve dev id from IORT
In-Reply-To: <1484744105-53140-11-git-send-email-guohanjun@huawei.com>
References: <1484744105-53140-1-git-send-email-guohanjun@huawei.com>
 <1484744105-53140-11-git-send-email-guohanjun@huawei.com>
Message-ID: <838d8504-b6f0-2475-f4b1-9761ecd9f573@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/18/2017 7:55 AM, Hanjun Guo wrote:
> --- a/drivers/irqchip/irq-gic-v3-its-platform-msi.c
> +++ b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
> @@ -57,7 +57,8 @@ static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
>  
>  	msi_info = msi_get_domain_info(domain->parent);
>  
> -	ret = of_pmsi_get_dev_id(domain, dev, &dev_id);
> +	ret = dev->of_node ? of_pmsi_get_dev_id(domain, dev, &dev_id) :
> +		iort_pmsi_get_dev_id(dev, &dev_id);
>  	if (ret)
>  		return ret;
>  

Any idea what happened to the change in this function during merge?

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=ae7c18380495ac5c14a614fdb6c452c3bf9148ac

63a52b3 platform-msi: Make platform_msi_create_device_domain() ACPI aware
e07b978 irqchip/gicv3-its: platform-msi: Scan MADT to create platform msi domain
09be1d5 irqchip/gicv3-its: platform-msi: Refactor its_pmsi_init() to prepare for ACPI
4e96df9 irqchip/gicv3-its: platform-msi: Refactor its_pmsi_prepare()
e593828 irqchip/gic-v3-its: Keep the include header files in alphabetic order
e226a74 ACPI: platform: setup MSI domain for ACPI based platform device
79c7533 ACPI: platform-msi: retrieve devid from IORT
43394c9 ACPI/IORT: Introduce iort_node_map_platform_id() to retrieve dev id
e6eaeae ACPI/IORT: Rename iort_node_map_rid() to make it generic
6acbb92 ACPI/IORT: Rework iort_match_node_callback() return value handling
f8e2f50 ACPI/IORT: Add missing comment for iort_dev_find_its_id()
4b1eeee ACPI/IORT: Fix the indentation in iort_scan_node()

I'm getting these warnings when using the above patches on top of 4.11-rc6?
The code is basically trying to read OF attribute on an ACPI system.

[   11.644792] ------------[ cut here ]------------
[   11.649407] WARNING: CPU: 35 PID: 1 at /local/mnt/workspace/projects/caf/kernel/drivers/irqchip/irq-gic-v3-its-platform-msi.c:41 its_pmsi_prepare+0x9c/0xfc
[   11.663305] Modules linked in:
[   11.666353]
[   11.667839] CPU: 35 PID: 1 Comm: swapper/0 Tainted: G        W       4.11.0-00036-g63a52b3 #1
[   11.676355] Hardware name: (null) (DT)
[   11.680097] task: ffff8007dbab8000 task.stack: ffff8007dbab4000
[   11.686009] PC is at its_pmsi_prepare+0x9c/0xfc
[   11.690533] LR is at its_pmsi_prepare+0x5c/0xfc
[   11.695056] pc : [<ffff000008371b68>] lr : [<ffff000008371b28>] pstate: 20400045
[   11.702443] sp : ffff8007dbab7a40
[   11.705750] x29: ffff8007dbab7a40 x28: 0000000000000000
[   11.711057] x27: ffff0000092a9000 x26: 0000000000000000
[   11.716364] x25: ffff8007df02ba00 x24: ffff000008a745a9
[   11.721670] x23: ffff000008a7459e x22: 000000000000000b
[   11.726976] x21: ffff8007dbab7b70 x20: ffff8007d9c48c10
[   11.732282] x19: ffff8007dba8ba80 x18: 000000000000000a
[   11.737588] x17: 0000000000001000 x16: 0000000000000040
[   11.742895] x15: 000000000009bb9b x14: 0040000000000041
[   11.748201] x13: 0140000000000000 x12: 0088000000000000
[   11.753507] x11: ffff000008af0000 x10: ffff0000094ad000
[   11.758814] x9 : 0000000000000000 x8 : ffff8007d977ac00
[   11.764120] x7 : 0000000000000000 x6 : 000000000000003f
[   11.769426] x5 : ffff8007dbab7a90 x4 : 0000000000000000
[   11.774733] x3 : 0000000000000006 x2 : 00000000fffffffe
[   11.780039] x1 : ffff8007df02b760 x0 : 0000000008d8fb70
[   11.785345]
[   11.786830] ---[ end trace 265ed4f0c6d0486b ]---
[   11.791439] Call trace:
[   11.793879] Exception stack(0xffff8007dbab7870 to 0xffff8007dbab79a0)
[   11.800312] 7860:                                   ffff8007dba8ba80 0001000000000000
[   11.808134] 7880: ffff8007dbab7a40 ffff000008371b68 ffff7e0000000000 0000000000000004
[   11.815956] 78a0: ffff000008af0000 0000820000000000 00000000000ff200 ffff8007dbab8000
[   11.823779] 78c0: 00000000000ff000 ffff0000081cb6ec ffff8007dbab78e0 00000000000ff000
[   11.831601] 78e0: 0000000000000040 ffff8007ffff2a80 ffff8007dbab7940 ffff000008166530
[   11.839423] 7900: ffff8007dbab7960 ffff0000081984f4 0000000008d8fb70 ffff8007df02b760
[   11.847245] 7920: 00000000fffffffe 0000000000000006 0000000000000000 ffff8007dbab7a90
[   11.855067] 7940: 000000000000003f 0000000000000000 ffff8007d977ac00 0000000000000000
[   11.862890] 7960: ffff0000094ad000 ffff000008af0000 0088000000000000 0140000000000000
[   11.870712] 7980: 0040000000000041 000000000009bb9b 0000000000000040 0000000000001000
[   11.878535] [<ffff000008371b68>] its_pmsi_prepare+0x9c/0xfc
[   11.884101] [<ffff000008109444>] msi_domain_prepare_irqs+0x54/0x68
[   11.890274] [<ffff0000081095a8>] msi_domain_alloc_irqs+0x30/0x14c
[   11.896361] [<ffff0000084f00cc>] platform_msi_domain_alloc_irqs+0x54/0x8c
[   11.903142] [<ffff0000084566d8>] hidma_probe+0x5ac/0x824
[   11.908448] [<ffff0000084d16c0>] platform_drv_probe+0x54/0xa4
[   11.914186] [<ffff0000084cfb20>] driver_probe_device+0x140/0x2a0
[   11.920185] [<ffff0000084cfcf4>] __driver_attach+0x74/0xa0
[   11.925664] [<ffff0000084ce0dc>] bus_for_each_dev+0x68/0x98
[   11.931229] [<ffff0000084cf5b8>] driver_attach+0x20/0x28
[   11.936534] [<ffff0000084cf16c>] bus_add_driver+0xe0/0x1ec
[   11.942012] [<ffff0000084d05f4>] driver_register+0x90/0xdc
[   11.947490] [<ffff0000084d161c>] __platform_driver_register+0x48/0x50
[   11.953924] [<ffff000008b9781c>] hidma_driver_init+0x18/0x20
[   11.959577] [<ffff00000808318c>] do_one_initcall+0x80/0x108
[   11.965142] [<ffff000008b60d0c>] kernel_init_freeable+0x19c/0x23c
[   11.971228] [<ffff0000087af808>] kernel_init+0x10/0xfc
[   11.976359] [<ffff000008082ec0>] ret_from_fork+0x10/0x50
[   11.981746] hidma QCOM8062:17: HI-DMA engine driver registration complete


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
