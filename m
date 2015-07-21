From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 21 Jul 2015 15:50:42 +0200
Subject: [RFC PATCH 0/16] Declarative specification of resources (aka
 devm_probe)
Message-ID: <1437486658-28365-1-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this is an experiment I carried to find out if having drivers to declare
their resources could help with dependency discovery. The goal was to
avoid duplicating information between resource acquisition and
dependency discovery.

I think this approach can help a lot with reducing boilerplate code in
the probe() callbacks, but regarding dependency discovery it wouldn't
really bring much at all when compared to probing devices on-demand from
the resource acquisition code paths (ie. calling device_attach() from
devm_regulator_get()).

Because it doesn't help with dependency discovery I'm going to stop
working on this, but wanted to send it out in case someone else would
want to work on it. I think it's a pretty neat improvement over how
things are currently done.

There was a bit of a problem with converting fixed-regulator, because
it's able to use platform data to find resources out. If it moved to use
generic properties of the kind that are added with
device_add_property_set(), it could be made to work more easily (but who
would change the board files and test the changes?).

The credit for this idea should go to Arnd Bergmann, who also wrote the
initial PoC on which this is based.

Regards,

Tomeu


Tomeu Vizoso (16):
  typecheck_member and offsetof_t
  add devm_acquire_resources()
  Add DEVM_ALLOC()
  Add DEVM_IOMAP()
  Add DEVM_RESET()
  Add DEVM_CLOCK()
  Add DEVM_FWNODE()
  Add DEVM_IRQ()
  Add DEVM_GPIO_NAMED()
  Add DEVM_REGULATOR()
  Add DEVM_TEGRA_DPAUX()
  Add DEVM_TEGRA_OUTPUT()
  tegra-sor: Use devm_resource
  tegra-dpaux: Use devm_resource
  tegra-max98090: Use devm_resource
  fixed-regulator: Use devm_resource

 drivers/base/dd.c                  |   4 ++
 drivers/base/devres.c              | 106 +++++++++++++++++++++++++++++++++++++
 drivers/base/property.c            |  17 ++++++
 drivers/clk/clk.c                  |  13 +++++
 drivers/gpio/devres.c              |  16 ++++++
 drivers/gpu/drm/tegra/dpaux.c      |  81 ++++++++++++++--------------
 drivers/gpu/drm/tegra/drm.h        |  24 +++++++++
 drivers/gpu/drm/tegra/sor.c        |  60 ++++++---------------
 drivers/regulator/devres.c         |  18 +++++++
 drivers/regulator/fixed.c          |  33 ++++--------
 drivers/reset/core.c               |  13 +++++
 include/linux/clk.h                |  10 ++++
 include/linux/device.h             |  39 ++++++++++++++
 include/linux/gpio/consumer.h      |  11 ++++
 include/linux/interrupt.h          |  24 +++++++++
 include/linux/property.h           |  10 ++++
 include/linux/regulator/consumer.h |  10 ++++
 include/linux/reset.h              |  10 ++++
 include/linux/stddef.h             |   7 +++
 kernel/irq/devres.c                |  52 ++++++++++++++++++
 sound/soc/tegra/tegra_max98090.c   |  69 +++++++++---------------
 21 files changed, 474 insertions(+), 153 deletions(-)

-- 
2.4.3
