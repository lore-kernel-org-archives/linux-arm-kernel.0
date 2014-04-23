From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 23 Apr 2014 13:32:40 +0100
Subject: [PATCH v2 0/7] Add cros_ec changes for newer boards
In-Reply-To: <1398185154-19404-1-git-send-email-dianders@chromium.org>
References: <1398185154-19404-1-git-send-email-dianders@chromium.org>
Message-ID: <20140423123240.GA640@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 22 Apr 2014, Doug Anderson wrote:

> This series adds the most critical cros_ec changes for newer boards
> using cros_ec.  Specifically:
> * Fixes timing/locking issues with the previously upstreamed (but
>   never used upstream) cros_ec_spi driver.
> * Updates the cros_ec header file to the latest version which allows
>   us to use newer EC features like i2c tunneling.
> * Adds an i2c tunnel driver to allow communication to the EC's i2c
>   devices.
> 
> This _doesn't_ get the EC driver fully up to speed with what's in the
> current Chromium OS trees.  There are a whole slew of cleanup patches
> there, an addition of an LPC transport mode, and exports of functions
> to userspace.  Once these patches land and we have functionality we
> can continue to pick more cleanup patches.
> 
> Changes in v2:
> - Update tunnel binding as per swarren
> - Removed i2c20 alias for i2c tunnel
> 
> Bill Richardson (1):
>   mfd: cros_ec: Sync to the latest cros_ec_commands.h from EC sources
> 
> David Hendricks (1):
>   mfd: cros_ec: spi: calculate delay between transfers correctly
> 
> Doug Anderson (5):
>   mfd: cros_ec: spi: Add mutex to cros_ec_spi
>   mfd: cros_ec: spi: Make the cros_ec_spi timeout more reliable
>   mfd: cros_ec: spi: Increase cros_ec_spi deadline from 5ms to 100ms
>   i2c: ChromeOS EC tunnel driver
>   ARM: tegra: Add the EC i2c tunnel to tegra124-venice2
> 
>  .../devicetree/bindings/i2c/i2c-cros-ec-tunnel.txt |   39 +
>  arch/arm/boot/dts/tegra124-venice2.dts             |   26 +
>  drivers/i2c/busses/Kconfig                         |    9 +
>  drivers/i2c/busses/Makefile                        |    1 +
>  drivers/i2c/busses/i2c-cros-ec-tunnel.c            |  304 ++++++
>  drivers/mfd/cros_ec.c                              |    7 +-
>  drivers/mfd/cros_ec_spi.c                          |   67 +-
>  include/linux/mfd/cros_ec.h                        |    4 +-
>  include/linux/mfd/cros_ec_commands.h               | 1128 ++++++++++++++++++--
>  9 files changed, 1493 insertions(+), 92 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-cros-ec-tunnel.txt
>  create mode 100644 drivers/i2c/busses/i2c-cros-ec-tunnel.c

Need to wait for the ARM, DT and I2C guys to review, at which point
I'll be happy to take in and supply a branch for them to pull from if
required. If there are no _true_ dependencies and the MFD changes can
be added independently without fear of build breakages, let me know
and I'll apply them separately.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
