From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 19 Feb 2016 15:57:28 +0000
Subject: [PATCH v3] irqchip: irq-mvebu-odmi: new driver for platform MSI
 on Marvell 7K/8K
In-Reply-To: <1455888883-5127-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1455888883-5127-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20160219155728.GD958@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 19, 2016 at 02:34:43PM +0100, Thomas Petazzoni wrote:
> This commits adds a new irqchip driver that handles the ODMI
> controller found on Marvell 7K/8K processors. The ODMI controller
> provide MSI interrupt functionality to on-board peripherals, much like
> the GIC-v2m.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
> Changes v2 -> v2:
>  - Express NODMIS_SHIFT, NODMIS_PER_FRAME, NODMIS_MASK in term of each
>    other. Suggested by Marc Zyngier.
>  - Rework the global bitmask allocation to make sure we allocate a
>    number of longs rather than a number of bytes, to avoid having the
>    bitmap API (which operates on longs) access memory we haven't
>    explicitly allocated. Reported by Marc Zyngier.
> 
> Changes v1 -> v2:
>  - Better commit title, as suggested by Marc Zyngier.
>  - Improve the DT binding documentation, as suggested by Marc Zingier:
>    add a reference to the GIC documentation, be more specific about
>    the marvell,spi-base values, and add the requirement of the
>    interrupt-parent property.
>  - As suggested by Marc Zyngier, use a single global bitmap to
>    allocate all ODMIs, regardless of the frame they belong to. As part
>    of this change, the hwirq used to identify the interrupt inside the
>    ODMI irqdomain are 0-based (instead of being based on their
>    corresponding SPI base value), which allows to significantly
>    simplify the allocation/free logic.
> ---
>  .../marvell,odmi-controller.txt                    |  41 ++++
>  drivers/irqchip/Kconfig                            |   4 +
>  drivers/irqchip/Makefile                           |   1 +
>  drivers/irqchip/irq-mvebu-odmi.c                   | 248 +++++++++++++++++++++
>  4 files changed, 294 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/marvell,odmi-controller.txt
>  create mode 100644 drivers/irqchip/irq-mvebu-odmi.c

Applied to irqchip/mvebu with Marc's Reviewed-by.

thx,

Jason.
