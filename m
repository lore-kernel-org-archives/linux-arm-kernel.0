From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 Feb 2015 23:53:50 +0000
Subject: Regression: v4.0-rc1: iMX6: Hummingboard fails due to
 drivers/clk changes
In-Reply-To: <CAOMZO5ASkXoVb9KrqF4Us18-rZ7k3XqjSdhcKyO_ParXXHoWbg@mail.gmail.com>
References: <20150223223255.GQ8656@n2100.arm.linux.org.uk>
 <CAOMZO5ASkXoVb9KrqF4Us18-rZ7k3XqjSdhcKyO_ParXXHoWbg@mail.gmail.com>
Message-ID: <20150223235350.GS8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 23, 2015 at 08:42:55PM -0300, Fabio Estevam wrote:
> Hi Russell,
> 
> On Mon, Feb 23, 2015 at 7:32 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > All,
> >
> > I just tried my SolidRun patch set on top of v4.0-rc1, and it fails to
> > boot.  The kernel itself finishes booting, but it is unable to DHCP (for
> > root-NFS) - nothing appears on the network.
> >
> > At first, I thought this would be a network driver bug, but reverting
> > the mainline changes there didn't fix the regression.  Then I wondered
> > if it was something in arch/arm/mach-imx, but no.
> >
> > When reverting all drivers/clk changes (and corresponding include/linux/*.h)
> > between v3.19 and v4.0-rc1, I find that the regression is fixed.
> >
> > It seems that some CCF change is causing a regression somewhere in the
> > clock tree on iMX6 CPUs.
> >
> > Unfortunately, without networking running, I can't dump the clock tree
> > to find out what's different, and bisecting will be a major pain (needing
> > each bisect point to be merged with my patch set, built and tested.)
> >
> > Has anyone else seen this?
> 
> Just tried it and I confirm that NFS fails to mount on a imx6q-hummingboard:
> 
> [    1.882023] fec 2188000.ethernet eth0: Freescale FEC PHY driver
> [Atheros 8035 ethernet] (mii_bus:phy_addr=2188000.ethernet:00, irq)
> [    1.894409] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
> [    1.954662] hub 2-1:1.0: USB hub found
> [    1.958864] hub 2-1:1.0: 4 ports detected
> [    3.882249] fec 2188000.ethernet eth0: Link is Up - 100Mbps/Full -
> flow control rx/tx
> [    3.890900] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
> [    3.912131] Sending DHCP requests ...
> 
> (Gets stuck here)
> 
> I haven't seen this problem on other imx6 boards though running the
> same kernel.

The reason appears to be a lack of packets coming out of the ethernet.
Why that is, I'm not sure (maybe a gated GPIO16 clock to the phy?)
Given that the phy state seems frozen - it doesn't detect the cable
being disconnected - this seems highly likely.

Looking at imx6q_1588_init(), this could be a problem:

        ptp_clk = of_clk_get(np, 2);
        enet_ref = clk_get_sys(NULL, "enet_ref");
        clksel = ptp_clk == enet_ref ? IMX6Q_GPR1_ENET_CLK_SEL_ANATOP :
                                       IMX6Q_GPR1_ENET_CLK_SEL_PAD;

since ptp_clk and enet_ref will _never_ be the same pointer.  Forcing
that test to be always true fixes the problem.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
