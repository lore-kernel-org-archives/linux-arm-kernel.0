From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 30 Jan 2017 18:54:44 +0000
Subject: [PATCH v2] ARM: dts: imx: Pass 'chosen' and 'memory' nodes
In-Reply-To: <588914F3.7050909@gmail.com>
References: <1484834566-19845-1-git-send-email-fabio.estevam@nxp.com>
 <20170119141335.kpbrbpbwaovnijjv@pengutronix.de>
 <CAOMZO5AdgM9eFnerLRdYxwE7gsOE5OvkWs6rCR4zta1XmXHj1A@mail.gmail.com>
 <20170119144641.jxj2bqg5uqjol23x@pengutronix.de>
 <20170119145642.GC27312@n2100.armlinux.org.uk>
 <20170119161441.jcctgig7np4v7sam@pengutronix.de>
 <588914F3.7050909@gmail.com>
Message-ID: <20170130185444.GF27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 25, 2017 at 01:13:23PM -0800, Frank Rowand wrote:
> Adding back the chosen nodes is a bandaid that papers over the actual bug
> in the decompressor.
> 
> A comment about Fabio's attempt to fix the decompressor noted a possible
> issue with the method taken to fix the problem, but then the discussion
> of fixing the decompressor was dropped and v3 of the patch to add chosen
> into a bunch of .dtsi files was applied by Shawn.
> 
> Can someone please help Fabio to create a correct patch to fix the
> decompressor?

I refuse to assist, see below.

The reason this has come up is that this problem has _nothing_ to do
with the decompressor - see recent context on the linux-arm-kernel
list.

The removal of skeleton.dtsi from iMX6 DTS files has caused a
regression in the current -rc kernels when an iMX6 board is booted
with uboot using a _separated_ device tree file.

In that situation, the decompressor has _nothing_ at all to do with
modifying the DT binary file.  The DT binary file ends up being passed
to the kernel from the boot loader unmodified by the decompressor.
Remember that the decompressor's modification of the *appended* DT
file is a band-aid to allow an *ATAG* based system to continue working.
That doesn't apply to iMX6.

The lack of the memory node means that uboot fails to add a memory node
to the DT binary file before passing control to the decompressor, which
in turn causes the kernel to be booted with a DT binary file which says
that the system has no memory.  That causes the kernel to crash in the
very early stages of boot, before the console is up and running.  So
it's a nasty silent crash.

So, while it may be desirable to fix the decompressor, it's completely
pointless as far as whether Fabio's patch gets merged, because this
_regression_ has nothing to do with the decompressor.

We need this regression fixed before 4.10 comes out so systems don't
break when 4.10 comes out.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
