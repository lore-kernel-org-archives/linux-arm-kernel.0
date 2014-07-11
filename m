From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 11 Jul 2014 16:51:47 +0200
Subject: [PATCH 5/8] of: Add Tegra124 EMC bindings
In-Reply-To: <1405088313-20048-6-git-send-email-mperttunen@nvidia.com>
References: <1405088313-20048-1-git-send-email-mperttunen@nvidia.com>
 <1405088313-20048-6-git-send-email-mperttunen@nvidia.com>
Message-ID: <20140711145146.GA6523@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 11, 2014 at 05:18:30PM +0300, Mikko Perttunen wrote:
> Add binding documentation for the nvidia,tegra124-emc device tree
> node.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  .../bindings/memory-controllers/tegra-emc.txt      | 42 ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/tegra-emc.txt
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/tegra-emc.txt b/Documentation/devicetree/bindings/memory-controllers/tegra-emc.txt
> new file mode 100644
> index 0000000..2dde17e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/tegra-emc.txt
> @@ -0,0 +1,42 @@
> +Tegra124 SoC EMC controller
> +
> +Required properties :
> +- compatible : "nvidia,tegra124-emc".
> +- reg : Should contain 1 or 2 entries:
> +  - EMC register set
> +  - MC register set : Required only if no node with
> +    'compatible = "nvidia,tegra124-mc"' exists. The MC register set
> +    is first read from the MC node. If it doesn't exist, it is read
> +    from this property.

No can do. Memory regions shouldn't be shared between drivers like this.
It makes it impossible to ensure that they don't stump on each others'
toes.

One possibility to make this work is to export global functions from the
memory controller driver that this driver can call into. Perhaps if you
want you can be extra explicit by linking them in DT, like this:

	mc: memory-controller at 0,70019000 {
		compatible = "nvidia,tegra124-mc";
		reg = <0x0 0x70019000 0x0 0x00001000>;
		...
	};

	memory-controller at 0,7001b000 {
		compatible = "nvidia,tegra124-emc";
		reg = <0x0 0x7001b000 0x0 0x00001000>;
		memory-controller = <&mc>;
		...
	};

But I think it's safe enough to assume that there will only be a single
memory controller/EMC pair in the device.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140711/c8076ea6/attachment.sig>
