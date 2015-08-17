From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 17 Aug 2015 12:09:14 +0200
Subject: [PATCH] drm: panel: simple: add QiaoDian qd43003c0-40
In-Reply-To: <1438382671-10098-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1438382671-10098-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20150817100913.GA8453@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 01, 2015 at 12:44:31AM +0200, Alexandre Belloni wrote:
> From: Josh Wu <josh.wu@atmel.com>
> 
> The QiaoDian Xianshi QD43003C0-40 is a 4"3 TFT LCD panel.
> 
> Timings from the OTA5180A document, ver 0.9, section
> 10.1.1:
>   http://www.orientdisplay.com/pdf/OTA5180A.pdf
> 
> Signed-off-by: Josh Wu <josh.wu@atmel.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  .../devicetree/bindings/panel/qd,qd43003c0-40.txt  |  7 ++++++
>  drivers/gpu/drm/panel/panel-simple.c               | 26 ++++++++++++++++++++++
>  2 files changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/panel/qd,qd43003c0-40.txt

You didn't run this through scripts/get_maintainer.pl, did you? It would
also help to use the standard prefix ("drm/panel: ") because I end up
filtering for that occasionally in case somebody didn't Cc me on panel
patches.

I only came across this by accident, and it's going to miss 4.3 now.

Also two comments below...

> diff --git a/Documentation/devicetree/bindings/panel/qd,qd43003c0-40.txt b/Documentation/devicetree/bindings/panel/qd,qd43003c0-40.txt
> new file mode 100644
> index 000000000000..900bc6ebeaff
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/panel/qd,qd43003c0-40.txt
> @@ -0,0 +1,7 @@
> +QiaoDian XianShi Corporation 4"3 TFT LCD panel
> +
> +Required properties:
> +- compatible: should be "qd,qd43003c0-40"
> +
> +This binding is compatible with the simple-panel binding, which is specified
> +in simple-panel.txt in this directory.

I don't see a vendor prefix for QiaoDian XianShi Corporation in
Documentation/devicetree/bindings/vendor-prefixes.txt.

> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index f94201b6e882..e688fa545ae3 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -967,6 +967,29 @@ static const struct panel_desc ortustech_com43h4m85ulc = {
>  	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
>  };
>  
> +static const struct drm_display_mode qd43003c0_40_mode = {
> +	.clock = 9000,
> +	.hdisplay = 480,
> +	.hsync_start = 480 + 8,
> +	.hsync_end = 480 + 8 + 4,
> +	.htotal = 480 + 8 + 4 + 39,
> +	.vdisplay = 272,
> +	.vsync_start = 272 + 4,
> +	.vsync_end = 272 + 4 + 10,
> +	.vtotal = 272 + 4 + 10 + 2,
> +	.vrefresh = 60,
> +};
> +
> +static const struct panel_desc qd43003c0_40 = {
> +	.modes = &qd43003c0_40_mode,
> +	.num_modes = 1,
> +	.size = {
> +		.width = 95,
> +		.height = 53,
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
> +};

Can you also add .bpc = 8 above so that drivers that don't support the
.bus_format can still support this panel?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150817/b3aafb8f/attachment.sig>
