From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 13 Jan 2014 22:27:33 -0800
Subject: [PATCH 4/6] ARM: DTS: tegra: add the DFLL IP block to the T114
 SoC file
In-Reply-To: <52B389CD.8010004@wwwdotorg.org>
References: <20131219122857.3226.42830.stgit@tamien>
 <20131219123719.3226.44864.stgit@tamien> <52B389CD.8010004@wwwdotorg.org>
Message-ID: <alpine.DEB.2.02.1401132219150.11672@tamien>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


(Resending, and revising - the original wasn't fully baked in several 
regards..)

Hello Stephen,

thanks for your review.

On Thu, 19 Dec 2013, Stephen Warren wrote:

> On 12/19/2013 05:49 AM, Paul Walmsley wrote:
>> Add basic DT bindings for the DFLL IP block for the NVIDIA Tegra114 SoC.
>
>> diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra114-dfll.txt b/Documentation/devicetree/bindings/clock/nvidia,tegra114-dfll.txt
>
>> +- clocks : Must contain an array of two-cell arrays, one per clock.
>> +           DFLL source clocks.  At minimum this should include the
>> +           reference clock source and the IP block's main clock
>> +           source.  Also it should contain the DFLL's I2C controller
>> +           clock source.  The format is <&clock-provider-phandle
>> +           clock-id>.
>
> Entries in "clocks" aren't two cells, they're a phandle plus as many
> cells as the node referenced by the phandle specifies.

It's worth noting that the clock binding documentation itself refers to 
pairs:

----

clocks:		List of phandle and clock specifier pairs, one pair
 		for each clock input to the device.  Note: if the
 		clock provider specifies '0' for #clock-cells, then
 		only the phandle portion of the pair will appear.

----

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/clock/clock-bindings.txt#n50

But given the ambiguity of that documentation, I basically agree, so have 
changed it to:

- clocks : Must contain an array of clock specifiers, one per clock.
            DFLL source clocks.  At minimum this should include the
            reference clock source and the IP block's main clock
            source.  Also it should contain the DFLL's I2C controller
            clock source.  The format is <&clock-provider-phandle
            clock-id>.

>> +
>> +- clock-names : Must contain an array of strings, one per 'clocks'
>> +                two-cell array.  The position in the array of these
>
> clock-names defines the set of entries in clocks, not the other way around.

Hmm.  Referring to the DT clock binding documentation, it lists the 
'clock-names' property as optional, and the 'clocks' property as 
mandatory:

-----

==Clock consumers==

Required properties:
clocks:		List of phandle and clock specifier pairs, one pair
 		for each clock input to the device.  Note: if the
 		clock provider specifies '0' for #clock-cells, then
 		only the phandle portion of the pair will appear.

Optional properties:
clock-names:	List of clock input name strings sorted in the same
 		order as the clocks property.  Consumers drivers
 		will use clock-names to match clock input names
 		with clocks specifiers.

-----

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/clock/clock-bindings.txt#n47

Considering that of_clk_get() doesn't require names, the situation appears 
to be the way that the original patch described it (modulo the part about 
"two cells.")

>> +                strings must correspond to the position in the 'clocks'
>> +                array (see above).  The DFLL driver currently requires
>> +                the "soc", "ref", and "i2c" clock names to be populated.
>
> The standard wording used by all the Tegra clock client bindings is now:
>
> - clocks : Must contain an entry for each entry in clock-names.
>  See clock-bindings.txt for details.
> - clock-names : Must include the following entries:
>  - soc
>  - ref
>  - i2c
>
> For consistency, it'd be nice to adopt the same style here.

I've altered the 'clock-names' format along the lines of what you've 
suggested, but have not changed the 'clocks' format, per the above 
discussion:

-----

- clocks : Must contain an array of clock specifiers, one per clock.
            DFLL source clocks.  At minimum this should include the
            reference clock source and the IP block's main clock
            source.  Also it should contain the DFLL's I2C controller
            clock source.  The format is <&clock-provider-phandle
            clock-id>.

- clock-names : Must contain an array of strings, one per 'clocks'
                 cell.  The position in the array of these strings must
                 correspond to the position in the 'clocks' array (see
                 above).
   - soc
   - ref
   - i2c

-----


>> +Optional properties:
>> +
>> +- status : device availability -- managed by the DT integration code, not
>> +           the DFLL driver.  Should be set to "disabled" in the SoC
>> +           DTS file.
>
> That's such a core property that it's not worth documenting in every
> single binding.

That's fine.  Removed.

>
>> +
>
> Blank line at EOF.


Hehe.  Removed.

- Paul
