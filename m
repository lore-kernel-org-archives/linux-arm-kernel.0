From: lars@metafoo.de (Lars-Peter Clausen)
Date: Sat, 31 Aug 2013 17:10:30 +0200
Subject: [alsa-devel] [PATCH 2/3] ASoC: generic simple sound card DT
 bindings
In-Reply-To: <1377945878-13322-3-git-send-email-mpa@pengutronix.de>
References: <1377945878-13322-1-git-send-email-mpa@pengutronix.de>
 <1377945878-13322-3-git-send-email-mpa@pengutronix.de>
Message-ID: <52220766.1040504@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/31/2013 12:44 PM, Markus Pargmann wrote:
> Simple sound card initialized using DT. When used with AC97, ac97-codec
> is used to automatically discover the used codec.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  .../bindings/sound/generic,simple-dt-card.txt      |  28 +++
>  sound/soc/generic/Kconfig                          |   1 +
>  sound/soc/generic/simple-card.c                    | 195 +++++++++++++++++++--
>  3 files changed, 206 insertions(+), 18 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/generic,simple-dt-card.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/generic,simple-dt-card.txt b/Documentation/devicetree/bindings/sound/generic,simple-dt-card.txt
> new file mode 100644
> index 0000000..6b41dbe
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/generic,simple-dt-card.txt
> @@ -0,0 +1,28 @@
> +ASoC Simple Sound Card
> +
> +A simple generic driver that connects a CPU DAI with a CODEC.
> +
> +Required properties:
> + - compatible: "asoc-simple-card" used for standard ssi, codec
> +   combinations, or "asoc-simple-ac97-card" to use ac97 to discover the
> +   codec.
> + - cpu-dai: CPU DAI connected to the codec.
> +
> +Required properties for "asoc-simple-card":
> + - audio-codec: Codec phandle.
> + - codec-dai-name: DAI name within the codec.

In my opinion this binding exposes way to much of the ASoC internal data
structures. E.g. CODECs are referenced by phandle, but the DAI of the CODEC
is reference by a string. This string is completely ASoC internal. The
binding also assumes that a CPU controller may have one DAI at most. In my
opinion this binding ought to use the upcoming of_xlate stuff for ASoC
components.

- Lars
