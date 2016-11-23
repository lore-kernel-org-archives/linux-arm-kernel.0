From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Wed, 23 Nov 2016 12:06:24 +0100
Subject: [PATCH v3 0/3] da8xx: fix section mismatch in new drivers
Message-ID: <1479899187-10199-1-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sekhar noticed there's a section mismatch in the da8xx-mstpri and
da8xx-ddrctl drivers. This is caused by calling
of_flat_dt_get_machine_name() which has an __init annotation.

This series addresses this issue by open coding routines that return
the machine compatible string in both drivers. Once a general function
for that in of/base is merged, we'll remove them.

The third patch fixes a typo that got in last time.

v1 -> v2:
- drop patch [1/3] from v1
- introduce internal routines in the drivers instead of a general
  function in of/base.c

v2 -> v3:
- use of_property_read_string_index() instead of
  of_property_read_string() to get the first compatible entry
- s/priotities/priorities

Bartosz Golaszewski (3):
  bus: da8xx-mstpri: drop the call to of_flat_dt_get_machine_name()
  memory: da8xx-ddrctl: drop the call to of_flat_dt_get_machine_name()
  bus: da8xx-mstpri: fix a typo

 drivers/bus/da8xx-mstpri.c    | 25 ++++++++++++++++++++++---
 drivers/memory/da8xx-ddrctl.c | 23 +++++++++++++++++++++--
 2 files changed, 43 insertions(+), 5 deletions(-)

-- 
2.9.3
