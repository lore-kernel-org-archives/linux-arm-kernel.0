From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 8 Jan 2015 11:51:34 +0100
Subject: [PATCH v2 05/21] DT: tegra: add binding for the legacy interrupt
 controller
In-Reply-To: <1420652576-22309-6-git-send-email-marc.zyngier@arm.com>
References: <1420652576-22309-1-git-send-email-marc.zyngier@arm.com>
 <1420652576-22309-6-git-send-email-marc.zyngier@arm.com>
Message-ID: <20150108105133.GG1987@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 07, 2015 at 05:42:40PM +0000, Marc Zyngier wrote:
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  .../interrupt-controller/nvidia,tegra-ictlr.txt    | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/nvidia,tegra-ictlr.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/nvidia,tegra-ictlr.txt b/Documentation/devicetree/bindings/interrupt-controller/nvidia,tegra-ictlr.txt
> new file mode 100644
> index 0000000..44fd873
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/nvidia,tegra-ictlr.txt
> @@ -0,0 +1,39 @@
> +NVIDIA Legacy Interrupt Controller
> +
> +All Tegra SoCs contain a legacy interrupt controller that routes
> +interrupts to the GIC, and also serves as a wakeup source. It is also
> +refered to as "ictlr", hence the name of the binding.
> +
> +The HW block exposes a number of frames, each implementing a set of 32
> +interrupts.

I don't think I've ever seen them referred to as "frames". They are
technically separate instances of the same controller. Maybe:

	"The HW block exposes a number of controllers, ..."

?

> +
> +Reguired properties:
> +
> +- compatible : should contain at least "nvidia,tegra-ictlr".

As previously discussed I think this should be something along the lines
of:

	should be one of:
	- "nvidia,tegra20-ictlr"
	- "nvidia,tegra30-ictlr"

Or similar. In the past, we've used "nvidia,tegra<chip>-foo" to wildcard
the compatible string so that we don't have to modify the documentation
for every new chip. The above has the disadvantage that it omits that we
should always provide a most specific compatible string, too, so maybe
something like the following would be even better:

	should be: "nvidia,tegra<chip>-ictlr". The LIC on subsequent
	SoCs remained backwards-compatible with Tegra30, so on Tegra
	generations later than Tegra30 the compatible value should
	include "nvidia,tegra30-ictlr".

> +- reg : Specifies base physical address and size of the registers.
> +  Each frame must be described separately.

"Each controller must be described separately."? Also maybe mention that
this Tegra20 has 4 of them, whereas Tegra30 and later have 5? That way
people will know how many entries are required.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150108/ac662c63/attachment.sig>
