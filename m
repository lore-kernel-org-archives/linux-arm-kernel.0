From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 6 Feb 2017 17:38:25 -0200
Subject: [PATCH] serial: imx: Only enable UART DMA on i.MX6Q and i.MX53
In-Reply-To: <e7f91dac-03a0-d6d1-5b12-cafcc45314f1@denx.de>
References: <20170204213931.3566-1-marex@denx.de>
 <DB6PR0402MB2743C709F162BDE52429DF49E3410@DB6PR0402MB2743.eurprd04.prod.outlook.com>
 <CAOMZO5D8_vE+t=V6wHMKt590jZqJJRzeJ+_MLgqbLp=6gwsmyQ@mail.gmail.com>
 <e7f91dac-03a0-d6d1-5b12-cafcc45314f1@denx.de>
Message-ID: <CAOMZO5AkbtWn65p6mj=7AxCh3-v18XPuRqR07NHCSiQY82QG=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Mon, Feb 6, 2017 at 5:05 PM, Marek Vasut <marex@denx.de> wrote:

> Well yes, DMA is broken in 4.9 , that's why it's CC stable 4.9+ :)

This patch is based on the fact that the UART on the imx6sx is not of
a imx6q UART type, which is not correct.

Current imx6sx.dtsi misses to add a "fsl,imx6q-uart" compatible
string, just like all other imx6 SoC dtsi.

When we fix the compatible uart problem on imx6sx.dtsi, then DMA will
be enabled and things will break again.

That's why we need a better fix for this issue:

1) Let's see if Clemens' suggestion of using the latest SDMA firmware
can make DMA robust on  your usecase.

2) If the system fails even with the latest SDMA, then the board dts
can disable dma by passing empty dma nodes.

Not all mx6 system seem to suffer from such SDMA problem. On a
imx6sx-udoo-neo we could use UART with DMA to connect to the Bluetooth
chip.

Thanks
