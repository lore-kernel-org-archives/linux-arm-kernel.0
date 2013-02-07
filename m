From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 07 Feb 2013 12:25:25 +0100
Subject: [PATCH 1/5] ARM: dts: exynos5250-arndale: Add node entry for
 gpio-buttons
In-Reply-To: <5113768B.90102@linaro.org>
References: <1360214129-4096-1-git-send-email-tushar.behera@linaro.org>
 <CAKrE-Ke1WZt-PqVReGdNwcD+R_-4iHKPhgkgtgS-LQAPbx34mQ@mail.gmail.com>
 <5113768B.90102@linaro.org>
Message-ID: <18141670.7lKVRsjORY@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 07 of February 2013 15:10:27 Tushar Behera wrote:
> +CC: David Jander <david@protonic.nl>
> +CC: Dmitry Torokhov <dtor@mail.ru>
> 
> On 02/07/2013 01:13 PM, Girish KS wrote:
> >>>>>> +
> >>>>>> +    gpio_keys {
> >>>>>> +            compatible = "gpio-keys";
> >>>>>> +            #address-cells = <1>;
> >>>>>> +            #size-cells = <0>;
> >>>>> 
> >>>>> Just want to understand why these properties are here?
> >>>>> As these properties are for child dt node. But have not seen
> >>>>> anyone is using here.
> >>>> 
> >>>> That is how gpio_keys node entries are defined in other .dts files.
> >>> 
> >>> I have gone through example for address-cells and size-cells in
> >>> following link:
> >>> http://devicetree.org/mediawiki/index.php?title=Device_Tree_Usage&s
> >>> table=1#CPU_addressing
> >>> 
> >>> which indicates that these fields are for child "reg".
> >>> I think, here in child node there is no "reg". so there is no use
> >>> of address-cells and size-cells propeties.
> >> 
> >> Please check Documentation/devicetree/bindings/gpio/gpio_keys.txt
> >> 
> >> And whether these properties are required or not, I will let device
> >> tree experts to comment on that.
> >> 
> >> As such, currently all node entries for gpio_keys use these
> >> properties.
> > 
> > you can just verify by a simple test.
> > delete the 2 lines. address-cells and size cells.
> > this will have no affect.
> > now with these 2 lines deleted lines add a dummy reg property with
> > address and cell. dtb compiler will warn.
> > So I think what manish reffered is right.
> > There is also a reference of smdk4210 for kepads.
> 
> Right. Compilation is ok even after removing the address-cell and
> size-cell properties.
> 
> But since this is used across all the instances, I would like to know
> the view of the authors on this.
> 
> David, Dimitry,
> 
> Can you please let us know your opinion on this? If these properties are
> not required, then we can remove them from the documentation and from
> node entries in several other dts files.

The #address-cells and #size-cells are used only together with reg 
properties of sub nodes. They define how many cells in reg specifier are 
used for registers address and length.

So, if you have #address-cells = <1> and #size-cells = <0>, then your reg 
specifier will be simply <addr>. You can get more complex specifiers using 
more address cells and size cells, like:

#address-cells = <3>;
#size-cells = <1>;

subdev at 1,2,3 {
	reg = <1 2 3 0x1000>;
	/* ... */
};

If you don't intend to use reg property for child device addressing then 
you don't define #address-cells and #size-cells properties.

I think that the documentation of gpio_keys binding should be corrected 
and possibly also moved to bindings/input instead of bindings/gpio, as 
this directory is intended to be used for GPIO controllers, not GPIO 
consumers.

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
SW Solution Development, Linux Platform
