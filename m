From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 16 Jul 2013 10:42:38 +0200
Subject: [PATCH v3 2/2] drivers: dma-contiguous: add initialization from
 device tree
In-Reply-To: <CACxGe6uzau+g0gd=hkNYw1zdkfq18zt_m9OEaiJKR6=q1U4rag@mail.gmail.com>
References: <1372254009-25307-1-git-send-email-m.szyprowski@samsung.com>
 <1372254009-25307-3-git-send-email-m.szyprowski@samsung.com>
 <CACxGe6uzau+g0gd=hkNYw1zdkfq18zt_m9OEaiJKR6=q1U4rag@mail.gmail.com>
Message-ID: <51E5077E.8070900@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Grant,

On 7/11/2013 4:56 PM, Grant Likely wrote:
> Hi Marek,
>
> Thanks for working on this. Comments below...
>
> On Wed, Jun 26, 2013 at 2:40 PM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
> > Add device tree support for contiguous memory regions defined in device
> > tree. Initialization is done in 2 steps. First, the contiguous memory is
> > reserved, what happens very early when only flattened device tree is
> > available. Then on device initialization the corresponding cma regions are
> > assigned to each device structure.
> >
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> >  .../devicetree/bindings/contiguous-memory.txt      |   94 ++++++++++++++
> >  arch/arm/boot/dts/skeleton.dtsi                    |    7 +-
> >  drivers/base/dma-contiguous.c                      |  132 ++++++++++++++++++++
> >  3 files changed, 232 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/devicetree/bindings/contiguous-memory.txt
> >
> > diff --git a/Documentation/devicetree/bindings/contiguous-memory.txt b/Documentation/devicetree/bindings/contiguous-memory.txt
> > new file mode 100644
> > index 0000000..a733df2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/contiguous-memory.txt
> > @@ -0,0 +1,94 @@
> > +*** Contiguous Memory binding ***
> > +
> > +The /chosen/contiguous-memory node provides runtime configuration of
> > +contiguous memory regions for Linux kernel. Such regions can be created
> > +for special usage by various device drivers. A good example are
> > +contiguous memory allocations or memory sharing with other operating
> > +system(s) on the same hardware board. Those special memory regions might
> > +depend on the selected board configuration and devices used on the target
> > +system.
> > +
> > +Parameters for each memory region can be encoded into the device tree
> > +with the following convention:
> > +
> > +contiguous-memory {
> > +
> > +       (name): region@(base-address) {
> > +               reg = <(baseaddr) (size)>;
> > +               (linux,default-contiguous-region);
> > +               device = <&device_0 &device_1 ...>
> > +       };
> > +};
>
> Okay, I've gone and read all of the backlog on the 3 versions of the
> patch series, and I think I understand the issues. I actually think it
> was better off to have the regions specified as children of the memory
> node. I understand the argument about how would firmware know what
> size the kernel wants and that it would be better to have a kernel
> parameter to override the default. However, it is also reasonable for
> the kernel to be provided with a default amount of CMA based on the
> usage profile of the device. In that regard it is absolutely
> appropriate to put the CMA region data into the memory node. I don't
> think /chosen is the right place for that.

Thanks for your comments! I will prepare a new version, which will use
/memory node as it was in the first version. I hope that with Your ack
such version can be finally merged.

> > +
> > +name:          an name given to the defined region;
>
> In the above node example, "name:" is a label used for creating
> phandles. That information doesn't appear in the resulting .dtb
> output. The label is actually optional It should instead be:
>          [(label):] (name)@(address) { }
>
> > +base-address:  the base address of the defined region;
> > +size:          the size of the memory region (bytes);
>
> The reg property should follow the normal reg rules which are well
> defined. That also means that a memory region could have multiple reg
> entries if appropriate.

Well, I'm not sure if it really makes sense to support multiple reg 
entries.
I also wonder how to provide entries for LPAE systems. They are 32-bit 
systems,
but physical addresses can be up to 36bit. How to specify them in device 
tree?

> > +linux,default-contiguous-region: property indicating that the region
> > +               is the default region for all contiguous memory
> > +               allocations, Linux specific (optional);
> > +device:                array of phandles to the client device nodes, which
> > +               will use the defined contiguous region.
>
> This is backwards compared to the way device references usually work.
> It would be more consistent for each device node to have a
> "dma-memory-region" property with phandles to one or more memory
> regions that it cares about.
>
> > +Each defined region must use unique name. It is optional to specify the
> > +base address, so if one wants to use autoconfiguration of the base
> > +address, he must specify the '0' as base address in the 'reg' property
> > +and assign ann uniqe name to such regions, following the convention:
> > +'region at 0', 'region at 1', 'region at 2', ...
>
> Drop the use of 'region'. "name at 0" is more typical. It would be
> appropriate to have compatible = "reserved-memory-region" in each of
> the reserved regions. That would avoid the problem of two regions
> based at the same address having a conflict in name.

Ok.

 > ...

Best regards
-- 
Marek Szyprowski
Samsung R&D Institute Poland
