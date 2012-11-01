From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 1 Nov 2012 23:20:10 +0100
Subject: [PATCH v2] ARM: plat-versatile: move FPGA irq driver to
 drivers/irqchip
In-Reply-To: <1351805329-19576-1-git-send-email-linus.walleij@linaro.org>
References: <1351805329-19576-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20121101232010.78269291@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus,

On Thu,  1 Nov 2012 22:28:49 +0100, Linus Walleij wrote:

> +void fpga_handle_irq(struct pt_regs *regs);

This function does not need to be exposed in a public header: as
proposed for the bcm2835 and armada-370-xp IRQ controller drivers, the
driver should directly do handle_arch_irq = fpga_handle_irq, and
therefore there is no need for the machine desc structure to reference
fpga_handle_irq anymore.

> +void fpga_irq_init(void __iomem *, const char *, int, int, u32,
> +		struct device_node *node);
> +int fpga_irq_of_init(struct device_node *node,
> +		     struct device_node *parent);

I don't think this function needs to be exported. Just move the
compatible string to drivers/irqchip/irqchip.c and instead of calling
of_irq_init(), call irqchip_init().

This will leave only the fpga_irq_init() function, which we could get
rid of once the non-DT support is removed.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
