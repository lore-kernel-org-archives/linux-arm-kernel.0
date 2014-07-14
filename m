From: naveenkrishna.ch@gmail.com (Naveen Krishna Ch)
Date: Mon, 14 Jul 2014 18:12:48 +0530
Subject: [PATCH v2] ARM: dts: Add mask-tpm-reset to the device tree
In-Reply-To: <1405319602-29892-1-git-send-email-vikas.sajjan@samsung.com>
References: <1405319602-29892-1-git-send-email-vikas.sajjan@samsung.com>
Message-ID: <CAHfPSqDphnUB27tfp+8peQpbSKAAtatAEnzAHmmDottxv6yy-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Vikas,


On 14 July 2014 12:03, Vikas Sajjan <vikas.sajjan@samsung.com> wrote:
> From: Doug Anderson <dianders@chromium.org>
>
> The mask-tpm-reset GPIO is used by the kernel to prevent the TPM from
> being reset across sleep/wake.  If we don't set it to anything then
> the TPM will be reset.  U-Boot will detect this as invalid
> and will reset the system on resume time. This GPIO can always be low
> and not hurt anything.  It will get pulled back high again during a
> normal warm reset when it will default back to an input.
>
> To properly preserve the TPM state across suspend/resume and to make
> the chrome U-Boot happy, properly set the GPIO to mask the
> reset to the TPM.
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Vikas Sajjan <vikas.sajjan@samsung.com>

After merging Linus Walleij's for-next branch of pinctrl git.

S2R on Exynos5420 based Peach PIT works fine.

Tested-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
> ---
> changes since v1:
>         - removed fixed regulator and used hogs instead.
>
>  arch/arm/boot/dts/exynos5420-peach-pit.dts |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
> index 6c7cab0..c036d9e 100644
> --- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
> +++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
> @@ -211,6 +211,18 @@
>
>
>  &pinctrl_0 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&mask_tpm_reset>;
> +
> +       /* We need GPX0_6 to be low at sleep time; just keep it low always */
> +       mask_tpm_reset: mask-tpm-reset {
> +               samsung,pins = "gpx0-6";
> +               samsung,pin-function = <1>;
> +               samsung,pin-pud = <0>;
> +               samsung,pin-drv = <0>;
> +               samsung,pin-val = <0>;
> +       };
> +
>         max98090_irq: max98090-irq {
>                 samsung,pins = "gpx0-2";
>                 samsung,pin-function = <0>;
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Shine bright,
(: Nav :)
