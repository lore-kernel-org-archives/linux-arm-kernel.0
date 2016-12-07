From: khilman@baylibre.com (Kevin Hilman)
Date: Tue,  6 Dec 2016 21:08:21 -0800
Subject: [PATCH v5 0/5] davinci: VPIF: add DT support
Message-ID: <20161207050826.23174-1-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prepare the groundwork for adding DT support for davinci VPIF drivers.
This series does some fixups/cleanups and then adds the DT binding and
DT compatible string matching for DT probing.

The controversial part from previous versions around async subdev
parsing, and specifically hard-coding the input/output routing of
subdevs, has been left out of this series.  That part can be done as a
follow-on step after agreement has been reached on the path forward.
With this version, platforms can still use the VPIF capture/display
drivers, but must provide platform_data for the subdevs and subdev
routing.

Tested video capture to memory on da850-lcdk board using composite
input.

Changes since v4:
- dropped controversial async subdev parsing support.  That can be
  done as a follow-up step after the discussions have finalized on the
  right approach.
- DT binding Acked by DT maintainer (Rob H.)
- reworked locking fix (suggested by Laurent)

Changes since v3:
- move to a single VPIF node, DT binding updated accordingly
- misc fixes/updates based on reviews from Sakari

Changes since v2:
- DT binding doc: fix example to use correct compatible

Changes since v1:
- more specific compatible strings, based on SoC: ti,da850-vpif*
- fix locking bug when unlocking over subdev s_stream

Kevin Hilman (5):
  [media] davinci: VPIF: fix module loading, init errors
  [media] davinci: vpif_capture: remove hard-coded I2C adapter id
  [media] davinci: vpif_capture: fix start/stop streaming locking
  [media] dt-bindings: add TI VPIF documentation
  [media] davinci: VPIF: add basic support for DT init

 .../devicetree/bindings/media/ti,da850-vpif.txt    | 67 ++++++++++++++++++++++
 drivers/media/platform/davinci/vpif.c              | 14 ++++-
 drivers/media/platform/davinci/vpif_capture.c      | 26 +++++++--
 drivers/media/platform/davinci/vpif_display.c      |  6 ++
 include/media/davinci/vpif_types.h                 |  1 +
 5 files changed, 108 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/ti,da850-vpif.txt

-- 
2.9.3
