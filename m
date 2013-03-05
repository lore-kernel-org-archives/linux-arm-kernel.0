From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Tue, 5 Mar 2013 12:04:28 -0800
Subject: RFC: Zynq Clock Controller
Message-ID: <37032699-343e-485c-80e0-9b23e3706c58@VA3EHSMHS013.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

As you know, I'm reviewing Zynq's clock implementation and try to find a way to go forward. It looks like most archs contain all clocks within a clock controller block which provides all the output clocks which are then used by device drivers etc. E.g. the Tegra CAR.

I do also see some benefits of this approach:
 - The DT description should never change even when the clock tree and/or functionality within the controller changes (assuming all required outputs are present)
 - the controller can handle more sophisticated clock operations, which go beyond the simple enable/disable the device drivers are doing

For this reasons, I'd like to propose moving Zynq into the same direction. I.e. adding a clock controller with the following DT description (details may change but the general idea should become clear):
	clkc: clkc {
                #clock-cells = <1>;
                compatible = "xlnx,ps7-clkc";
                ps_clk_frequency = <33333333>;	# board x-tal
                # optional props
                gem0_emio_clk_freq = <125000000>;
                gem1_emio_clk_freq = <50000000>;
                can_mio_clk_freq_xx = <1234>; # this is possible 54 times with xx = 00..53
        };

For the PLLs we can use Josh's implementation and extend it where needed. For everything else we can then use the clock primitives instead of using custom implementations, I think. The node should be a subnode to Zynq's SLCR.

Currently I have identified the following output clocks:
        armpll, ddrpll, iopll,
        cpu_6or4x, cpu_3or2x, cpu_2x, cpu_1x,
        ddr2x, ddr3x, dci,
        lqspi, smc, pcap, gem0, gem1, fclk0, fclk1, fclk2, fclk3, can0, can1,
        sdio0, sdio1, uart0, uart1, spi0, spi1,
        dma_aper, usb0_aper, usb1_aper, gem0_aper, gem1_aper,
        sdio0_aper, sdio1_aper, spi0_aper, spi1_aper, can0_aper, can1_aper,
        i2c0_aper, i2c1_aper, uart0_aper, uart1_aper, gpio_aper, lqspi_aper,
        smc_aper


Clock consumers would work as described in the clock bindings:
	consumer: zynq_dummy_peripheral {
	        compatible = "xlnx,foobar";
	        clocks = <&clkc 69>;
	};


Is this an acceptable solution? Does anybody see issues or has other feedback?

	Thanks,
	S?ren
