From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 5 Jan 2012 17:05:46 -0800
Subject: [RFC PATCH v3 2/5] pinctrl: add dt binding support for pinmux
 mappings
In-Reply-To: <CAA+hA=RBqpSmntS2h+6xMQuRvSRHenmDgrYSSzMXHtOCpU+HCQ@mail.gmail.com>
References: <1324402840-32451-1-git-send-email-b29396@freescale.com>
 <1324402840-32451-3-git-send-email-b29396@freescale.com>
 <74CDBE0F657A3D45AFBB94109FB122FF176BE92F00@HQMAIL01.nvidia.com>
 <7FE21149F4667147B645348EC6057885075542@039-SN2MPN1-013.039d.mgd.msft.net>
 <74CDBE0F657A3D45AFBB94109FB122FF176CC743EF@HQMAIL01.nvidia.com>
 <CAA+hA=RBqpSmntS2h+6xMQuRvSRHenmDgrYSSzMXHtOCpU+HCQ@mail.gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17761F18F8@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dong Aisheng wrote at Thursday, January 05, 2012 6:48 AM:
> On Sun, Dec 25, 2011 at 11:37 AM, Stephen Warren <swarren@nvidia.com> wrote:
> > Dong Aisheng-B29396 wrote at Thursday, December 22, 2011 1:18 AM:
...
> diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl.txt
...
> +Examples:
> +soc {
> +	aips-bus at 02000000 { /* AIPS1 */
> +		iomuxc at 020e0000 {
> +			pinctrl_uart4: uart4 {
> +				func-name = "uart4";
> +				grp-name = "uart4grp";
> +				grp-pins = <107 108>;
> +				num-pins = <2>;
> +				grp-mux = <4 4>;
> +				num-mux = <2>;
> +			};

Before I get too far into reviewing this path, could you explain the
above node in a little more detail; what it is and what the properties
define?

I'm confused because the node has properties for function name and
group name which make sense to define the mux setting for that group.
However, I'm not sure what the grp-pins/num-pins/grp-mux/num-mux
properties are for; if those properties define the available mux options
and for the group and set of pins included in the group, I think the node
is representing too many things in one place. I'd expect to see:

a) Either data in the pinctrl driver or separate DT nodes to define each
available pin group, mux function, etc.; the definition of what the SoC
itself can do.

b) The configuration of each pin group that's used by the particular board.
All that's relevant here is the mux selection for each pin groups; things
like which pins are included in each group are defined by the SoC not the
board and hence wouldn't be included in a per-board node.

Thanks for enlightening me!

> +
> +			pinctrl_sd4: sd4 {
> +				func-name = "sd4";
> +				grp-name = "sd4grp";
> +				grp-pins = <170 171 180 181 182 183 184 185 186 187>;
> +				num-pins = <10>;
> +				grp-mux = <0 0 1 1 1 1 1 1 1 1>;
> +				num-mux = <10>;
> +			};
> +		};
> +	};
> +
> +	aips-bus at 02100000 { /* AIPS2 */
> +		usdhc at 0219c000 { /* uSDHC4 */
> +			fsl,card-wired;
> +			status = "okay";
> +			pinmux = <&pinctrl_sd4>;
> +		};
> +
> +		uart3: uart at 021f0000 { /* UART4 */
> +			status = "okay";
> +			pinmux = <&pinctrl_uart4>;
> +		};
> +	};
> +};

-- 
nvpublic
