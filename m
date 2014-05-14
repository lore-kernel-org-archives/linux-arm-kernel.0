From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 14 May 2014 16:58:25 +0200
Subject: [PATCHv2 3/4] ARM: mm: add support for HW coherent systems in
 PL310
In-Reply-To: <20140514143448.GD19866@localhost>
References: <1399975839-5311-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1399975839-5311-4-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140514143448.GD19866@localhost>
Message-ID: <20140514165825.58d3bb20@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Catalin Marinas,

On Wed, 14 May 2014 15:34:48 +0100, Catalin Marinas wrote:
> On Tue, May 13, 2014 at 11:10:38AM +0100, Thomas Petazzoni wrote:
> > --- a/Documentation/devicetree/bindings/arm/l2cc.txt
> > +++ b/Documentation/devicetree/bindings/arm/l2cc.txt
> > @@ -8,6 +8,8 @@ Required properties:
> >  
> >  - compatible : should be one of:
> >    "arm,pl310-cache"
> > +  "arm,pl310-coherent-cache", used for I/O coherent platforms using
> > +     the PL310 cache
> >    "arm,l220-cache"
> >    "arm,l210-cache"
> >    "bcm,bcm11351-a2-pl310-cache": DEPRECATED by "brcm,bcm11351-a2-pl310-cache"
> 
> The binding name kind of implies that we have a transparent PL310 cache
> (at least to me), which is not the case. I would rather have a specific
> dma-coherent property or something similar since it's not another type
> of PL310 but rather a different SoC topology.

Fine with me. A separate property or a different compatible string is
the same.

> But I recall you mentioned that you can't make this decision at the DT
> level since you don't know before whether the SoC is I/O coherent or
> not.

As of today, hardware I/O coherency can only be enabled if CONFIG_SMP
is enabled *and* the SoC is actually multi-core, due to limitations in
the ARM core code. So if you look at my PATCH 4/4 in this series, you
will see that I adjust the compatible string of the cache controller at
run time, depending on whether hardware I/O coherency is enabled or not:

+static void __init mvebu_l2x0_pl310_coherent(void)
+{
+	struct device_node *np;
+
+	if (!coherency_available())
+		return;
+
+	for_each_compatible_node(np, NULL, "arm,pl310-cache") {
+		struct property *new_compat;
+
+		new_compat = kzalloc(sizeof(*new_compat), GFP_KERNEL);
+		new_compat->name = kstrdup("compatible", GFP_KERNEL);
+		new_compat->value = kstrdup("arm,pl310-coherent-cache",
+					    GFP_KERNEL);
+		new_compat->length = strlen(new_compat->value) + 1;
+		of_update_property(np, new_compat);
+	}
+}

So, this code can just as well be changed to add a property instead of
adjusting the compatible property. It's the same thing for me.

Also, I will send (hopefully today) a series that allows to enable
hardware I/O coherency even on !SMP configurations. But I believe it
might take a while to get merged.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
