From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Aug 2011 12:58:32 +0200
Subject: How to handle named resources with DT?
In-Reply-To: <20110826041200.GD2308@yookeroo.fritz.box>
References: <20110809205723.GE11568@ponder.secretlab.ca>
	<877h6173wm.fsf@ti.com> <20110826041200.GD2308@yookeroo.fritz.box>
Message-ID: <201108261258.32880.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 26 August 2011, David Gibson wrote:
> Seriously, how many times do I have to say it?
> 
> 
> Using _byname in drivers DOES NOT require adding names to the DT.
> 
> 
> All it needs is some glue logic to attach names as the device tree is
> read.  This is properly thought of as part of the code which
> translates the device tree into struct platform_device, not as part of
> drivers proper.

But if you do such code, the only logical place for it to live would
be in that driver, otherwise you end up with multiple places in the
kernel source tree that deal with the same devices and need to be
updated in lock-step. Getting away from this mess is one of the main
reasons for converting to device tree based probing in the first place.

> FURTHERMORE, even if there were names in the DT, you'd still need
> this glue logic, so that drivers converted to _byname could still use
> old device trees.

I don't think anyone was talking about converting driver /to/ the
_byname method, the debate is mostly whether we should move away from
that while we convert drivers to no longer rely on board code but
instead allow them to be probed from the device tree.

> Insisting that the names come from the DT is to mistakenly think of
> the DT as an extension of the kernel's internal interfaces, instead of
> as the external and OS neutral data structure it actually is.

Agreed, that was my main point anyway: Getting the name from the
device tree would be a huge mistake. By comparison, the scenario you
describe -- adding another identifier to struct resource and initializing
from the driver that consumes it -- would not be harmful at all, just a
little silly when you end up with a probe function like

static int __devinit foo_probe(struct platform_device *pdev)
{
	struct foo_private *priv = kzalloc(sizeof (*priv));
	pdev->dev.private_data = priv;
	struct resource *res;

	if (pdev->dev.of_node) {
		platform_get_resource(pdev, IORESOURCE_MEM, FOO_RESOURCE_BAR).id = "bar";
		platform_get_resource(pdev, IORESOURCE_MEM, FOO_RESOURCE_BAZ).id = "baz";
	}

	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "bar");
	priv.bar = resource_iomap(res);
	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "baz");
	priv.baz = resource_iomap(res);

	foo_register(priv);
}

	Arnd
