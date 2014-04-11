From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 11 Apr 2014 11:13:45 +0200
Subject: [PATCH RESEND 4/5] Documentation: add the Marvell Berlin pinctrl
 documentation
In-Reply-To: <1397135274-10764-5-git-send-email-antoine.tenart@free-electrons.com>
References: <1397135274-10764-1-git-send-email-antoine.tenart@free-electrons.com>
 <1397135274-10764-5-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <5347B249.6070706@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/10/2014 03:07 PM, Antoine T?nart wrote:

Missing commit message.

> Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
> ---
>   .../bindings/pinctrl/marvell,berlin-pinctrl.txt    | 43 ++++++++++++++++++++++
>   1 file changed, 43 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,berlin-pinctrl.txt
>
> diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,berlin-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,berlin-pinctrl.txt
> new file mode 100644
> index 000000000000..e21538a37734
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/marvell,berlin-pinctrl.txt
> @@ -0,0 +1,43 @@
> +* Pinctrl driver for the Marvell Berlin SoCs
> +
> +The pins controlled by the Marvell Berlin controller are organized in groups.
> +Configuration is done by group, so no actual pin information is needed.
> +
> +Required properties:
> +- compatible:	"marvell-berlin2cd-pinctrl",
> +		"marvell-berlin2-pinctrl",
> +		"marvell-berlin2q-pinctrl"

s/marvell-/marvell,/g

Also, you can add at least some prosa like
"compatible: should be one of"...

> +- reg: registers physical addresses and lengths of the pin controller.
> +- reg-names: name of the register regions.
> +
> +Please refer to pinctrl-bindings.txt in this directory for details of the
> +common pinctrl bindings used by client devices.
> +
> +A pinctrl should contains subnodes representing the pinctrl pin group

s/pinctrl/pin-controller/g
s/contains/contain

> +configurations, one per group. Each subnode has the group name and the muxing
> +function used.
> +
> +Required subnode-properties:
> +- berlin,group: a string describing the group's name.
> +- berlin,function: the function used to mux the group.
> +	0: function 0
> +	1: function 1
> +	...

s/berlin,/marvell,/

And I also prefer either DT binding includes for each function (even if
the proper name is not known).

> +
> +Example:
> +
> +pinctrl: pinctrl at 0 {

I looked at ePAPR recommended node names yesterday. It uses
foo-controller for all listed examples. Also, with the idea
of splitting both pin-controllers into separate nodes the
above (with broken unit-address) will become:

soc_pinctrl: pin-controller at ea0000 {
	compatible = "marvell,berlin2q-soc-pinctrl";
	reg = <0xea0000 0x08>;
};

and

sm_pinctrl: pin-controller at fc0000 {
	compatible = "marvell,berlin2q-sysmgr-pinctrl";
	reg = <0xfc0000 0x44>;
};

Sebastian

> +	compatible = "marvell,berlin2q-pinctrl";
> +	reg = <0xea0000 0x08>, <0xfc0000 0x44>;
> +	reg-names = "global_base", "sm_base";
> +
> +	uart0_pmux: uart0-pmux {
> +		berlin,group = "GSM12";
> +		berlin,function = <0>;
> +	};
> +}
> +
> +&uart0 {
> +	pinctrl-0 = <&uart0_pmux>;
> +	pinctrl-names = "default";
> +};
>
