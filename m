From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 Feb 2015 23:27:08 +0000
Subject: Regression: v4.0-rc1: iMX6: Hummingboard fails due to
 drivers/clk changes
In-Reply-To: <CAOesGMj2Ctq3yrWUrhWka=3uxKDA3r7CnDNeGdbxABPXSEZ9jg@mail.gmail.com>
References: <20150223223255.GQ8656@n2100.arm.linux.org.uk>
 <CAOesGMj2Ctq3yrWUrhWka=3uxKDA3r7CnDNeGdbxABPXSEZ9jg@mail.gmail.com>
Message-ID: <20150223232708.GR8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 23, 2015 at 02:54:02PM -0800, Olof Johansson wrote:
> On Mon, Feb 23, 2015 at 2:32 PM, Russell King - ARM Linux
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
> FWIW, my hummingboard comes up with networking on v4.0-rc1 with
> imx_v6_v7_defconfig and multi_v7:
> 
> http://arm-soc.lixom.net/bootlogs/mainline/v4.0-rc1/hummingboard-arm-imx_v6_v7_defconfig.html
> http://arm-soc.lixom.net/bootlogs/mainline/v4.0-rc1/hummingboard-arm-multi_v7_defconfig.html
> 
> Which is unfortunate, since it'd be easy for me to bisect. :(

Bisect comes out with this commit as the culpret:

commit 035a61c314eb3dab5bcc5683afaf4d412689858a
Author: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Date:   Fri Jan 23 12:03:30 2015 +0100

    clk: Make clk API return per-user struct clk instances

Indeed, having the tree merged with af0f349b2996 works, then
applying the above commit on top causes it to fail.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
