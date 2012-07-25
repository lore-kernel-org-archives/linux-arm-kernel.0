From: sentientnz@yahoo.co.nz (Tony Prisk)
Date: Wed, 25 Jul 2012 11:18:13 -0700 (PDT)
Subject: DT problem - interrupts?
In-Reply-To: <1343229569.81486.YahooMailNeo@web140804.mail.bf1.yahoo.com>
References: <1343229569.81486.YahooMailNeo@web140804.mail.bf1.yahoo.com>
Message-ID: <1343240293.67026.YahooMailNeo@web140804.mail.bf1.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Tony Prisk <sentientnz@yahoo.co.nz>
> To: "devicetree-discuss at lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>
> Cc: Linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
> Sent: Thursday, 26 July 2012 3:19 AM
> Subject: DT problem - interrupts?
> 
> Hopefully someone can think of something simple that I'm missing here 
> because 
> 
> it's got me a little baffled.
> 
> Trying to port the arch-vt8500 over to device tree, but I've run into a 
> hiccup with the
> first device that requires interrupts (EHCI + UHCI drivers).
> 
> Both these drivers work perfectly when passed as old-style platform_devices that 
> are
> setup in the board init. When they are initialised from a devicetree file, they 
> both
> initialize fine, but fail with error -32 trying to detect devices.
> 
> I'm sure the problem is with the irq initialization code, and to keep it 
> simple i used
> 
> the old working irq code, and simply added an irqdomain with 
> irq_domain_add_legacy.
> 
> Any ideas?
> 
> (Let me know if there is any more info that might clarify things).
> 
> 
> Regards
> 
> Tony Prisk
> 
> ----------
> wm8650.dts <relevant parts>
> 
> intc0: interrupt-controller at d8140000 {
> compatible="wm,intc";
> interrupt-controller;
> reg = <0xd8140000 0x10000>;
> #interrupt-cells = <1>;
> }
> 
> ehci at d8007900 {
> compatible="wm,prizm-ehci";
> reg = <0xd8007900 0x200>;
> interrupt-parent = <&intc0>;
> interrupts = <43>;
> }
> 
> 
> irq.c
> 
> /* interrupt controller has 64 irqs starting at 0 */
> 
> irq_domain_add_legacy(node, 64, 0, 0, &irq_simple_domain_ops, priv);
> 
> ----------
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> ----- Original Message -----

Found the problem (thanks atmel-ehci.c)

DT-created devices doesn't specify a dma_mask. Added it manually and it works fine.

Regards

Tony P
