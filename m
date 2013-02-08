From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 08 Feb 2013 21:34:40 +0000
Subject: [PATCH] cpuidle: kirkwood: Move out of mach directory, add DT.
In-Reply-To: <1356698844-4220-1-git-send-email-andrew@lunn.ch>
References: <1356698844-4220-1-git-send-email-andrew@lunn.ch>
Message-ID: <20130208213441.014343E2C27@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 28 Dec 2012 13:47:24 +0100, Andrew Lunn <andrew@lunn.ch> wrote:
> Move the Kirkwood cpuidle driver out of arch/arm/mach-kirkwood and
> into drivers/cpuidle. Convert the driver into a platform driver and
> add a device tree binding. Add a DT node to instantiate the driver for
> boards converted to DT, and a platform data for old style boards.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  .../devicetree/bindings/power/qnap-poweroff.txt    |   14 +++
>  arch/arm/boot/dts/kirkwood.dtsi                    |    5 +
>  arch/arm/configs/kirkwood_defconfig                |    1 +
>  arch/arm/mach-kirkwood/Makefile                    |    1 -
>  arch/arm/mach-kirkwood/common.c                    |   23 ++++
>  arch/arm/mach-kirkwood/cpuidle.c                   |   73 -------------
>  arch/arm/mach-kirkwood/include/mach/kirkwood.h     |    3 +-
>  drivers/cpuidle/Kconfig                            |    6 ++
>  drivers/cpuidle/Makefile                           |    1 +
>  drivers/cpuidle/cpuidle-kirkwood.c                 |  114 ++++++++++++++++++++
>  10 files changed, 166 insertions(+), 75 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/qnap-poweroff.txt
>  delete mode 100644 arch/arm/mach-kirkwood/cpuidle.c
>  create mode 100644 drivers/cpuidle/cpuidle-kirkwood.c
> 
> diff --git a/Documentation/devicetree/bindings/power/qnap-poweroff.txt b/Documentation/devicetree/bindings/power/qnap-poweroff.txt
> new file mode 100644
> index 0000000..e15a334
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/qnap-poweroff.txt
> @@ -0,0 +1,14 @@
> +* QNAP Power Off
> +
> +QNAP NAS devices have a microcontroller controlling the main power
> +supply. This microcontroller is connected to UART1 of the Kirkwood and
> +Orion5x SoCs. Sending the charactor 'A', at 19200 baud, tells the
> +microcontroller to turn the power off. This driver adds a handler to
> +pm_power_off which is called to turn the power off.
> +
> +Required Properties:
> +- compatibile: Should be "qnap,power-off"

It would do well to have the model number embedded into this compatible
string since it is unlikely that every single QNAP device will use the
same controller interface.

g.
