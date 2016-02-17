From: stefan@agner.ch (Stefan Agner)
Date: Wed, 17 Feb 2016 15:29:22 -0800
Subject: no irq domain found for ... a GPIO interrupt controller
Message-ID: <2dc0519827dc9d210e38c498d830cd97@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

I get the following warning on our Vybrid based Colibri VF50 module:
[    0.147674] irq: no irq domain found for
/soc/aips-bus at 40000000/gpio at 4004a000 !

The device tree arch/arm/boot/dts/vf500-colibri.dtsi uses the following
interrupt specification in a touchscreen node which seems to trigger the
issue:
interrupt-parent = <&gpio0>;
interrupts = <8 IRQ_TYPE_LEVEL_LOW>;

We use other GPIO interrupts, but I guess it is a matter of
initialization order, and the above specification seems to be parsed
before the GPIO interrupt-controller gets created...?

It seems that Rob Herring addressed a similar issue a while ago in 
9ec36ca ("of/irq: do irq resolution in platform_get_irq")

Is this problem known?

Currently, the device does not get any interrupts. The interrupt seems
to be requested successfully at probe time later, so I am not sure if
the not working device is really related to the message above....

This is a stack trace when I add a WARN_ON(1) in
irq_create_fwspec_mapping:
[    0.147674] irq: no irq domain found for
/soc/aips-bus at 40000000/gpio at 4004a000 !
[    0.147823] ------------[ cut here ]------------
[    0.147941] WARNING: CPU: 0 PID: 1 at kernel/irq/irqdomain.c:584
irq_create_fwspec_mapping+0xf0/0x1e4()
[    0.148056] Modules linked in:
[    0.148142] CPU: 0 PID: 1 Comm: swapper Not tainted
4.4.0-00070-g3690255-dirty #764
[    0.148246] Hardware name: Freescale Vybrid VF5xx/VF6xx (Device Tree)
[    0.148311] Backtrace:
[    0.148416] [<80013498>] (dump_backtrace) from [<80013690>]
(show_stack+0x18/0x1c)
[    0.148521]  r7:800539f4 r6:00000248 r5:00000009 r4:00000000
[    0.148646] [<80013678>] (show_stack) from [<8029d070>]
(dump_stack+0x24/0x28)
[    0.148782] [<8029d04c>] (dump_stack) from [<800219a4>]
(warn_slowpath_common+0x88/0xb4)
[    0.148916] [<8002191c>] (warn_slowpath_common) from [<80021a74>]
(warn_slowpath_null+0x24/0x2c)
[    0.149021]  r8:00000000 r7:87cf0f88 r6:87cf0f88 r5:00000000
r4:87843ca8
[    0.149158] [<80021a50>] (warn_slowpath_null) from [<800539f4>]
(irq_create_fwspec_mapping+0xf0/0x1e4)
[    0.149294] [<80053904>] (irq_create_fwspec_mapping) from
[<80053b44>] (irq_create_of_mapping+0x5c/0x64)
[    0.149400]  r6:87cf0f88 r5:878bb7c0 r4:00000000
[    0.149508] [<80053ae8>] (irq_create_of_mapping) from [<8045e934>]
(irq_of_parse_and_map+0x2c/0x34)
[    0.149633] [<8045e908>] (irq_of_parse_and_map) from [<8045e95c>]
(of_irq_to_resource+0x20/0xc4)
[    0.149755] [<8045e93c>] (of_irq_to_resource) from [<8045ea44>]
(of_irq_to_resource_table+0x44/0x54)
[    0.149859]  r8:00000001 r7:00000001 r6:87cf0f88 r5:878bb7dc
r4:00000000
[    0.149990] [<8045ea00>] (of_irq_to_resource_table) from [<8045c5b0>]
(of_device_alloc+0x114/0x184)
[    0.150097]  r7:00000000 r6:878be800 r5:87cf0f88 r4:00000000
[    0.150339] [<8045c49c>] (of_device_alloc) from [<8045c678>]
(of_platform_device_create_pdata+0x58/0xd4)
[    0.150457]  r10:00000000 r9:00000000 r8:80650628 r7:00000000
r6:00000000 r5:87cf0f88
[    0.150600]  r4:00000000
[    0.150688] [<8045c620>] (of_platform_device_create_pdata) from
[<8045c800>] (of_platform_bus_create+0xf0/0x194)
[    0.150796]  r7:00000001 r6:00000000 r5:87cf0f88 r4:00000000
[    0.150912] [<8045c710>] (of_platform_bus_create) from [<8045c9e0>]
(of_platform_populate+0x64/0xc0)
[    0.151016]  r10:00000000 r9:00000001 r8:00000000 r7:00000000
r6:80650628 r5:87ce34f4
[    0.151152]  r4:87cf0f88
[    0.151244] [<8045c97c>] (of_platform_populate) from [<80806fa8>]
(vf610_init_machine+0x24/0x2c)
[    0.151352]  r9:807ff5ec r8:000000b0 r7:87896600 r6:80840420
r5:80801a48 r4:80840420
[    0.151515] [<80806f84>] (vf610_init_machine) from [<80801a70>]
(customize_machine+0x28/0x48)
[    0.151640] [<80801a48>] (customize_machine) from [<800095fc>]
(do_one_initcall+0x98/0x1e0)
[    0.151763] [<80009564>] (do_one_initcall) from [<807ffe34>]
(kernel_init_freeable+0x13c/0x1e0)
[    0.151867]  r10:8082b824 r9:807ff5ec r8:000000b0 r7:8086e440
r6:8086e440 r5:00000003
[    0.152004]  r4:80838704
[    0.152091] [<807ffcf8>] (kernel_init_freeable) from [<805ee93c>]
(kernel_init+0x18/0xf0)
[    0.152197]  r10:00000000 r9:00000000 r8:00000000 r7:00000000
r6:00000000 r5:805ee924
[    0.152333]  r4:8086e440
[    0.152424] [<805ee924>] (kernel_init) from [<8000f878>]
(ret_from_fork+0x14/0x3c)
[    0.152526]  r5:805ee924 r4:00000000
[    0.152670] ---[ end trace c2d84d5af0139987 ]---

--
Stefan
