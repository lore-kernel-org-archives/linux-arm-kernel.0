From: peda@axentia.se (Peter Rosin)
Date: Wed, 23 May 2018 11:31:15 +0200
Subject: [PATCH v5 0/7] Add tda998x (HDMI) support to atmel-hlcdc
Message-ID: <20180523093122.27859-1-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

I naively thought that since there was support for both nxp,tda19988 (in
the tda998x driver) and the atmel-hlcdc, things would be a smooth ride.
But it wasn't, so I started looking around and realized I had to fix
things.

In v1 and v2 I fixed things by making the atmel-hlcdc driver a master
component, but now I fix things by making the tda998x driver a bridge
instead. This was after a suggestion from Boris Brezillon the
atmel-hlcdc maintainer), so there was some risk of bias ... but after
comparing what was needed, I too find the bridge approach more direct.
In v4, an issue was noted by Russell King in that the tda998x device
might be unbound with shattering results for the main drm device.
This is of course a real problem and it needs to be fixed. I have
submitted a series [1] that tries to do that. However, since there are
currently *10* other bridges (analogix-anx78xx, adv7511, megachips_stdp*,
nxp-ptn3460, parade-ps8622, sii902x, sii9234, sil-sii8620, tc358767 and
ti-tfp410) with exactly the same problem (they are all I2C devices that
might be unexpectedly unbound without safety-net, at least that is how I
read it), I think it should be ok to add one more and then fix them all
instead of holding this series hostage. Apparently people don't go around
and unbind I2C devices all that often...

In addition to the above, our PCB interface between the SAMA5D3 and the
HDMI encoder is only using 16 bits, and this has to be described
somewhere, or the atmel-hlcdc driver have no chance of selecting the
correct output mode. Since I have similar problems with a ds90c185 lvds
encoder I added patches to override the atmel-hlcdc output format via
DT properties compatible with the media video-interface binding and
things start to play together.

Anyway, this series solves some real issues for my HW.

Also, is it perhaps possible that patches 1-3 can be taken independently
from 4-7? There is no hard dependency between the two parts of this series.
Patches 1-3 have the relevant tags and should be uncontroversial...

Cheers,
Peter

Changes since v4   https://lkml.org/lkml/2018/4/23/92
- added reviewed-by from Rob to patch 2/7
- dropped patch 8, since the issue noted by Russell King is not present
  when working with components as tilcdc currently do when handling tda998x

Changes since v3   https://lkml.org/lkml/2018/4/19/736
- moved the meat of the drm_of_media_bus_fmt function from patch 3/7
  to a driver-local atmel_hlcdc_of_bus_fmt function, and squashed with
  patch 4/7 (this is now patch 3/8).
- patch 3/8 now parses and stores the DT bus format together with the
  encoder in a reintroduced struct atmel_hlcdc_rgb_output instead of
  allocating a separate encoder-indexed array for the bus formats.
- patch 5/8 is new and splits tda988x_encoder_dpms into a pair of
  functions to enable/disable separately. This fits better with both
  the current code and for the followup drm_bridge patch (7/8).
- adjust patch 6/8 and 7/8 to the above simplification.
- added patch 8/8 that removes component master code from tilcdc.

Changes since v2   https://lkml.org/lkml/2018/4/17/385
- patch 2/7 fixed spelling and added an example
- patch 4/7 parse the DT up front and store the result indexed by encoder
- old patch 5/6 and 6/6 dropped
- patch 5-7/7 are new and makes the tda998x driver a drm_bridge

Changes since v1   https://lkml.org/lkml/2018/4/9/294
- added reviewed-by from Rob to patch 1/6
- patch 2/6 changed so that the bus format override is in the endpoint
  DT node, and follows the binding of media video-interfaces.
- patch 3/6 is new, it adds drm_of_media_bus_fmt which parses above
  media video-interface binding (partially).
- patch 4/6 now makes use of the above helper (and also fixes problems
  with the 3/5 patch from v1 when no override was specified).
- do not mention unrelated connector display_info details in the cover
  letter and commit messages.

[1] https://lkml.org/lkml/2018/5/16/380

Peter Rosin (7):
  dt-bindings: display: bridge: lvds-transmitter: add ti,ds90c185
  dt-bindings: display: atmel: optional video-interface of endpoints
  drm/atmel-hlcdc: support bus-width (12/16/18/24) in endpoint nodes
  drm/i2c: tda998x: find the drm_device via the drm_connector
  drm/i2c: tda998x: split tda998x_encoder_dpms into enable/disable
  drm/i2c: tda998x: split encoder and component functions from the work
  drm/i2c: tda998x: register as a drm bridge

 .../devicetree/bindings/display/atmel/hlcdc-dc.txt |  26 ++
 .../bindings/display/bridge/lvds-transmitter.txt   |   8 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c     |  70 ++++--
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h       |   1 +
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c   |  67 +++++-
 drivers/gpu/drm/i2c/tda998x_drv.c                  | 268 ++++++++++++++++-----
 6 files changed, 351 insertions(+), 89 deletions(-)

-- 
2.11.0
