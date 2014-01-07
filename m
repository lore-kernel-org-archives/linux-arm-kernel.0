From: sre@ring0.de (Sebastian Reichel)
Date: Tue, 7 Jan 2014 12:45:53 +0100
Subject: [RFC PATCH v1 2/5] misc: tda8026: Add NXP TDA8026 PHY driver
In-Reply-To: <52CBA075.8080506@ti.com>
References: <1389010062-17185-1-git-send-email-satish.patel@ti.com>
 <1389010062-17185-3-git-send-email-satish.patel@ti.com>
 <20140106153033.GB24664@e106331-lin.cambridge.arm.com>
 <52CBA075.8080506@ti.com>
Message-ID: <20140107114552.GA900@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 07, 2014 at 12:06:37PM +0530, Satish Patel wrote:
> >> +       if (pdata->irq == 0) {
> >> +               /* look for the field irq-gpio in DT */
> >> +               irq_gpio = of_get_named_gpio(np, "irq-gpio", 0);
> >> +               if (!gpio_is_valid(irq_gpio)) {
> >> +                       dev_err(dev, "Failed to get irq gpio,\n");
> >> +                       return -EIO;
> >> +               }
> > 
> > This is horrible. If the gpio controller can act as an irq controller
> 
> No it's not true. Let me clarify the signal flow,
> 
> Pins => GPIO => GPIO BANK => Interrupt controller => CPU/MPU

This is done automatically if you use the gpio controller as
interrupt source (here with GPIO line 22 as example):

device-tree-node {
    interrupts-extended = <&gpio1 22>;
};

alternatively, but then the irqs from the normal irq controller
can't be used:

device-tree-node {
    interrupt-parent = <&gpio1>;
    interrupts = <22>;
};

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140107/bc4b2c23/attachment.sig>
