From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 25 Sep 2012 13:51:55 -0600
Subject: [RFC PATCH 0/3] ARM: use C pre-processor with dtc
In-Reply-To: <1348601746.5565.18@snotra>
References: <1348599998-2729-1-git-send-email-swarren@wwwdotorg.org>
 <1348601746.5565.18@snotra>
Message-ID: <50620B5B.5020904@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/25/2012 01:35 PM, Scott Wood wrote:
> On 09/25/2012 02:06:35 PM, Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> This series adds some build rules to run cpp on *.dts-cpp prior to
>> invoking dtc, and converts Tegra to the new rule as an example. What do
>> people think?
>>
>> I assume that you've applied the dtc patches I sent yesterday. They
>> aren't in this series. See:
>>
>> https://lists.ozlabs.org/pipermail/devicetree-discuss/2012-September/020182.html
>>
>> https://lists.ozlabs.org/pipermail/devicetree-discuss/2012-September/020183.html
>>
>> https://lists.ozlabs.org/pipermail/devicetree-discuss/2012-September/020181.html
>>
>>
>> Note: those patches are against upstream dtc. If you wish to test this
>> series, apply the dtc patches to upstream dtc, build it, and copy the
>> resultant dtc binary over the top of scripts/dtc/dtc.
>>
>> Stephen Warren (3):
>>   kbuild: introduce cmd_dtc_cpp
>>   ARM: use cmd_dtc_cpp for compilation of *.dts-cpp to *.dtb
>>   ARM: tegra: compile all DT files with cpp
> 
> Do you have an example of where you'd actually benefit from this?  I'd
> think most things could either be done reasonably well with what's built
> into DTC (see what we've done in arch/powerpc/boot/dts/fsl), or would
> need math expression support in DTC (or has that been added?).

Yes, support for basic integer math in cell values has indeed been
recently added to upstream dtc. I don't believe this has been ported
into the in-kernel dtc yet though.

The primary motivation here is probably naming constants and associated
readability. For example, instead of:

nvidia,phy-reset-gpio = <&gpio 169 0>; /* gpio PV1 */

You could write:

nvidia,phy-reset-gpio = <&gpio TEGRA_GPIO_PV1 0>;

No more opaque numbers!

Equally, a number of recent bindings have tended towards using strings
rather than integers solely in order to make the DT readable without
having to know 10000 numbers off the top of your head:

pinmux {
...
    state_default: pinmux {
...
        atb {
            nvidia,pins = "atb", "gma", "gme";
            nvidia,function = "sdio4";


could be:

    state_default: pinmux {
...
        atb {
            nvidia,pins = <TEGRA_PIN_ATB, TEGRA_PIN_GMA, TEGRA_PIN_GME>;
            nvidia,function = <TEGRA_FUNCTION_SDIO4>;

This would improve parsing speed (eliminate strcmps), perhaps reduce DT
size (assuming average string length > 4 characters), eliminate the
possibility of typos in strings, and allow .dts and drivers to include
the same header file to define those constants, thus guaranteeing they
be in sync.

Equally, there has been some discussion of using named constants with
the math expression feature e.g.:

interrupts = <0 104 0x03>;

could be:

interrupts = <BANK_FOO INT_GPIO5 (INT_EDGE_RISING | INT_EDGE_FALLING)>;

I believe many many users of this feature would come out of the woodwork
once it's available.
