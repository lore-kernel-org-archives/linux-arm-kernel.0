From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 16 Aug 2011 15:51:31 +0200
Subject: [RFC PATCH v2 06/13] docs/dt: Document nvidia,
	tegra20-pinmux binding
In-Reply-To: <1313440100-17131-7-git-send-email-swarren@nvidia.com>
References: <1313440100-17131-1-git-send-email-swarren@nvidia.com>
	<1313440100-17131-7-git-send-email-swarren@nvidia.com>
Message-ID: <201108161551.31389.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 15 August 2011, Stephen Warren wrote:
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  .../devicetree/bindings/pinmux/pinmux_nvidia.txt   |  294 ++++++++++++++++++++
>  1 files changed, 294 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pinmux/pinmux_nvidia.txt
> 
> diff --git a/Documentation/devicetree/bindings/pinmux/pinmux_nvidia.txt b/Documentation/devicetree/bindings/pinmux/pinmux_nvidia.txt
> new file mode 100644
> index 0000000..744e1b7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinmux/pinmux_nvidia.txt
> @@ -0,0 +1,294 @@
> +NVIDIA Tegra 2 pinmux controller
> +
> +Required properties:
> +- compatible : "nvidia,tegra20-pinmux"

Hmm, I think it would be much better in general if we could define
pinmux bindings in a way that is less specific to just one soc.
The contents of this file seem to be specific to even just one
version of the tegra chip, and might be completely different for
tegra30 and later, right?

Maybe Linus W can comment on this and say whether he thinks it can
be generalized enough to apply to other pinmux drivers.

> +Optional sub-nodes:
> +- nvidia,mux-groups : Mux group settings; see below.
> +- nvidia,drive-groups : Drive group settings; see below.
> +
> +nvidia,mux-groups sub-node:

These concepts seem general enough to me that they can apply to
other chips, and I would consequently drop the nvidia, prefix.

> +Each mux pin group is represented as a sub-node of the nvidia,mux-groups node.
> +The name of the sub-node should be the name of the mux pingroup. The following
> +names are valid:
> +
> +	ata
> +	atb
> +	atc
> +	atd
> +	ate
> +	cdev1
> +	cdev2
> ...

I noticed that each board you define has a complete list of these. Would
it be possible to move a generic list into a tegra20-pinmux.dtsi file and
just override the pins in the per-board .dts file that require some special
setup?


> +
> +optional subnode-properties:
> +- nvidia,pull-up : Boolean, apply Tegra's internal pull-up to the pin.
> +- nvidia,pull-down : Boolean, apply Tegra's internal pull-down to the pin.
> +- nvidia,tristate : Boolean, tristate the pin. Otherwise, drive it.
> +
> +If both nvidia,pull-up and nvidia,pull-down are specified, nvidia,pull-up
> +takes precedence.

These again seem generic enough to go into a general pinmux binding, without
the nvidia, prefix.

	Arnd
