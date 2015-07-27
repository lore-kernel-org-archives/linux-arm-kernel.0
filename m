From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 27 Jul 2015 10:16:17 +0100
Subject: [PATCH 2/3] Docs: dt: Add PCI MSI map bindings
In-Reply-To: <FD9C4916-6BDC-40F2-A273-91BFBD3B0075@caviumnetworks.com>
References: <1437670365-20704-1-git-send-email-mark.rutland@arm.com>
 <1437670365-20704-3-git-send-email-mark.rutland@arm.com>
 <FD9C4916-6BDC-40F2-A273-91BFBD3B0075@caviumnetworks.com>
Message-ID: <20150727091535.GA9169@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +Example (5)
> > +===========
> > +
> > +/ {
> > +	#address-cells = <1>;
> > +	#size-cells = <1>;
> > +
> > +	msi_a: msi-controller at a {
> > +		reg = <0xa 0x1>;
> > +		compatible = "vendor,some-controller";
> > +		msi-controller;
> > +		#msi-cells = <1>;
> > +	};
> > +
> > +	msi_b: msi-controller at b {
> > +		reg = <0xb 0x1>;
> > +		compatible = "vendor,some-controller";
> > +		msi-controller;
> > +		#msi-cells = <1>;
> > +	};
> > +
> > +	msi_c: msi-controller at c {
> > +		reg = <0xc 0x1>;
> > +		compatible = "vendor,some-controller";
> > +		msi-controller;
> > +		#msi-cells = <1>;
> > +	};
> > +
> > +	pci: pci at c {
> > +		reg = <0xf 0x1>;
> > +		compatible = "vendor,pcie-root-complex";
> > +		device_type = "pci";
> > +
> > +		/*
> > +		 * The sideband data provided to MSI controller a is the
> > +		 * RID, but the high bit of the bus number is negated.
> > +		 * The sideband data provided to MSI controller b is the
> > +		 * RID, identity-mapped.
> > +		 * MSI controller c is not addressable.
> > +		 */
> > +		msi-map = <0x0000 &msi_a 0x8000 0x08000>,
> > +			  <0x8000 &msi_a 0x0000 0x08000>,
> > +			  <0x0000 &msi_b 0x0000 0x10000>;
> > +	};
> 
> they can be identical right? like
> 	<0x8000 &msi_a 0x0000 0x08000>,
>  	<0x8000 &msi_b 0x0000 0x08000>;

In general that would be valid, yes.

In this case two entries are required for MSI controller a because the
high bit passed to it is negated. This does not occur for MSI controller
b, so it only requires a single entry to describe the transformation.

Thanks,
Mark.
