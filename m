From: josh.coombs@gmail.com (Josh Coombs)
Date: Tue, 14 Aug 2012 19:59:00 -0400
Subject: Potential Regression in 3.6-rc1 - Kirkwood SATA
Message-ID: <CAMW5UfZ_kVz_b4_98zPdY2RFjTMN9H2OzjYcRQrCTgA1xqdmPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I finally got a chance to test 3.6-rc1 after having my GoFlex Net
support patch accepted for the 3.6 release train.  Included in 3.6-rc1
was an update for Kirkwoods switching SATA to DT which was not part of
my original testing.  It seems something with this change has
partially broken the GoFlex and a couple other Kirkwood based devices.

The key factor is the number of SATA ports defined in the dts:

		sata at 80000 {
			status = "okay";
			nr-ports = <2>;
		};

If set at the correct number for my device, 2, my GFN does not
complete kernel init, hanging here:

<SNIP>
[   15.287832] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[   15.296545] jffs2: version 2.2. (NAND) ?? 2001-2006 Red Hat, Inc.
[   15.303202] msgmni has been set to 240
[   15.308503] Block layer SCSI generic (bsg) driver version 0.4 loaded (major )
[   15.316021] io scheduler noop registered
[   15.320149] io scheduler deadline registered
[   15.324558] io scheduler cfq registered (default)
[   15.329462] mv_xor_shared mv_xor_shared.0: Marvell shared XOR driver
[   15.335962] mv_xor_shared mv_xor_shared.1: Marvell shared XOR driver
[   15.376751] mv_xor mv_xor.0: Marvell XOR: ( xor cpy )
[   15.416736] mv_xor mv_xor.1: Marvell XOR: ( xor fill cpy )
[   15.456735] mv_xor mv_xor.2: Marvell XOR: ( xor cpy )
[   15.496734] mv_xor mv_xor.3: Marvell XOR: ( xor fill cpy )
[   15.506309] Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
[   15.509111] serial8250.0: ttyS0 at MMIO 0xf1012000 (irq = 33) is a 16550A
[   15.509141] console [ttyS0] enabled, bootconsole disabled
[   15.518967] brd: module loaded
[   15.524991] loop: module loaded
[   15.528584] sata_mv sata_mv.0: cannot get optional clkdev
[   15.534180] sata_mv sata_mv.0: slots 32 ports 2

If you set nr-ports to 1 the unit boots cleanly, save for only
detecting one functional SATA port.  Another user has confirmed this
behavior on an Iomega IX2-200.

I bounced this off Andrew before bringing it to the list proper.  His
initial hunch puts the culprit in or around:


#if defined(CONFIG_HAVE_CLK)
        hpriv->clk = clk_get(&pdev->dev, NULL);
        if (IS_ERR(hpriv->clk))
                dev_notice(&pdev->dev, "cannot get optional clkdev\n");
        else
                clk_prepare_enable(hpriv->clk);

        for (port = 0; port < n_ports; port++) {
                char port_number[16];
                sprintf(port_number, "%d", port);
                hpriv->port_clks[port] = clk_get(&pdev->dev, port_number);
                if (!IS_ERR(hpriv->port_clks[port]))
                        clk_prepare_enable(hpriv->port_clks[port]);
        }
#endif

I haven't had a chance to play with this yet to see if I can figure it
out, something about having the second port enabled seems to be
mucking with the clocks on Kirkwoods.

Joshua Coombs
