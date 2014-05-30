From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 30 May 2014 21:06:16 +0200
Subject: [PATCH v2] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <CAL_JsqKumG1PSFoVfeGpLLG+MjXFeF4aUjun=vv1BJpaxk0Byg@mail.gmail.com>
References: <1400877218-4113-1-git-send-email-thierry.reding@gmail.com>
 <CAL_JsqKumG1PSFoVfeGpLLG+MjXFeF4aUjun=vv1BJpaxk0Byg@mail.gmail.com>
Message-ID: <4545972.cM7IP1qTXQ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 30 May 2014 08:16:05 Rob Herring wrote:
> On Fri, May 23, 2014 at 3:33 PM, Thierry Reding
> <thierry.reding@gmail.com> wrote:
> > From: Thierry Reding <treding@nvidia.com>
> > +IOMMU master node:
> > +==================
> > +
> > +Devices that access memory through an IOMMU are called masters. A device can
> > +have multiple master interfaces (to one or more IOMMU devices).
> > +
> > +Required properties:
> > +--------------------
> > +- iommus: A list of phandle and IOMMU specifier pairs that describe the IOMMU
> > +  master interfaces of the device. One entry in the list describes one master
> > +  interface of the device.
> > +
> > +When an "iommus" property is specified in a device tree node, the IOMMU will
> > +be used for address translation. If a "dma-ranges" property exists in the
> > +device's parent node it will be ignored. An exception to this rule is if the
> > +referenced IOMMU is disabled, in which case the "dma-ranges" property of the
> > +parent shall take effect.
> 
> Just thinking out loud, could you have dma-ranges in the iommu node
> for the case when the iommu is enabled rather than putting the DMA
> window information into the iommus property?
> 
> This would probably mean that you need both #iommu-cells and #address-cells.

The reason for doing like this was that you may need a different window
for each device, while there can only be one dma-ranges property in 
an iommu node.

> > +
> > +Optional properties:
> > +--------------------
> > +- iommu-names: A list of names identifying each entry in the "iommus"
> > +  property.
> 
> Do we really need a name here? I would not expect that you have
> clearly documented names here from the datasheet like you would for
> interrupts or clocks, so you'd just be making up names. Sorry, but I'm
> not a fan of names properties in general.

Good point, this was really overdesign by modeling it after other
subsystems that can have a use for names.
 
> > +Multiple-master IOMMU:
> > +----------------------
> > +
> > +       iommu {
> > +               /* the specifier represents the ID of the master */
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> > +       };
> > +
> > +       master {
> > +               /* device has master ID 42 in the IOMMU */
> > +               iommus = <&/iommu 42>;
> > +       };
> 
> Presumably the ID would be the streamID on ARM's SMMU. How would a
> master with 8 streamIDs be described? This is what Calxeda midway has
> for SATA and I would expect that to be somewhat common. Either you
> need some ID masking or you'll have lots of duplication when you have
> windows.

I don't understand the problem. If you have stream IDs 0 through 7,
you would have

	master at a {
		...
		iommus = <&smmu 0>;
	};

	master at b {
		...
		iommus = <&smmu 1;
	};

	...

	master at 12 {
		...
		iommus = <&smmu 7;
	};

and you don't need a window@all. Why would you need a mask of
some sort?

	Arnd
