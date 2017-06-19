From: maitysanchayan@gmail.com (Sanchayan)
Date: Mon, 19 Jun 2017 10:43:38 +0530
Subject: [RFC PATCH 0/3] provide imx rproc driver
In-Reply-To: <20170614204855.18347-1-o.rempel@pengutronix.de>
References: <20170614204855.18347-1-o.rempel@pengutronix.de>
Message-ID: <20170619051338.GA3064@Sanchayan-Arch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Oleksij,

On 17-06-14 22:48:52, Oleksij Rempel wrote:
> Hallo all,
> 
> this is RFC patchset to provide remoteproc functionality on
> imx7d SoC.
> Since current kernel do not have devicetrees for board which
> I used for testing, this RFC patchset includes this too.
> 
> For testing I used this simple counter written in ASM:
> ======================================
>         .syntax unified
>         .text
>         .thumb
>         .int 0x10020000                 @ Initial SP value
>         .int reset + 1
> 
> reset:
> 
>         mov     r0, #0x55
>         ldr     r1, =(0x40)
> 1:
>         str     r0, [r1]
>         add     r0, 1
>         b       1b
> 
>         /* Dummy data, required by remoteproc loader */
>         /* Please FIXME, this part seem to be incorrect */
>         .data
>         .section .resource_table, "aw"
>         .word   1, 0, 0, 0      /* struct resource_table base */
>         .word   0               /* uint32_t offset[1] */
> ============================================================
> compiled with:
> ${CROSS}as -o imx7m4.o imx7m4.S
> ${CROSS}ld -Ttext=0x0 -o imx7m4.elf imx7m4.o
> cp imx7m4.elf /srv/nfs/sid-armhf/lib/firmware/rproc-imx_rproc-fw
> 
> Functionality was confirmed with current OpenOCD master.
> OpenOCD cfg file can be found here:
> https://github.com/olerem/openocd/blob/imx7-2017.06.14/tcl/target/imx7.cfg
> 
> Comment and suggestions are welcome.

Have you by chance also tried testing this with FreeRTOS code running on the
M4 side?

Regards,
Sanchayan.

> 
> Regards,
> Oleksij
> 
> Oleksij Rempel (3):
>   ARM: dts: imx7d: add imx7d-phyboard-zeta
>   remoteproc: imx_rproc: add a NXP/Freescale imx rproc driver
>   ARM: dts: imx7s: add rproc node
> 
>  arch/arm/boot/dts/Makefile                |   1 +
>  arch/arm/boot/dts/imx7d-pba-c-09.dtsi     | 272 ++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/imx7d-peb-av-02.dtsi    | 104 ++++++++++++
>  arch/arm/boot/dts/imx7d-peb-eval-02.dtsi  | 130 ++++++++++++++
>  arch/arm/boot/dts/imx7d-phyboard-zeta.dts | 144 ++++++++++++++++
>  arch/arm/boot/dts/imx7d-phycore-som.dtsi  | 272 ++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/imx7d-pinfunc-lpsr.h    |  76 +++++++++
>  arch/arm/boot/dts/imx7s.dtsi              |   9 +
>  drivers/remoteproc/Kconfig                |   8 +
>  drivers/remoteproc/Makefile               |   1 +
>  drivers/remoteproc/imx_rproc.c            | 264 +++++++++++++++++++++++++++++
>  11 files changed, 1281 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx7d-pba-c-09.dtsi
>  create mode 100644 arch/arm/boot/dts/imx7d-peb-av-02.dtsi
>  create mode 100644 arch/arm/boot/dts/imx7d-peb-eval-02.dtsi
>  create mode 100644 arch/arm/boot/dts/imx7d-phyboard-zeta.dts
>  create mode 100644 arch/arm/boot/dts/imx7d-phycore-som.dtsi
>  create mode 100644 arch/arm/boot/dts/imx7d-pinfunc-lpsr.h
>  create mode 100644 drivers/remoteproc/imx_rproc.c
> 
> -- 
> 2.11.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-remoteproc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
