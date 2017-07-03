From: adriana.reus@nxp.com (Adriana Reus)
Date: Mon,  3 Jul 2017 17:28:01 +0300
Subject: [RFC 0/2] clk: imx7d: Uart clock set-up conflict if clk needs gating
 on set rate or re-parent
Message-ID: <1499092083-2852-1-git-send-email-adriana.reus@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I am currently trying to fix an issue occurring when trying to set the
CLK_SET_RATE_GATE flag for the uart root clks. This causes the imx serial
driver to fail when setting up devicetree specified frequency or parent because
the uart clk is already in use by the ccm driver that starts up all uart clocks
for earlycon.

Some context:

There are three main types of clock slices on imx7d ccm: "Core clock slice",
"Bus clock slice (AXI/AHB)", and "Peripheral clock slice". Vast majority of
clock roots fall in the peripheral slice category:

    8:1 mux -> gate -> div -> div -> gate

The root clocks that derive from peripheral slices are expected to be
gated when changing frequency [0].

The first patch of this series sets this up. (It is only a reference point for
this conversation, not to be merged as it WIP and needs more testing).

When setting this up, the imx serial driver
(platform_driver_register -> of_clk_set_defaults) will fail
to set the rate or parent specified in the devicetree:

    imx-uart 30a70000.serial: clk_set_rate() failed
    imx-uart: probe of 30a70000.serial failed with error -16

The reason for this is that the uart clks are already prepared and enabled in
imx7d_clocks_init by the imx_register_uart_clocks function if earlycon is
enabled. Functionality added in patches:
'commit 55adc61c568af99419be1dc0412f8eae019c71f2
("clk: imx: add common logic to detect early UART usage")'
'commit 1b9af68f325cb91ac9fc691f52d69dfb0826afd7
("clk: imx7d: retain early UART clocks during kernel init")'

One option is to remove the imx_register_uart_clocks from the ccm driver and
leave the uart clock set up and enable entirely to the serial driver and DT.
The second RFC patch does this for imx7d.
That would mean that we would rely on the bootloader to enable these clocks for
earlycon. This is what other platforms seem to do, so it seems like
a reasonable asumption that the bootloader would set it up (on my tested
u-boot + imx7d setup, it works).
The topic was also briefly addressed in this thread [1] and as it is stated by
Lucas Stach in the thread, earlycon must work before the clock driver is
initialized anyway.

If it is agreed that it's best to remove it I can add a patch to remove it from
all imx platforms, otherwise I am open to any other alternatives.

Any feedback is apreciated and thanks for reading thus far.

[0]: http://www.nxp.com/docs/en/reference-manual/IMX7DRM.pdf
Relevant sections:  5.2.4; 5.1.3.5.3; 5.2.6.4 [5.2.6.4.3]
[1]: https://patchwork.kernel.org/patch/8979421/

Adriana Reus (2):
  clk: imx: Add CLK_SET_RATE_GATE for imx7d clocks
  clk: imx: Remove enabling uart clocks from ccm driver.

 drivers/clk/imx/clk-imx7d.c | 32 +++++++++++---------------------
 drivers/clk/imx/clk.h       | 18 +++++++++++++-----
 2 files changed, 24 insertions(+), 26 deletions(-)

-- 
2.7.4
