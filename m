From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 11 Mar 2014 18:01:50 +0000
Subject: [PATCH v5 2/4] devicetree: bindings: Document Krait CPU/L1 EDAC
In-Reply-To: <20140307230856.GE9985@codeaurora.org>
References: <20140116113332.GC25540@e102568-lin.cambridge.arm.com>
 <20140116180505.GA30925@codeaurora.org>
 <20140116183326.GG25540@e102568-lin.cambridge.arm.com>
 <20140116192617.GA13785@codeaurora.org>
 <20140117102109.GA22544@e102568-lin.cambridge.arm.com>
 <20140219002043.GE14769@codeaurora.org>
 <20140225111655.GA6855@e102568-lin.cambridge.arm.com>
 <E34E6789-03BC-452C-9053-82CA1D027861@codeaurora.org>
 <20140226120103.GA25326@e102568-lin.cambridge.arm.com>
 <20140307230856.GE9985@codeaurora.org>
Message-ID: <20140311180150.GD25796@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 07, 2014 at 11:08:56PM +0000, Stephen Boyd wrote:
> On 02/26, Lorenzo Pieralisi wrote:
> > On Tue, Feb 25, 2014 at 08:48:38PM +0000, Kumar Gala wrote:
> > > 
> > > On Feb 25, 2014, at 5:16 AM, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> > > > 
> > > > As I mentioned, I do not like the idea of adding compatible properties
> > > > just to force the kernel to create platform devices out of device tree
> > > > nodes. On top of that I would avoid adding a compatible property
> > > > to the cpus node (after all properties like enable-method are common for all
> > > > cpus but still duplicated), my only concern being backward compatibility
> > > > here (ie if we do that for interrupts, we should do that also for other
> > > > common cpu nodes properties, otherwise we have different rules for
> > > > different properties).
> > > > 
> > > > I think you can then add interrupts to cpu nodes ("qcom,krait" specific),
> > > > and as you mentioned create a platform device for that.
> > > > 
> > > > Thanks,
> > > > Lorenzo
> > > 
> > > So I agree with the statement about adding compatibles just to create platform devices is wrong.  However its seems perfectly reasonable for a cpu node to have a compatible property.  I don't see why a CPU is any different from any other device described in a DT.
> > 
> > I was referring to the /cpus node, not to individual cpu nodes, where
> > the compatible property is already present now.
> > 
> 
> Ok I think I'll go ahead with moving the interrupts into each cpu node, i.e.:
> 
>         cpus {  
>                 #address-cells = <1>;
>                 #size-cells = <0>;
> 
>                 cpu at 0 { 
>                         compatible = "qcom,krait";
>                         device_type = "cpu";
>                         reg = <0>;
>                         interrupts = <1 14 0x304>;
>                         next-level-cache = <&L2>;
>                 };
> 
>                 cpu at 1 { 
>                         compatible = "qcom,krait";
>                         device_type = "cpu";
>                         reg = <1>;
>                         interrupts = <1 14 0x304>;
>                         next-level-cache = <&L2>;
>                 };
> 
>                 L2: l2-cache {
>                         compatible = "cache";
>                         interrupts = <0 2 0x4>;
> 		};
> 	};
> 
> Or should we be expressing the L1 cache as well? Something like:
> 
>         cpus {  
>                 #address-cells = <1>;
>                 #size-cells = <0>;
> 
>                 cpu at 0 { 
>                         compatible = "qcom,krait";
>                         device_type = "cpu";
>                         reg = <0>;
>                         next-level-cache = <&L1_0>;
> 
> 			L1_0: l1-cache {
> 				compatible = "arm,arch-cache";
> 				interrupts = <1 14 0x304>;
> 				next-level-cache = <&L2>;
> 			}
>                 };
> 
>                 cpu at 1 { 
>                         compatible = "qcom,krait";
>                         device_type = "cpu";
>                         reg = <1>;
>                         next-level-cache = <&L1_1>;
> 
> 			L1_1: l1-cache {
> 				compatible = "arm,arch-cache";
> 				interrupts = <1 14 0x304>;
> 				next-level-cache = <&L2>;
> 			}
>                 };
> 
>                 L2: l2-cache {
>                         compatible = "arm,arch-cache";
>                         interrupts = <0 2 0x4>;
> 		};
> 	};
> 
> (I'm also wondering if the 3rd cell of the interrupt binding
> should only indicate the CPU that the interrupt property is
> inside?)

I am not aware of interrupts associated with vanilla :) "arm,arch-cache"
objects, so I think that should be handled as a "qcom,krait" specific property
(in the cpu node), or you should add another cache binding (compatible) for
that.

As you might have noticed (idle states thread) I am keen on defining objects
for L1 caches explicitly, that patch still requires an ACK though (and
you need to update it since you cannot add an interrupt property for all
"arm,arch-cache" objects. I am sorry for being a pain, but I do not
think that's correct from a HW description standpoint).

> Finally we can have the edac driver look for a "qcom,krait"
> compatible node in cpus that it can create a platform device for,
> i.e..
> 
> static int __init krait_edac_driver_init(void)
> {
>         struct device_node *np;
> 
>         np = of_get_cpu_node(0, NULL);
>         if (!np)
>                 return 0;
> 
>         if (!krait_edacp && of_device_is_compatible(np, "qcom,krait"))
>                 krait_edacp = of_platform_device_create(np, "krait_edac", NULL);
>         of_node_put(np);
> 
>         return platform_driver_register(&krait_edac_driver);
> }
> module_init(krait_edac_driver_init);

It seems fine to me, but it requires an ACK from platform bus and DT
maintainers.

Lorenzo
