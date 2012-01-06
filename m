From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Fri, 6 Jan 2012 11:33:54 +0000
Subject: [RFC PATCH v3 2/5] pinctrl: add dt binding support for pinmux
 mappings
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF17761F18F8@HQMAIL01.nvidia.com>
References: <1324402840-32451-1-git-send-email-b29396@freescale.com>
 <1324402840-32451-3-git-send-email-b29396@freescale.com>
 <74CDBE0F657A3D45AFBB94109FB122FF176BE92F00@HQMAIL01.nvidia.com>
 <7FE21149F4667147B645348EC6057885075542@039-SN2MPN1-013.039d.mgd.msft.net>
 <74CDBE0F657A3D45AFBB94109FB122FF176CC743EF@HQMAIL01.nvidia.com>
 <CAA+hA=RBqpSmntS2h+6xMQuRvSRHenmDgrYSSzMXHtOCpU+HCQ@mail.gmail.com>
 <74CDBE0F657A3D45AFBB94109FB122FF17761F18F8@HQMAIL01.nvidia.com>
Message-ID: <7FE21149F4667147B645348EC605788507F698@039-SN2MPN1-013.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Stephen Warren [mailto:swarren at nvidia.com]
> Sent: Friday, January 06, 2012 9:06 AM
> To: Dong Aisheng
> Cc: Dong Aisheng-B29396; linux-kernel at vger.kernel.org;
> linus.walleij at stericsson.com; s.hauer at pengutronix.de; rob.herring at calxeda.com;
> linux-arm-kernel at lists.infradead.org; kernel at pengutronix.de; cjb at laptop.org;
> devicetree-discuss at lists.ozlabs.org
> Subject: RE: [RFC PATCH v3 2/5] pinctrl: add dt binding support for pinmux
> mappings
> Importance: High
> 
> Dong Aisheng wrote at Thursday, January 05, 2012 6:48 AM:
> > On Sun, Dec 25, 2011 at 11:37 AM, Stephen Warren <swarren@nvidia.com> wrote:
> > > Dong Aisheng-B29396 wrote at Thursday, December 22, 2011 1:18 AM:
> ...
> > diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl.txt
> ...
> > +Examples:
> > +soc {
> > +	aips-bus at 02000000 { /* AIPS1 */
> > +		iomuxc at 020e0000 {
> > +			pinctrl_uart4: uart4 {
> > +				func-name = "uart4";
> > +				grp-name = "uart4grp";
> > +				grp-pins = <107 108>;
> > +				num-pins = <2>;
> > +				grp-mux = <4 4>;
> > +				num-mux = <2>;
> > +			};
> 
> Before I get too far into reviewing this path, could you explain the above node
> in a little more detail; what it is and what the properties define?
> 
grp-pins is the group of pins for this function.
grp-mux is the corresponding mux setting of each pin in that group for this specific
function.
num-pins and num-mux are the number of pins and mux. They're mainly used for sanity
Checking in driver since it's easy to make a mistake when write too many pins for a
function. These two could be removed finally.

> I'm confused because the node has properties for function name and group name
> which make sense to define the mux setting for that group.
> However, I'm not sure what the grp-pins/num-pins/grp-mux/num-mux properties are
> for; if those properties define the available mux options and for the group and
> set of pins included in the group, I think the node is representing too many
> things in one place. I'd expect to see:
> 
> a) Either data in the pinctrl driver or separate DT nodes to define each
> available pin group, mux function, etc.; the definition of what the SoC itself
> can do.
> 
> b) The configuration of each pin group that's used by the particular board.
> All that's relevant here is the mux selection for each pin groups; things like
> which pins are included in each group are defined by the SoC not the board and
> hence wouldn't be included in a per-board node.
> 
We still have not started pin config work.
For pinmux, one way we thought is trying to define pin groups
in soc dts file and reference that pin group by a phandle in board dts file.
It could be:
In the soc dts file arch/arm/boot/dts/imx6q.dtsi:
iomuxc at 020e0000 {
        reg = <0x020e0000 0x4000>;
        pinmux-groups {
                pingrp_uart4: uart4 {
                        grp-pins = <107 108>;
                        grp-mux = <4 4>;
                };

                pingrp_sd4: sd4 {
                        grp-pins = <170 171 180 181 182 183 184 185 186 187>;
                        grp-mux = <0 0 1 1 1 1 1 1 1 1>;
                }
        }
};

In board dts file:
usdhc at 0219c000 { /* uSDHC4 */
        fsl,card-wired;
        status = "okay";
        pinmux = <&pinctrl_sd4>;
};

uart3: uart at 021f0000 { /* UART4 */
        status = "okay";
        pinmux = <&pinctrl_uart4>;
};

iomuxc at 020e0000 {
        pinctrl_uart4: uart4 {
                group = <&pingrp_uart4>;
                pinconfig = ....;
        };

        pinctrl_sd4: sd4 {
                group = <&pingrp_sd4>;
                pinconfig = ....;
        };
};

Then we know the whole map information for a specific device without a pinmux map.
Do you think if it's ok?

BTW, for imx we won't define all possible groups since most are useless and
It's hard to cover all cases due to the issue raised by Sascha before.
We only define what we're most using firstly.

> Thanks for enlightening me!
> 
> > +
> > +			pinctrl_sd4: sd4 {
> > +				func-name = "sd4";
> > +				grp-name = "sd4grp";
> > +				grp-pins = <170 171 180 181 182 183 184 185 186 187>;
> > +				num-pins = <10>;
> > +				grp-mux = <0 0 1 1 1 1 1 1 1 1>;
> > +				num-mux = <10>;
> > +			};
> > +		};
> > +	};
> > +
> > +	aips-bus at 02100000 { /* AIPS2 */
> > +		usdhc at 0219c000 { /* uSDHC4 */
> > +			fsl,card-wired;
> > +			status = "okay";
> > +			pinmux = <&pinctrl_sd4>;
> > +		};
> > +
> > +		uart3: uart at 021f0000 { /* UART4 */
> > +			status = "okay";
> > +			pinmux = <&pinctrl_uart4>;
> > +		};
> > +	};
> > +};
> 
> --
> nvpublic
> 

Regards
Dong Aisheng
