From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 24 Feb 2014 16:36:37 +0100
Subject: [RFC PATCH v3 0/9] imx-drm dt bindings
In-Reply-To: <1392723370-4772-1-git-send-email-p.zabel@pengutronix.de>
References: <1392723370-4772-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1393256197.3091.49.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 18.02.2014, 12:36 +0100 schrieb Philipp Zabel:
> Hi,
> 
> here is an updated and more complete version of the imx-drm DT binding
> series. These patches apply on top of Russell's second preview of the
> imx-drm cleanup series on v3.14-rc2. I have added device tree bindings
> between IPU and the encoders as documented in
> Documentation/devicetree/bindings/media/video-interfaces.txt
> and used those to determine the possible_crtcs and mux_id.
> 
> The crtc cookie is replaced with a the port device tree node,
> which is unique and therefore allows to get rid of the di_id
> comparison. Storing the multiplexer input numbers in the device
> tree removes the need to know the ipu_id. This should also allow
> to replace IPU2 with LCDIF on i.MX6 Solo more easily.
> 
> In v3 also connections between display interface ports and encoders are
> used to find all necessary components, so that only the display interfaces
> have to be configured in the imx-drm node. This allows to move the imx-drm
> node into the SoC level dtsi. I've also updated the existing i.MX51 and
> i.MX53 device trees this time and updated/added the devicetree binding
> documentation.
> 
> Patch 2/9 adds a temporary copy of the v4l2_of parser functions. Those
> are going to be moved to some place where they can be used by drm drivers,
> eventually, so those local copies can be dropped again.

Russell has sent a pull request for the imx-drm component support series
now, and we're at v3.13-rc4 already. This patch series still applies on
top of
git://ftp.arm.linux.org.uk/~rmk/linux-arm.git imx-drm-staging
I'd appreciate some feedback on this. Or shall I resend without the RFC?

regards
Philipp

> regards
> Philipp
> 
> Lucas Stach (1):
>   staging: imx-drm-core: don't request probe deferral in
>     imx_drm_encoder_parse_of
> 
> Philipp Zabel (8):
>   staging: imx-drm: Add temporary copies of v4l2-of parsing functions
>   staging: imx-drm-core: Use OF graph to find components and connections
>     between encoder and crtcs
>   staging: imx-drm: Document updated imx-drm device tree bindings
>   staging: imx-drm: Document imx-hdmi device tree bindings
>   ARM: dts: imx51: Add IPU ports and endpoints, move imx-drm node to
>     dtsi
>   ARM: dts: imx53: Add IPU DI ports and endpoints, move imx-drm node to
>     dtsi
>   ARM: dts: imx6qdl: Add IPU DI ports and endpoints, move imx-drm node
>     to dtsi
>   staging: imx-drm: Update TODO
> 
>  .../bindings/staging/imx-drm/fsl-imx-drm.txt       |  48 ++++-
>  .../devicetree/bindings/staging/imx-drm/hdmi.txt   |  53 +++++
>  .../devicetree/bindings/staging/imx-drm/ldb.txt    |  20 +-
>  arch/arm/boot/dts/imx51-apf51dev.dts               |  11 +-
>  arch/arm/boot/dts/imx51-babbage.dts                |  28 ++-
>  arch/arm/boot/dts/imx51.dtsi                       |  22 ++-
>  arch/arm/boot/dts/imx53-m53evk.dts                 |  17 +-
>  arch/arm/boot/dts/imx53-mba53.dts                  |  15 +-
>  arch/arm/boot/dts/imx53-qsb.dts                    |  17 +-
>  arch/arm/boot/dts/imx53.dtsi                       |  64 +++++-
>  arch/arm/boot/dts/imx6dl.dtsi                      |  22 +--
>  arch/arm/boot/dts/imx6q-sabresd.dts                |   4 -
>  arch/arm/boot/dts/imx6q.dtsi                       | 124 +++++++++++-
>  arch/arm/boot/dts/imx6qdl-sabresd.dtsi             |   6 -
>  arch/arm/boot/dts/imx6qdl.dtsi                     | 138 ++++++++++++-
>  drivers/staging/imx-drm/Makefile                   |   2 +-
>  drivers/staging/imx-drm/TODO                       |   5 -
>  drivers/staging/imx-drm/imx-drm-core.c             | 217 ++++++++++++++-------
>  drivers/staging/imx-drm/imx-drm-of.c               | 132 +++++++++++++
>  drivers/staging/imx-drm/imx-drm.h                  |  11 +-
>  drivers/staging/imx-drm/imx-hdmi.c                 |   2 +-
>  drivers/staging/imx-drm/imx-ldb.c                  |   4 +-
>  drivers/staging/imx-drm/ipuv3-crtc.c               |  47 ++++-
>  23 files changed, 842 insertions(+), 167 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/staging/imx-drm/hdmi.txt
>  create mode 100644 drivers/staging/imx-drm/imx-drm-of.c
> 
