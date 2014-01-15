From: jagannadh.teki@gmail.com (Jagan Teki)
Date: Thu, 16 Jan 2014 00:45:21 +0530
Subject: [PATCH v4 0/7] mtd: spi-nor: add a new framework for SPI NOR
In-Reply-To: <1387950629-27448-1-git-send-email-b32955@freescale.com>
References: <1387950629-27448-1-git-send-email-b32955@freescale.com>
Message-ID: <CAD6G_RTnNQgeJM8Tc16Sc1_n29d=V9sJN1ePrOAn5YzM+GujMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Dec 25, 2013 at 11:20 AM, Huang Shijie <b32955@freescale.com> wrote:
> 1.) Why add a new framework for SPI NOR?
>   The SPI-NOR controller such as Freescale's Quadspi controller is working
>   in a different way from the SPI bus. It should knows the NOR commands to
>   find the right LUT sequence. Unfortunately, the current code can not meet
>   this requirement.
>
> 2.) How does this patch set do?
>    This patch set adds a new spi-nor layer.
>    Before this patch, the layer is like:
>
>                    MTD
>          ------------------------
>                   m25p80
>          ------------------------
>                spi bus driver
>          ------------------------
>                 SPI NOR chip
>
>    After this patch, the layer is like:
>                    MTD
>          ------------------------
>                   spi-nor
>          ------------------------
>                   m25p80
>          ------------------------
>                spi bus driver
>          ------------------------
>                SPI NOR chip
>
>   With the spi-nor controller driver(Freescale Quadspi), it looks like:
>                    MTD
>          ------------------------
>                   spi-nor
>          ------------------------
>                 fsl-quadspi
>          ------------------------
>                SPI NOR chip

I'm new to this thread, may be I'll ask basic questions.
1) what does m25p80 contains with your new framework - will excludes
quad stuff if they add
2) I didn't understand why the controller driver fsl-quadspi will be
in mtd becuase as it's (q)spi driver
may does flash or non-flash functionalities if ie, the case should be
part of drivers/spi/*
3) Can you explain your framework precisely take an example of like
spi_controller_A with spi_flash_A
and qspi_controller_B and qspi_flash_B - how will this new framework operates.

>
> 3.) more details
>     This patch set adds a new data structrue spi_nor{}, clones most the common
>   code to spi-nor.c. Add spi_nor_xfer_cfg {} for the fundamental primitives:
>   read_xfer/write_xfer.
>
>     Make the m25p80.c/fsl_quaspi.c use the new APIs.
>
> 4.) Change log:
> v3 --> v4:
>         [1] move the wait_till_ready to the @read hook.
>         [2] convert to linux-doc style comment.
>         [3] remove the some DT property for QuadSPI driver, such as
>             "fsl,nor-size".
>         [4] others
>
> v2 --> v3:
>         [1] add prepare/unprepare hooks for spi_nor{}.
>         [2] add a new "priv" field for spi_nor{}.
>         [3] add the Freescale Quadspi driver which supports the Quad read by
>              default.
>
> v1 --> v2:
>         [1] follow Angus's advice, add more hooks and data structrures.
>         [2] others.
>
>
> Huang Shijie (7):
>   mtd: spi-nor: copy the SPI NOR commands to a new header file
>   mtd: spi-nor: add the basic data structures
>   mtd: spi-nor: add the framework for SPI NOR
>   mtd: m25p80: use the SPI nor framework
>   mtd: spi-nor: add a helper to find the spi_device_id
>   Documentation: add the binding file for Freescale QuadSPI driver
>   mtd: spi-nor: Add Freescale QuadSPI driver
>
>  .../devicetree/bindings/mtd/fsl-quadspi.txt        |   26 +
>  drivers/mtd/Kconfig                                |    2 +
>  drivers/mtd/Makefile                               |    1 +
>  drivers/mtd/devices/Kconfig                        |    2 +-
>  drivers/mtd/devices/m25p80.c                       | 1275 ++------------------
>  drivers/mtd/spi-nor/Kconfig                        |   12 +
>  drivers/mtd/spi-nor/Makefile                       |    2 +
>  drivers/mtd/spi-nor/fsl-quadspi.c                  |  957 +++++++++++++++
>  drivers/mtd/spi-nor/spi-nor.c                      | 1093 +++++++++++++++++
>  include/linux/mtd/spi-nor.h                        |  194 +++
>  10 files changed, 2387 insertions(+), 1177 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mtd/fsl-quadspi.txt
>  create mode 100644 drivers/mtd/spi-nor/Kconfig
>  create mode 100644 drivers/mtd/spi-nor/Makefile
>  create mode 100644 drivers/mtd/spi-nor/fsl-quadspi.c
>  create mode 100644 drivers/mtd/spi-nor/spi-nor.c
>  create mode 100644 include/linux/mtd/spi-nor.h
>

-- 
Thanks,
Jagan.
