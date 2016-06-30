From: dianders@chromium.org (Doug Anderson)
Date: Thu, 30 Jun 2016 10:45:21 -0700
Subject: [PATCH v3 1/4] arm64: dts: rockchip: add VOP and VOP iommu node
 for rk3399
In-Reply-To: <1466564069-18220-1-git-send-email-ykk@rock-chips.com>
References: <1466564038-18021-1-git-send-email-ykk@rock-chips.com>
 <1466564069-18220-1-git-send-email-ykk@rock-chips.com>
Message-ID: <CAD=FV=URVQTvEKQbUVOXyMnO1a-kGs9inX_AZY3vo_YxXD5-5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Tue, Jun 21, 2016 at 7:54 PM, Yakir Yang <ykk@rock-chips.com> wrote:
> From: Mark Yao <mark.yao@rock-chips.com>
>
> Add the core display-subsystem node and the two display controllers
> available on the rk3399.
>
> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> ---
> Changes in v3: None
> Changes in v2:
> - provide some minimal patch description (Heiko)
>
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 58 ++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index 46f325a..54e5c25 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -543,6 +543,64 @@
>                 status = "disabled";
>         };
>
> +       vopl: vop at ff8f0000 {
> +               compatible = "rockchip,rk3399-vop-lit";
> +               reg = <0x0 0xff8f0000 0x0 0x3efc>;
> +               interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
> +               clocks = <&cru ACLK_VOP1>, <&cru DCLK_VOP1>, <&cru HCLK_VOP1>;
> +               clock-names = "aclk_vop", "dclk_vop", "hclk_vop";

Note that if this lands after Elaine / Caesar's patch ("arm64: dts:
rockchip: add the power domain node for rk3399")
<https://patchwork.kernel.org/patch/9206415/> then you need to respin
adding powerdomain references here for correctness.

If this lands before Elaine / Caesar's patch then the other patch
needs to be re-spun.  ;)


> +               resets = <&cru SRST_A_VOP1>, <&cru SRST_H_VOP1>, <&cru SRST_D_VOP1>;
> +               reset-names = "axi", "ahb", "dclk";
> +               iommus = <&vopl_mmu>;
> +               status = "disabled";
> +
> +               vopl_out: port {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +               };
> +       };
> +
> +       vopl_mmu: iommu at ff8f3f00 {
> +               compatible = "rockchip,iommu";
> +               reg = <0x0 0xff8f3f00 0x0 0x100>;
> +               interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
> +               interrupt-names = "vopl_mmu";
> +               #iommu-cells = <0>;
> +               status = "disabled";
> +       };
> +
> +       vopb: vop at ff900000 {
> +               compatible = "rockchip,rk3399-vop-big";
> +               reg = <0x0 0xff900000 0x0 0x3efc>;
> +               interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
> +               clocks = <&cru ACLK_VOP0>, <&cru DCLK_VOP0>, <&cru HCLK_VOP0>;
> +               clock-names = "aclk_vop", "dclk_vop", "hclk_vop";

Here too, obviously.


See <http://crosreview.com/356623> for reference.


-Doug
