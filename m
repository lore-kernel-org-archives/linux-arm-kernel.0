From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Fri, 8 Apr 2016 18:33:07 +0800
Subject: [PATCH] irqchip/mbigen: Display message of MBIGEN domain created
In-Reply-To: <20160408095325.49aaf6b0@arm.com>
References: <1460099762-51497-1-git-send-email-wangkefeng.wang@huawei.com>
 <20160408090935.4ec95aa8@arm.com> <57076B2D.8050006@huawei.com>
 <20160408095325.49aaf6b0@arm.com>
Message-ID: <570788E3.3080901@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/4/8 16:53, Marc Zyngier wrote:
> On Fri, 8 Apr 2016 16:26:21 +0800
> Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

>>> Overall, this doesn't look like a critical patch to me. I think Ma Jun
>>> is working on separate series reworking the way the mgigen is getting
>>> probed, so I'd advise you to work with him in order to integrate this
>>> patch in his series, as it would make a lot more sense.
>>
>> When try to enable hip06 d03 board[1], we met following error log, so I add
>> some debug message. The mbigen driver use module_platform_driver, the driver
>> initialization is too late, and it is without any message,  we don't know
>> about any info of mbigen.  I think we should show something about the mbigen
>> domain creation at least. What's your option?
>>
>> Is there a way to solve this improper print?
>> -----------
>> [    1.345945] irq: no irq domain found for /mbigen_pcie at a0080000/intc_usb !
>> [    1.353660] irq: no irq domain found for /mbigen_pcie at a0080000/intc_usb !
> 
> How can printing anything solve this issue? Furthermore, the error
> message you quote is pretty explicit: no mbigen for you, move along.
> 
> There is a long standing dependency issue for interrupt controllers
> that are also platform devices, and until you resolve (or help
> resolving) that issue, you will get that kind of problem. As I
> mentioned countless times (both on list and in person), you only have
> two options:
> 
> - either you defer probing devices behind the mbigen until the mbigen
>   itself is up and running
> - or you solve the generic dependency problem.
> 
Ok?got it?thanks for your explanation.
> I feel a bit like a stuck record here.

But there is still one issue in the for_each_child_of_node loop of mbigen_device_probe.
Assume that there are 3+ child node(mbigen_gmac, mbigen_i2c, mbigen_xxx, etc) in mbigen_chip_dsa,
if one of them with incorrect configuration, then the loop will end, but we still need
parse the left child node. we should consider this situation, right?

How about split that part into a new mbigen_create_domain(), shown below, and display
the result of mbigen domain creation in it.


diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index d67baa2..9c1d22e 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -236,15 +236,41 @@ static struct irq_domain_ops mbigen_domain_ops = {
 	.free		= irq_domain_free_irqs_common,
 };

-static int mbigen_device_probe(struct platform_device *pdev)
+static void mbigen_create_domain(struct mbigen_device *mgn_dev, struct device_node *np)
 {
-	struct mbigen_device *mgn_chip;
+	struct device *parent = platform_bus_type.dev_root;
+	struct device *dev = &mgn_dev->pdev->dev;
 	struct platform_device *child;
 	struct irq_domain *domain;
+	u32 num_pins;
+
+	if (!of_property_read_bool(np, "interrupt-controller"))
+		goto err;
+
+	if (of_property_read_u32(np, "num-pins", &num_pins))
+		goto err;
+
+	child = of_platform_device_create(np, NULL, parent);
+	if (IS_ERR(child))
+		goto err;
+
+	domain = platform_msi_create_device_domain(&child->dev, num_pins,
+						   mbigen_write_msg,
+						   &mbigen_domain_ops,
+						   mgn_dev);
+	if (!domain)
+		goto err;
+
+	dev_info(dev, "%s domain created\n", np->full_name);
+err:
+	dev_err(dev, "unable to create %s domain\n", np->full_name);
+}
+
+static int mbigen_device_probe(struct platform_device *pdev)
+{
+	struct mbigen_device *mgn_chip;
 	struct device_node *np;
-	struct device *parent;
 	struct resource *res;
-	u32 num_pins;

 	mgn_chip = devm_kzalloc(&pdev->dev, sizeof(*mgn_chip), GFP_KERNEL);
 	if (!mgn_chip)
@@ -257,28 +283,8 @@ static int mbigen_device_probe(struct platform_device *pdev)
 	if (IS_ERR(mgn_chip->base))
 		return PTR_ERR(mgn_chip->base);

-	for_each_child_of_node(pdev->dev.of_node, np) {
-		if (!of_property_read_bool(np, "interrupt-controller"))
-			continue;
-
-		parent = platform_bus_type.dev_root;
-		child = of_platform_device_create(np, NULL, parent);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-
-		if (of_property_read_u32(child->dev.of_node, "num-pins",
-					 &num_pins) < 0) {
-			dev_err(&pdev->dev, "No num-pins property\n");
-			return -EINVAL;
-		}
-
-		domain = platform_msi_create_device_domain(&child->dev, num_pins,
-							   mbigen_write_msg,
-							   &mbigen_domain_ops,
-							   mgn_chip);
-		if (!domain)
-			return -ENOMEM;
-	}
+	for_each_child_of_node(pdev->dev.of_node, np)
+		mbigen_create_domain(mgn_chip, np);

 	platform_set_drvdata(pdev, mgn_chip);


Thanks,
Kefeng

> 
> Thanks,
> 
> 	M.
> 
