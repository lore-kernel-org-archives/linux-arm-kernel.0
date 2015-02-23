From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 23 Feb 2015 20:42:55 -0300
Subject: Regression: v4.0-rc1: iMX6: Hummingboard fails due to drivers/clk
 changes
In-Reply-To: <20150223223255.GQ8656@n2100.arm.linux.org.uk>
References: <20150223223255.GQ8656@n2100.arm.linux.org.uk>
Message-ID: <CAOMZO5ASkXoVb9KrqF4Us18-rZ7k3XqjSdhcKyO_ParXXHoWbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Mon, Feb 23, 2015 at 7:32 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> All,
>
> I just tried my SolidRun patch set on top of v4.0-rc1, and it fails to
> boot.  The kernel itself finishes booting, but it is unable to DHCP (for
> root-NFS) - nothing appears on the network.
>
> At first, I thought this would be a network driver bug, but reverting
> the mainline changes there didn't fix the regression.  Then I wondered
> if it was something in arch/arm/mach-imx, but no.
>
> When reverting all drivers/clk changes (and corresponding include/linux/*.h)
> between v3.19 and v4.0-rc1, I find that the regression is fixed.
>
> It seems that some CCF change is causing a regression somewhere in the
> clock tree on iMX6 CPUs.
>
> Unfortunately, without networking running, I can't dump the clock tree
> to find out what's different, and bisecting will be a major pain (needing
> each bisect point to be merged with my patch set, built and tested.)
>
> Has anyone else seen this?

Just tried it and I confirm that NFS fails to mount on a imx6q-hummingboard:

[    1.882023] fec 2188000.ethernet eth0: Freescale FEC PHY driver
[Atheros 8035 ethernet] (mii_bus:phy_addr=2188000.ethernet:00, irq)
[    1.894409] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[    1.954662] hub 2-1:1.0: USB hub found
[    1.958864] hub 2-1:1.0: 4 ports detected
[    3.882249] fec 2188000.ethernet eth0: Link is Up - 100Mbps/Full -
flow control rx/tx
[    3.890900] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[    3.912131] Sending DHCP requests ...

(Gets stuck here)

I haven't seen this problem on other imx6 boards though running the same kernel.

Regards,

Fabio Estevam
