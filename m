From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 28 May 2015 11:02:27 +0200
Subject: [PATCH v14 1/3] dt-bindings: add document of Rockchip power domain
In-Reply-To: <1429862868-14218-2-git-send-email-wxt@rock-chips.com>
References: <1429862868-14218-1-git-send-email-wxt@rock-chips.com>
 <1429862868-14218-2-git-send-email-wxt@rock-chips.com>
Message-ID: <CAPDyKFr544A46Z7kod8EVUYKV1=G6+t4d4ZRdOvskPT4pYL7+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 April 2015 at 10:07, Caesar Wang <wxt@rock-chips.com> wrote:
> This add the necessary binding documentation for the power domain
> found on Rockchip Socs.
>
> Signed-off-by: jinkun.hong <jinkun.hong@rock-chips.com>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> ---
>
>  .../bindings/arm/rockchip/power_domain.txt         | 48 ++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/rockchip/power_domain.txt
>
> diff --git a/Documentation/devicetree/bindings/arm/rockchip/power_domain.txt b/Documentation/devicetree/bindings/arm/rockchip/power_domain.txt
> new file mode 100644
> index 0000000..3e74e6d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/rockchip/power_domain.txt
> @@ -0,0 +1,48 @@
> +* Rockchip Power Domains
> +
> +Rockchip processors include support for multiple power domains which can be
> +powered up/down by software based on different application scenes to save power.
> +
> +Required properties for power domain controller:
> +- compatible: should be one of the following.
> +    * rockchip,rk3288-power-controller - for rk3288 type power domain.
> +- #power-domain-cells: Number of cells in a power-domain specifier.
> +                      should be 1.
> +- rockchip,pmu: phandle referencing a syscon providing the pmu registers
> +- #address-cells: should be 1.
> +- #size-cells: should be 0.
> +
> +Required properties for power domain sub nodes:
> +- reg: index of the power domain, should use macros in:
> +    *  include/dt-bindings/power-domain/rk3288.h - for rk3288 type power domain.

I can't find the above file, nor is it being adding in $subject patch.

Moreover, there are already
"include/dt-bindings/arm/ux500_pm_domains.h".  I suppose we could move
that file into your suggested path, since it seems more generic?

> +- clocks (optional): phandles to clocks which need to be enabled while power domain
> +          switches state.
> +
> +Example:
> +
> +       power: power-controller {
> +              compatible = "rockchip,rk3288-power-controller";
> +              #power-domain-cells = <1>;
> +              rockchip,pmu = <&pmu>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +              pd_gpu {
> +                      reg = <RK3288_PD_GPU>;
> +                      clocks = <&cru ACLK_GPU>;
> +              };
> +       };
> +
> +Node of a device using power domains must have a power-domains property,
> +containing a phandle to the power device node and an index specifying which
> +power domain to use.
> +The index should use macros in:
> +   * include/dt-bindings/power-domain/rk3288.h - for rk3288 type power domain.

Same comment as above.

> +
> +Example of the node using power domain:
> +
> +       node {
> +               /* ... */
> +               power-domains = <&power RK3288_PD_GPU>;
> +               /* ... */
> +       };
> --
> 1.9.1
>
>

Kind regards
Uffe
