From: tharvey@gateworks.com (Tim Harvey)
Date: Mon, 28 Aug 2017 09:59:34 -0700
Subject: [PATCH 0/3] DWC host without MSI controller
In-Reply-To: <20170828142307.30061-1-l.stach@pengutronix.de>
References: <20170828142307.30061-1-l.stach@pengutronix.de>
Message-ID: <CAJ+vNU1GZMpptQ2oCE-cOzX+G=cj248bVGXhC_vSqD_4d7D7+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 28, 2017 at 7:23 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> Hi all,
>
> this small series tries to fix/workaround a serious design flaw of the DWC PCIe
> host controller: it is unable to work with both legacy and MSI IRQs enabled at
> the same time. As soon as the first MSI is enabled in the DWC MSI controller,
> the host stops forwarding legacy IRQs.
>
> If the MSI controller is present, MSIs will be used for the PCIe port services
> IRQs, leaving endpoint devices which don't support MSIs unable to raise IRQs.
> It is only safe to enable the MSI controller if it is validated that all PCIe
> devices and drivers in the system support working MSIs. As most devices
> support falling back to using legacy PCIe IRQs if MSI support is missing it is
> much safer to disable the MSI by default and only enable it on validated
> systems.
>
> Feedback welcome.
>
> Regards,
> Lucas
>
> Lucas Stach (3):
>   PCI: designware: only register MSI controller when MSI irq line is
>     valid
>   PCI: imx6: allow MSI irq to be absent
>   ARM: dts: imx6qdl: remove MSI irq line
>
>  .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |  8 ++++----
>  arch/arm/boot/dts/imx6qdl.dtsi                     |  2 --
>  drivers/pci/dwc/pci-imx6.c                         | 23 +++++++++++-----------
>  drivers/pci/dwc/pcie-designware-host.c             |  4 ++--
>  4 files changed, 17 insertions(+), 20 deletions(-)
>

Lucas,

Thank you for following up on this!

I tested it with and without the third patch that removes msi from the
dt thus with both an ath9k 802.11 device which only supports legacy
interrupts and a Marvell sky2 device which supports msi as well as
legacy interrupts and it works as expected:
 - without msi enabled in dts (default): both sky2 and ath9k work
 - with msi enabled in dt: sky2 works ath9k does not

Tested-by: Tim Harvey <tharvey@gateworks.com>

Regards,

Tim
