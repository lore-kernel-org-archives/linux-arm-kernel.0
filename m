From: a.hajda@samsung.com (Andrzej Hajda)
Date: Fri, 27 Apr 2018 09:11:10 +0200
Subject: [PATCH 00/24] device link, bridge supplier <-> drm device
In-Reply-To: <20180426223139.16740-1-peda@axentia.se>
References: <CGME20180426223215epcas2p38fe3b0b7b1ea1c8190805f9e2a89e11e@epcas2p3.samsung.com>
 <20180426223139.16740-1-peda@axentia.se>
Message-ID: <25d8e621-b3f8-094f-32a2-d22efc2163a4@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On 27.04.2018 00:31, Peter Rosin wrote:
> Hi!
>
> It was noted by Russel King [1] that bridges (not using components)
> might disappear unexpectedly if the owner of the bridge was unbound.
> Jyri Sarha had previously noted the same thing with panels [2]. Jyri
> came up with using device links to resolve the panel issue, which
> was also my (independent) reaction to the note from Russel.
>
> This series builds up to the addition of that link in the last
> patch, but in my opinion the other 23 patches do have merit on their
> own.
>
> The last patch needs testing, while the others look trivial. That
> said, I might have missed some subtlety.

of_node is used as an identifier of the bridge in the kernel. If you
replace it with device pointer there will be potential problem with
devices having two or more bridges, how do you differentiate bridges if
the owner is the same? If I remember correctly current bridge code does
not allow to have multiple bridges in one device, but that should be
quite easy to fix if necessary. After this change it will become more
difficult.

Anyway I remember discussion that in DT world bridge should be
identified rather by of_graph port node, not by parent node as it is
now. If you want to translate this relation to device owner, you should
add also port number to have full identification of the bridge, ie pair
(owner, port_number) would be equivalent of port node.

Regards
Andrzej


>
> Cheers,
> Peter
>
> [1] https://lkml.org/lkml/2018/4/23/769
> [2] https://www.spinics.net/lists/dri-devel/msg174275.html
>
> Peter Rosin (24):
>   drm/bridge: allow optionally specifying an .owner device
>   drm/bridge: adv7511: provide an .owner device
>   drm/bridge/analogix: core: specify the .owner of the bridge
>   drm/bridge: analogix-anx78xx: provide an .owner device
>   drm/bridge: vga-dac: provide an .owner device
>   drm/bridge: lvds-encoder: provide an .owner device
>   drm/bridge: megachips-stdpxxxx-ge-b850v3-fw: provide an .owner device
>   drm/bridge: nxp-ptn3460: provide an .owner device
>   drm/bridge: panel: provide an .owner device
>   drm/bridge: ps8622: provide an .owner device
>   drm/bridge: sii902x: provide an .owner device
>   drm/bridge: sii9234: provide an .owner device
>   drm/bridge: sii8620: provide an .owner device
>   drm/bridge: synopsys: provide an .owner device for the bridges
>   drm/bridge: tc358767: provide an .owner device
>   drm/bridge: ti-tfp410: provide an .owner device
>   drm/exynos: mic: provide an .owner device for the bridge
>   drm/mediatek: hdmi: provide an .owner device for the bridge
>   drm/msm: specify the .owner of the bridges
>   drm/rcar-du: lvds: provide an .owner device for the bridge
>   drm/sti: provide an .owner device for the bridges
>   drm/bridge: remove the .of_node member
>   drm/bridge: require the .owner to be filled in on drm_bridge_attach
>   drm/bridge: establish a link between the bridge supplier and consumer
>
>  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c       |  2 +-
>  drivers/gpu/drm/bridge/analogix-anx78xx.c          |  5 +----
>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |  1 +
>  drivers/gpu/drm/bridge/dumb-vga-dac.c              |  2 +-
>  drivers/gpu/drm/bridge/lvds-encoder.c              |  2 +-
>  .../drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c   |  2 +-
>  drivers/gpu/drm/bridge/nxp-ptn3460.c               |  2 +-
>  drivers/gpu/drm/bridge/panel.c                     |  4 +---
>  drivers/gpu/drm/bridge/parade-ps8622.c             |  2 +-
>  drivers/gpu/drm/bridge/sii902x.c                   |  2 +-
>  drivers/gpu/drm/bridge/sii9234.c                   |  2 +-
>  drivers/gpu/drm/bridge/sil-sii8620.c               |  2 +-
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          |  4 +---
>  drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c      |  4 +---
>  drivers/gpu/drm/bridge/tc358767.c                  |  2 +-
>  drivers/gpu/drm/bridge/ti-tfp410.c                 |  2 +-
>  drivers/gpu/drm/drm_bridge.c                       | 23 +++++++++++++++++++++-
>  drivers/gpu/drm/exynos/exynos_drm_mic.c            |  2 +-
>  drivers/gpu/drm/mediatek/mtk_hdmi.c                |  2 +-
>  drivers/gpu/drm/msm/dsi/dsi_manager.c              |  1 +
>  drivers/gpu/drm/msm/edp/edp_bridge.c               |  1 +
>  drivers/gpu/drm/msm/hdmi/hdmi_bridge.c             |  1 +
>  drivers/gpu/drm/rcar-du/rcar_lvds.c                |  2 +-
>  drivers/gpu/drm/sti/sti_dvo.c                      |  2 +-
>  drivers/gpu/drm/sti/sti_hda.c                      |  1 +
>  drivers/gpu/drm/sti/sti_hdmi.c                     |  1 +
>  include/drm/drm_bridge.h                           |  8 ++++----
>  27 files changed, 51 insertions(+), 33 deletions(-)
>
