From: acourbot@nvidia.com (Alexandre Courbot)
Date: Tue, 8 Jan 2013 16:18:51 +0900
Subject: [PATCH 0/4] gpio: introduce descriptor-based interface
Message-ID: <1357629535-26033-1-git-send-email-acourbot@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series introduce a first take at implementing the RFC for the new GPIO API
that I submitted last month. It proposes a new, opaque descriptor-based GPIO API
that becomes available when GPIOlib is compiled, and provides a safer, more
abstract alternative to the current integer-based interface. GPIOlib internals
are also switched to use the descriptor logic, and the former integer API
becomes a lightweight wrapper around the new descriptor-based API.

Functionally speaking the new API is identical to the integer-based API, with
only the prefix changing from gpio_ to gpiod_. However, the second patch
introduces new functions for obtaining GPIOs from a device and a consumer name,
in a fashion similar to what is done with e.g. regulators and PWMs.

GPIOs can then be provided either by board-specific lookup tables, or through
the device tree. Device tree lookup might require some attention as it does not
handle properties with multiple descriptors yet. Also, there is currently no
equivalent of gpio_request_array() and GPIOs can only be allocated one-by-one.
Feedback about the relevancy of batch requesting GPIOs is welcome.

This patch series also prepares GPIOlib for the next step, which is getting rid
of ARCH_NR_GPIOS and of the static array in GPIOlib and replace the latter with
per-chip arrays that are allocated when the chip is added. Some challenge may
arise from the fact that gpiochip_add is potentially called before kmalloc is
available.

Anyway, I expect this patchset to go through several iterations in order to
address the points mentioned above (and of course the ones I missed). As usual,
your valuable feedback is most welcome.

Alexandre Courbot (4):
  gpiolib: introduce descriptor-based GPIO interface
  gpiolib: add gpiod_get and gpiod_put functions
  gpiolib: of: convert OF helpers to descriptor API
  gpiolib: add documentation for new gpiod_ API

 Documentation/gpio.txt        |  94 +++++-
 drivers/gpio/devres.c         |  59 +++-
 drivers/gpio/gpiolib-of.c     |  26 +-
 drivers/gpio/gpiolib.c        | 648 ++++++++++++++++++++++++++++--------------
 include/asm-generic/gpio.h    | 176 ++++--------
 include/linux/gpio/consumer.h | 128 +++++++++
 include/linux/gpio/driver.h   | 171 +++++++++++
 include/linux/of_gpio.h       |  73 +----
 8 files changed, 956 insertions(+), 419 deletions(-)
 create mode 100644 include/linux/gpio/consumer.h
 create mode 100644 include/linux/gpio/driver.h

-- 
1.8.1
