From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 14 Jan 2014 10:43:58 -0700
Subject: [PATCH 4/6] ARM: DTS: tegra: add the DFLL IP block to the T114
 SoC file
In-Reply-To: <52D4D314.3000208@nvidia.com>
References: <20131219122857.3226.42830.stgit@tamien>
 <20131219123719.3226.44864.stgit@tamien> <52B389CD.8010004@wwwdotorg.org>
 <52D4D314.3000208@nvidia.com>
Message-ID: <52D5775E.9080209@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/13/2014 11:03 PM, Paul Walmsley wrote:
> On 12/19/2013 04:05 PM, Stephen Warren wrote:
>> On 12/19/2013 05:49 AM, Paul Walmsley wrote:
>>> Add basic DT bindings for the DFLL IP block for the NVIDIA Tegra114 SoC.
>>> diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra114-dfll.txt b/Documentation/devicetree/bindings/clock/nvidia,tegra114-dfll.txt

>>> +- clock-names : Must contain an array of strings, one per 'clocks'
>>> +                two-cell array.  The position in the array of these
>> clock-names defines the set of entries in clocks, not the other way around.
> 
> Hmm.  If one refers to the DT clock binding documentation, it lists the
> 'clock-names' property as optional, and the 'clocks' property as mandatory:
> 
> -----
> 
> |==Clock consumers==
> 
> Required properties:
> clocks:		List of phandle and clock specifier pairs, one pair
> 		for each clock input to the device.  Note: if the
> 		clock provider specifies '0' for #clock-cells, then
> 		only the phandle portion of the pair will appear.
> 
> Optional properties:
> clock-names:	List of clock input name strings sorted in the same
> 		order as the clocks property.  Consumers drivers
> 		will use clock-names to match clock input names
> 		with clocks specifiers.
> 
> -----
> |
> 
> 
>  https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/clock/clock-bindings.txt#n47
> 
> Considering that of_clk_get() doesn't require names, it certainly
> appears to be the way that the original patch described it (modulo the
> bit about 'cells'; which has been fixed.)

If the binding defines that clock must exist at certain indices in the
clock property, and clock-names isn't used, then the clocks property
defines which clocks must exist.

However, if the binding is defining clock names, then the clock-names
property is the master that defines which clocks exist. In this case,
the index of entries in the clocks property is undefined by the binding;
it must simply match the clock-names property, which can be arbitrarily
ordered by the user.

Since this is a new binding, we should use the clock-names style to
ensure easy future backwards-compatible changes.
