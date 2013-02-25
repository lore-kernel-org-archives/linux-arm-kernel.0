From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Mon, 25 Feb 2013 16:28:41 +0200
Subject: [PATCH 1/4] ARM: tegra: pmc: convert PMC driver to support DT only
In-Reply-To: <51284615.6080808@wwwdotorg.org>
References: <1361515491-16199-1-git-send-email-josephl@nvidia.com>
 <1361515491-16199-2-git-send-email-josephl@nvidia.com>
 <20130222130516.GW23234@tbergstrom-lnx.Nvidia.com>
 <1361585022.1804.11.camel@jlo-ubuntu-64.nvidia.com>
 <51284615.6080808@wwwdotorg.org>
Message-ID: <20130225142841.GJ23234@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 23, 2013 at 05:31:17AM +0100, Stephen Warren wrote:
> On 02/22/2013 07:03 PM, Joseph Lo wrote:
> > On Fri, 2013-02-22 at 21:05 +0800, Peter De Schrijver wrote:
> >> On Fri, Feb 22, 2013 at 07:44:48AM +0100, Joseph Lo wrote:
> >>> The Tegra kernel only support boot from DT now. Clean up the PMC driver
> >>> to support DT only, that includes:
> >>>
> >>> * remove the ifdef of CONFIG_OF
> >>> * replace the static mapping of PMC addr to map from DT
> >>>
> >>> -#ifdef CONFIG_OF
> >>>  static const struct of_device_id matches[] __initconst = {
> >>>  	{ .compatible = "nvidia,tegra20-pmc" },
> >>>  	{ }
> >>
> >> At least an extra entry for tegra114-pmc is necessary here. tegra114.dtsi only
> >> has:
> >>
> >> pmc {
> >> 	compatible = "nvidia,tegra114-pmc", "nvidia,tegra30-pmc";
> >> 	reg = <0x7000e400 0x400>;
> >> };
> >>
> > I think it should be something like below, isn't it?
> > 
> > compatible = "nvidia,tegra114-pmc", "nvidia,tegra30-pmc",
> > 		"nvidia,tegra20-pmc";
> > 
> > or should we add tegra114 and tegra30 in the DT match table?
> 
> The Tegra114 PMC HW is probably not 100% backwards-compatible with
> previous SoCs' PMC, so the DT file should probably only list the
> specific SoC, and the driver should probably include all the compatible
> values it supports.
> 
> Peter, can you confirm exactly which HW versions, if any, are 100%
> backwards-compatible?
> 

The major difference between the PMCs are the powerdomain IDs. The Tegra30 IDs
are a strict superset of the Tegra20 IDs, but the Tegra114 IDs are not. There
are differences in the CPU domains and 3D. The CPU domains aren't a problem I
think because we won't powergate those domains directly using the PMC. We
always program the flowcontroller to do the powergating on WFI. 3D is a
different story however. We do powergate 3D under software control and the
sequencing is different between Tegra30 and Tegra114. Also Tegra30 has 2
domains for 3D while Tegra114 has only 1. Then ofcourse Tegra114 lacks the
SATA and PCIe domains because those features are missing compared to Tegra30.
But the IDs haven't been reused. All in all I think it's best to explicitly
require the driver to support the various SoCs.

Cheers,

Peter.
