From: robh+dt@kernel.org (Rob Herring)
Date: Tue, 21 Feb 2017 08:57:51 -0600
Subject: [PATCH 2/2] media: dt-bindings: vpif: extend the example with an
 output port
In-Reply-To: <1487268237-4240-3-git-send-email-bgolaszewski@baylibre.com>
References: <1487268237-4240-1-git-send-email-bgolaszewski@baylibre.com>
 <1487268237-4240-3-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <CAL_Jsq+f+H47iFNMZ5+2qG0n=6QDZOLPf2HtFH8SLD77Dq1e7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2017 at 12:03 PM, Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:
> This makes the example more or less correspond with the da850-evm
> hardware setup.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  .../devicetree/bindings/media/ti,da850-vpif.txt    | 36 +++++++++++++++++-----
>  1 file changed, 29 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/media/ti,da850-vpif.txt b/Documentation/devicetree/bindings/media/ti,da850-vpif.txt
> index 9c7510b..d6f93a1 100644
> --- a/Documentation/devicetree/bindings/media/ti,da850-vpif.txt
> +++ b/Documentation/devicetree/bindings/media/ti,da850-vpif.txt
> @@ -16,7 +16,7 @@ Required properties:
>  Video Capture:
>
>  VPIF has a 16-bit parallel bus input, supporting 2 8-bit channels or a
> -single 16-bit channel.  It should contain at least one port child node
> +single 16-bit channel. It should contain one or two port child nodes

When do you not have an output? Seems kind of useless. I'm guessing
this is an oversight in the binding and there should always be port 1
and a connector node, so document it that way.

This also needs to state what port 0 and port 1 are (i.e. input or
output and type of data).

>  with child 'endpoint' node. Please refer to the bindings defined in
>  Documentation/devicetree/bindings/media/video-interfaces.txt.
>
> @@ -28,19 +28,26 @@ I2C-connected TVP5147 decoder:
>                 reg = <0x217000 0x1000>;
>                 interrupts = <92>;
>
> -               port {
> -                       vpif_ch0: endpoint at 0 {
> +               port at 0 {
> +                       vpif_input_ch0: endpoint at 0 {
>                                 reg = <0>;
>                                 bus-width = <8>;
> -                               remote-endpoint = <&composite>;
> +                               remote-endpoint = <&composite_in>;
>                         };
>
> -                       vpif_ch1: endpoint at 1 {
> +                       vpif_input_ch1: endpoint at 1 {
>                                 reg = <1>;
>                                 bus-width = <8>;
>                                 data-shift = <8>;
>                         };
>                 };
> +
> +               port at 1 {
> +                       vpif_output_ch0: endpoint {
> +                               bus-width = <8>;

Isn't this an analog input? bus-width doesn't make sense for that.

Rob
