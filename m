From: TWarren@nvidia.com (Tom Warren)
Date: Mon, 26 Oct 2015 18:04:34 +0000
Subject: [PATCH v2] spi: Tegra: add device tree binding doc for SPI/QSPI
In-Reply-To: <562E55BD.7070000@wwwdotorg.org>
References: <1445643042-5764-1-git-send-email-twarren@nvidia.com>
 <562E55BD.7070000@wwwdotorg.org>
Message-ID: <77b185ab23764f1e8cde0a41189bb490@HQMAIL104.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen,

> -----Original Message-----
> From: Stephen Warren [mailto:swarren at wwwdotorg.org]
> Sent: Monday, October 26, 2015 9:33 AM
> To: Tom Warren <TWarren@nvidia.com>; u-boot at lists.denx.de
> Cc: Stephen Warren <swarren@nvidia.com>; tomcwarren3959 at gmail.com;
> jteki at openedev.com; robh+dt at kernel.org; pawel.moll at arm.com;
> mark.rutland at arm.com; ijc+devicetree at hellion.org.uk;
> galak at codeaurora.org; Thierry Reding <treding@nvidia.com>; linux-
> tegra at vger.kernel.org; Alex Courbot <acourbot@nvidia.com>; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH v2] spi: Tegra: add device tree binding doc for SPI/QSPI
> 
> On 10/23/2015 05:30 PM, Tom Warren wrote:
> > This patch adds the device tree binding doc for the Tegra SPI/QSPI
> > controllers on Tegra114 and Tegra210.
> 
> > diff --git a/doc/device-tree-bindings/spi/spi-tegra.txt
> > b/doc/device-tree-bindings/spi/spi-tegra.txt
> 
> Since this is a patch to the Linux kernel, it should use the path and file names
> from the Linux kernel, so that should be:
> 
> Documentation/devicetree/bindings/spi/nvidia,tegra210-qspi.txt
I thought I was adding a binding doc to U-Boot, so the QSPI driver for T210 can go in. I wasn't aware that I had to submit a changelist against the kernel's binding first. I'll redo the file path.

> 
> (or perhaps an earlier SoC number if this HW block first appeared before
> Tegra210)
AFAICT, QSPI first appeared in Tegra210/X1.

> 
> > +NVIDIA Tegra SPI/QSPI controller.
> 
> There's already a binding document for the regular SPI controller. The plain SPI
> entries should be removed from this file, leaving it covering the QSPI controller
> only.
There is no spi binding for Tegra114 in U-Boot at present, hence my duplication. I'll remove the SPI entries from this file, and perhaps copy over the kernel's tegra114 spi binding for U-Boot at a later date.

> 
> Can you confirm that there physically is a separate QSPI controller in HW and
> that it has different registers to the regular SPI controller?
> Or, is QSPI simply a new mode of operation for the existing HW?
QSPI is its own controller, separate from the traditional 4 Tegra SPI controllers. It has its own address space, and some differences in bits in some registers, and adds misc and timing registers that don't exist in the SPI controller. It supports Master mode only (no slave mode), and adds Dual (x2)  and Quad mode (x4) transfer options. It's basically a superset of the Tegra SPI controller.

> 
> > +Required properties:
> > +- compatible : should be one of the following:
> > +  "nvidia,tegra114-spi" (for Tegra114)
> > +  "nvidia,tegra210-qspi" (for Tegra210)
> > +- reg: Should contain SPI registers location and length.
> > +- interrupts: Should contain SPI interrupts.
> 
> Are there multiple interrupts or just one? I imagine just one, in which case just
> "interrupt" at the end of that description.
Only 1 interrupt for QSPI. Note that this was copied verbatim from the kernel's current nvidia,tegra114-spi.txt binding, so if it's wrong, it's wrong there, too.

Tom
--
nvpublic
