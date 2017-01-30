From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 30 Jan 2017 10:36:28 +0100
Subject: mvneta MDIO problems
In-Reply-To: <1485351412.5441.82.camel@beck.ac>
References: <1485351412.5441.82.camel@beck.ac>
Message-ID: <20170130103628.09178f50@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Thanks for your report. I'm adding a number of people in Cc, as well as
the Linux ARM kernel mailing list. I'll keep your entire e-mail below
so that everyone can get the context.

On Wed, 25 Jan 2017 14:36:52 +0100, Jasmin Beck wrote:

> for quite a while now (kernel 4.1 or previously?) I observe link state
> problems with mvneta on the marvell mirabox; possibly there is a bug in
> mvneta/mdio driver.

Is there a kernel version where this problem does not exist? I.e is it
a regression or an issue that always existed?

> After some days (1-20 ?) uptime, the kernel 4.8.11 logs:
> 
> [779752.514644] mvneta d0070000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
> [783518.193094] mvneta d0070000.ethernet eth0: Link is Down
> [783519.229922] mvneta d0070000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
> [789431.374474] mvneta d0070000.ethernet eth0: Link is Down
> [804522.151348] mvneta d0070000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
> [804530.474111] mvneta d0070000.ethernet eth0: Link is Down
> [804532.550916] mvneta d0070000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
> [806254.718708] mvneta d0070000.ethernet eth0: Link is Down
> 
> ... so sooner or later, the link stays down (let's call this "failed state")
> 
> When removing the mvneta-module and modprobe mvneta, it does not help.
> The only thing, that helps, is a reboot. Then it works again for some days.

mvneta is not in charge of the MDIO bus, there's a separate mvmdio
driver. Though it doesn't do anything in terms of HW initialization, so
I don't expect unloading/reloading this module to have any effect.

> This happens on multiple units of the mirabox, using various switches.
> 
> When trying to set the link up when the box is in "failed state" with
> "ip link set dev eth1 up":
> 
> [824259.058531] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
> [824281.522114] mvneta d0074000.ethernet eth1: could not find the PHY
> [824281.528361] mvneta d0074000.ethernet eth1: cannot probe MDIO bus

So it looks as if the PHY isn't responding anymore. Are you
experiencing this on both network interfaces? Only one specifically?

> I have no idea on how to debug this... the system is currently in
> "failed state", kernel source and compiler are available on the box
> (e.g. for unloading, modifying, compiling and loading mvneta.ko again),
> which is currently "offline", but can be accessed through the serial
> console.
> 
> As you are the maintainer of the driver according to mvneta.c, I
> thought this could be relevant for you.
> 
> If you are interested in taking a look at the situation in "failed
> state", I can immediately provide ssh access to the serial console
> (though your ssh public key is needed in this case).

I don't think we ever had similar reports. I'm not personally leaving
the Mirabox running for extended periods of time, so I've never seen
this issue. We do have the Mirabox tested as part of kernelci.org, but
it gets rebooted for every test, so we don't see this sort of issue.

Jason, Andrew, maybe you are running Mirabox boards for extended periods
of time? If so, have you seen a similar problem?

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
