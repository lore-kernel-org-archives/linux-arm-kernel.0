From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Tue, 30 Jan 2018 18:36:14 -0800
Subject: [PATCH v5 0/4] OF phandle nexus support + GPIO nexus
Message-ID: <20180131023618.14292-1-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a continutation of my phandle remapping/nexus node series
from a while ago. I finally got around to writing the documentation
in the spec for this, but it's really rough around the edges and
could use some review/suggestions to get it into shape. Please
review!

This is one small chunk of work related to DT overlays for expansion
boards. It would be good to have a way to expose #<list>-cells types of
providers through a connector in a standard way. So we introduce a way
to make "nexus" nodes for these types of properties to remap the consumer
number space to the other side of the connector's number space. It's
basically a copy of the interrupt nexus implementation, but without
the address space matching design and interrupt-parent walking.

Changes since v4:
 * Rebased to v4.15
 * Reworded spec patch a bit
 * Dropped overlay stuff from unittest patch because that's done by dtc now

Changes since v3:
 * Added devicetree spec patch
 * Rebased to v4.13-rc1

Changes since v2:
 * Picked up Linus' ack on the gpio core patch
 * Made const stack arrays static (Rob Herring)
 * Used of_property_read_u32() instead of open coding (Rob Herring)

Changes since v1:
 * Addition of optional pass-thru parameter
 * Reduction of strings passed to 1 instead of 3 (or 4 now)
 * Updated gpio patch for the new function signature
 * Updated test-case for new funciton signature and pass-thru parameter
 * Updated kernel-doc to be correct and highlighted difference between this
   API and of_parse_phandle_with_args()

Stephen Boyd (3):
  Document nexus nodes/specifier remapping
  of: Support parsing phandle argument lists through a nexus node
  of: unittest: Add phandle remapping test
  gpio: Support gpio nexus dt bindings

Kernel:
 drivers/gpio/gpiolib-of.c                   |   4 +-
 drivers/of/base.c                           | 184 ++++++++++++++++++++++++++++
 drivers/of/unittest-data/tests-phandle.dtsi |  25 ++++
 drivers/of/unittest.c                       | 120 ++++++++++++++++++
 include/linux/of.h                          |  12 ++
 5 files changed, 343 insertions(+), 2 deletions(-)

Spec:
 source/devicetree-basics.rst | 206 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 206 insertions(+)

-- 
2.7.4
