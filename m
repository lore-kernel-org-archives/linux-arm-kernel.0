From: robh@kernel.org (Rob Herring)
Date: Wed, 21 Oct 2015 17:41:39 -0500
Subject: [PATCH v4 1/6] remoteproc: dt: Provide bindings for ST's Remote
 Processor Controller driver
In-Reply-To: <1445428027-26174-2-git-send-email-lee.jones@linaro.org>
References: <1445428027-26174-1-git-send-email-lee.jones@linaro.org>
 <1445428027-26174-2-git-send-email-lee.jones@linaro.org>
Message-ID: <CAL_JsqK6ZxgfO+_XWKzLG1e=Bd2CZP8Fc2ORnn9_LSH17uNJSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 21, 2015 at 6:47 AM, Lee Jones <lee.jones@linaro.org> wrote:
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Are all the instances the same or are some fixed to audio processing
for example? If the latter, I think the compatible strings should
reflect the function. If the former, then:

Acked-by: Rob Herring <robh@kernel.org>

Rob

> ---
>  .../devicetree/bindings/remoteproc/st-rproc.txt    | 41 ++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/st-rproc.txt
>
> diff --git a/Documentation/devicetree/bindings/remoteproc/st-rproc.txt b/Documentation/devicetree/bindings/remoteproc/st-rproc.txt
> new file mode 100644
> index 0000000..1031bcd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/st-rproc.txt
> @@ -0,0 +1,41 @@
> +STMicroelectronics Co-Processor Bindings
> +----------------------------------------
> +
> +This binding provides support for adjunct processors found on ST SoCs.
> +
> +Co-processors can be controlled from the bootloader or the primary OS. If
> +the bootloader starts a co-processor, the primary OS must detect its state
> +and act accordingly.
> +
> +Required properties:
> +- compatible           Should be one of:
> +                               "st,st231-rproc"
> +                               "st,st40-rproc"
> +- memory-region                Reserved memory (See: ../reserved-memory/reserved-memory.txt)
> +- resets               Reset lines (See: ../reset/reset.txt)
> +- reset-names          Must be "sw_reset" and "pwr_reset"
> +- clocks               Clock for co-processor (See: ../clock/clock-bindings.txt)
> +- clock-frequency      Clock frequency to set co-processor at if the bootloader
> +                       hasn't already done so
> +- st,syscfg            System configuration register which holds the boot vector
> +                       for the co-processor
> +                               1st cell: Phandle to syscon block
> +                               2nd cell: Boot vector register offset
> +
> +Example:
> +
> +       audio_reserved: rproc at 42000000 {
> +               compatible = "shared-dma-pool";
> +               reg = <0x42000000 0x01000000>;
> +               no-map;
> +       };
> +
> +       st231-audio {
> +               compatible      = "st,st231-rproc";
> +               memory-region   = <&audio_reserved>;
> +               resets          = <&softreset STIH407_ST231_AUD_SOFTRESET>;
> +               reset-names     = "sw_reset";
> +               clocks          = <&clk_s_c0_flexgen CLK_ST231_AUD_0>;
> +               clock-frequency = <600000000>;
> +               st,syscfg       = <&syscfg_core 0x228>;
> +       };
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
