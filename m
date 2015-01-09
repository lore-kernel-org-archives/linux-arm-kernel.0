From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 09 Jan 2015 16:46:43 +0100
Subject: [PATCH v2 2/4] Documentation: bindings: Add the regulator property
 to the sub-nodes AHCI bindings
In-Reply-To: <1420799989-10645-3-git-send-email-gregory.clement@free-electrons.com>
References: <1420799989-10645-1-git-send-email-gregory.clement@free-electrons.com>
 <1420799989-10645-3-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <54AFF7E3.4070506@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 09-01-15 11:39, Gregory CLEMENT wrote:
> It is now possible to use a regulator property for each port of the
> AHCI controller.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>   Documentation/devicetree/bindings/ata/ahci-platform.txt | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> index 4ab09f2202d4..87416d71c758 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> @@ -37,9 +37,10 @@ Required properties when using sub-nodes:
>
>
>   Sub-nodes required properties:
> -- reg               : the port number
> -- phys              : reference to the SATA PHY node
> -
> +- reg					: the port number
> +And at least one of the following properties:
> +- phys              	: reference to the SATA PHY node
> +- target-port<n>-supply	: regulator for SATA target power for port <n>
>
>   Examples:
>           sata at ffe08000 {
> @@ -68,10 +69,12 @@ With sub-nodes:
>   		sata0: sata-port at 0 {
>   			reg = <0>;
>   			phys = <&sata_phy 0>;
> +			target-port0-supply = <&reg_sata0>;
>   		};
>

I'm sorry, but I've to NAK this, I did not follow the regulator discussion.,
thinking that it was just about the use of some utility function vs diy or
some such, I had no idea this would impact the dt-binding.

The -port%d- bit is completely unnecessary from a dt pov. Devicetree is
supposed to be OS agnostic, we cannot make the dt-binding ugly just because
the regulator subsys in Linux does not provide the necessary functionality.

I'm afraid you will have to get back to the regulator subsys people and tell
them that we really need an of_regulator_get, so that we can tell the
regulator subsys we want a regulator from a specific of_node.

Please CC me when you re-open the discussion with the regulator people.

Regards,

Hans
