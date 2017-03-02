From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Thu, 2 Mar 2017 13:31:38 +0100
Subject: [PATCH v2 3/3] ARM64: dts: meson-gx: Add MALI nodes for GXBB and
 GXL
In-Reply-To: <1488365164-22861-4-git-send-email-narmstrong@baylibre.com>
References: <1488365164-22861-1-git-send-email-narmstrong@baylibre.com>
 <1488365164-22861-4-git-send-email-narmstrong@baylibre.com>
Message-ID: <e26cf584-dab2-2702-f7e6-b28f750fa00c@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil,

Am 01.03.2017 um 11:46 schrieb Neil Armstrong:
> The same MALI-450 MP3 GPU is present in the GXBB and GXL SoCs.

First of all, any reason you're upper-casing Mali in the commit message?
ARM doesn't.

> 
> The node is simply added in the meson-gxbb.dtsi file.

The GXBB part looks fine on a quick look.

> 
> For GXL, since a lot is shared with the GXM that has a MALI-T820 IP, this
> patch adds a new meson-gxl-mali.dtsi and is included in the SoC specific
> dtsi files.

This part is slightly confusing though.

What exactly is the GXL vs. GXM difference that this can't be handled by
overriding node properties compatible/interrupts/clocks? I am missing a
GXM patch in this series as rationale for doing it this way.

In particular I am wondering whether the whole GXM-inherits-from-GXL
concept is flawed and should be adjusted if this leads to secondary
.dtsi files like this: My proposal would be to instead create a
meson-gxl-gxm.dtsi, that meson-gxl.dtsi and meson-gxm.dtsi can inherit
the current common parts from, then the Mali bits can simply go into
meson-gxl.dtsi without extra #includes needed in S905X and S905D. While
it's slightly more work to split once again, I think it would be cleaner.

Regards,
Andreas

> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi      | 37 ++++++++++++++++++++
>  arch/arm64/boot/dts/amlogic/meson-gxl-mali.dtsi  | 43 ++++++++++++++++++++++++
>  arch/arm64/boot/dts/amlogic/meson-gxl-s905d.dtsi |  1 +
>  arch/arm64/boot/dts/amlogic/meson-gxl-s905x.dtsi |  1 +
>  4 files changed, 82 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-mali.dtsi
[...]
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d.dtsi
> index 615308e..5a90e30 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d.dtsi
> @@ -42,6 +42,7 @@
>   */
>  
>  #include "meson-gxl.dtsi"
> +#include "meson-gxl-mali.dtsi"
>  
>  / {
>  	compatible = "amlogic,s905d", "amlogic,meson-gxl";
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x.dtsi
> index 08237ee..0f78d83 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x.dtsi
> @@ -42,6 +42,7 @@
>   */
>  
>  #include "meson-gxl.dtsi"
> +#include "meson-gxl-mali.dtsi"
>  
>  / {
>  	compatible = "amlogic,s905x", "amlogic,meson-gxl";

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
