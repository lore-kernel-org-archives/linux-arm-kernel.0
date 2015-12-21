From: djkurtz@chromium.org (Daniel Kurtz)
Date: Mon, 21 Dec 2015 12:07:58 +0800
Subject: [PATCH 2/3] thermal: Add Mediatek thermal controller support
In-Reply-To: <1448883753-19068-3-git-send-email-s.hauer@pengutronix.de>
References: <1448883753-19068-1-git-send-email-s.hauer@pengutronix.de>
 <1448883753-19068-3-git-send-email-s.hauer@pengutronix.de>
Message-ID: <CAGS+omC86=Kfdj0cFNHqs4fXCAT0uU+AxHCj3ORd2HetNZ2gVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

One nit below that can be fixed up later, or now if you don't plan to
spin this driver to
address Eduardo's feedback...

On Mon, Nov 30, 2015 at 7:42 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> This adds support for the Mediatek thermal controller found on MT8173
> and likely other SoCs.
> The controller is a bit special. It does not have its own ADC, instead
> it controls the on-SoC AUXADC via AHB bus accesses. For this reason
> we need the physical address of the AUXADC. Also it controls a mux
> using AHB bus accesses, so we need the APMIXEDSYS physical address aswell.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

[snip]

> +static int mtk_thermal_get_calibration_data(struct device *dev, struct mtk_thermal *mt)
> +{
> +       struct nvmem_cell *cell;
> +       u32 *buf;
> +       size_t len;
> +       int i, ret = 0;
> +
> +       /* Start with default values */
> +       mt->adc_ge = 512;
> +       for (i = 0; i < MT8173_NUM_SENSORS; i++)
> +               mt->vts[i] = 260;
> +       mt->degc_cali = 40;
> +       mt->o_slope = 0;
> +
> +       cell = nvmem_cell_get(dev, "calibration-data");
> +       if (IS_ERR(cell)) {
> +               if (PTR_ERR(cell) == -EPROBE_DEFER)

It is useful to know why the thermal driver is being probe defered, so
I suggest here:
dev_warn(dev, "Waiting for calibration data.\n");

> +                       return PTR_ERR(cell);
> +               return 0;
> +       }

Thanks,
-Dan
