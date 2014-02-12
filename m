From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 12 Feb 2014 15:26:31 +0800
Subject: [RFC PATCH 0/4] i.MX6 PU power domain support
In-Reply-To: <1392125231-28387-1-git-send-email-p.zabel@pengutronix.de>
References: <1392125231-28387-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20140212072630.GJ31484@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 11, 2014 at 02:27:07PM +0100, Philipp Zabel wrote:
> The i.MX6Q can gate off the CPU and PU (GPU/VPU) power domains using the
> Power Gating Controller (PGC) in the GPC register space. The CPU power
> domain is already handled by wait state code, but the PU power domain can
> be controlled using the generic power domain framework and power off the PU
> supply regulator if all devices in the power domain are (runtime) suspended.
> 
> This patchset adds a GPC platform device initialized at subsys_initcall time
> (after anatop regulators) that binds to the gpc device tree node and sets up
> the PU power domain:
> 
> 	gpc: gpc at 020dc000 {
> 		#address-cells = <1>;
> 		#size-cells = <1>;
> 		compatible = "fsl,imx6q-gpc";
> 		reg = <0x020dc000 0x4000>;
> 		interrupts = <0 89 0x04 0 90 0x04>;
> 		pu-supply = <&reg_pu>;
> 
> 		pd_pu: power-domain at 020dc260 {
> 			compatible = "fsl,power-domain";
> 			reg = <0x020dc260 0x10>;
> 		};
> 	};
> 
> It registers a platform bus notifier so that it can add GPU and VPU devices
> to the power domain when they are bound. If finds devices to be added to the
> power domain by scanning the device tree for nodes that contain a
> 	power-domain = <&pd_pu>;
> property.

I replied the individual patches with some small comments, but overall I
like it much.  Thanks for the work!

Shawn
