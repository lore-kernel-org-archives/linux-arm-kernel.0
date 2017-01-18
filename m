From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Wed, 18 Jan 2017 12:25:43 +0100
Subject: [PATCH 0/4] Bluetooth support for GXBB/GXL/GXM based devices
In-Reply-To: <20170115223255.10350-1-martin.blumenstingl@googlemail.com>
References: <20170115223255.10350-1-martin.blumenstingl@googlemail.com>
Message-ID: <CAFBinCC0RADEKnkYEF6_DkBTftdjmPMku+N3bdvZMCoqs96xGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin,

On Sun, Jan 15, 2017 at 11:32 PM, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
> This adds the missing kernel bits for Bluetooth support on the
> Tronsmart Vega S95 (GXBB based) boards as well as for the GXL
> P230/P231 and GXM Q200/Q201 reference boards.
>
> The Bluetooth functionality on these boards is provided by the
> SDIO wifi/Bluetooth combo-chip (Broadcom bcm43xx based). The
> Bluetooth module on that combo-chip has to be taken out of reset,
> which is taken care of the GPIO in the sdio_pwrseq.
>
> Once the module is taken out of reset it can be set up from userspace
> using the "hciattach" tool from bluez, which talks to the Bluetooth
> module which is connected to one of the serial ports (in our case
> uart_A). To get the Bluetooth module initialized within the timeout
> defined by "hciattach" (and to achieve usable speeds for Bluetooth
> transfers) the communication uses a speed of 2000000 baud, which was
> not supported by meson_uart before.
>
> NOTE: The .dts-changes from this series depends on my previous series
> "add support for uart_AO_B" - see [0]
>
>
> [0] http://lists.infradead.org/pipermail/linux-amlogic/2017-January/001982.html
>
>
> Martin Blumenstingl (4):
>   tty: serial: meson: allow baud-rates higher than 115200
>   ARM64: dts: meson-gx: add the serial CTS and RTS pin groups

Neil just informed me that Rob Herring is working on defining the UART
Bluetooth device properly using devicetree (preparation for this is
named "[PATCH v2 0/9] Serial slave device bus", see [0] for the
mailing-list conversation and [1] for a WiP git repo).
This means that there will be a better solution than the one proposed
in the meson-gx-p23x-q20x and meson-gxbb-vega-s95 patches (patches #1
and #2 are not affected by this), namely:
- I'm currently (ab)using sdio-pwrseq node to power on the UART
Bluetooth module, this can solved by specifying a bluetooth {  } node
inside the &uart_A node in the future and providing the corresponding
GPIOs there
- all the userspace commands will not be necessary once
drivers/bluetooth/hci_bcm.c is changed to the serio framework and gets
devicetree support
>   ARM64: dts: meson-gx-p23x-q20x: enable the Bluetooth module
>   ARM64: dts: meson-gxbb-vega-s95: enable the Bluetooth module
>
>  .../arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi | 12 ++++++-
>  .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi      |  9 +++++
>  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        | 40 ++++++++++++++++++++++
>  arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         | 40 ++++++++++++++++++++++
>  drivers/tty/serial/meson_uart.c                    |  2 +-
>  5 files changed, 101 insertions(+), 2 deletions(-)
>
> --
> 2.11.0
>


[0] http://marc.info/?l=linux-serial&m=148460728417109&w=2
[1] https://git.kernel.org/cgit/linux/kernel/git/robh/linux.git/log/?h=serial-bus-v3
