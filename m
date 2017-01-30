From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 30 Jan 2017 20:47:38 +0100
Subject: [PATCH v2] ARM: dts: imx: Pass 'chosen' and 'memory' nodes
In-Reply-To: <20170130185444.GF27312@n2100.armlinux.org.uk>
References: <1484834566-19845-1-git-send-email-fabio.estevam@nxp.com>
 <20170119141335.kpbrbpbwaovnijjv@pengutronix.de>
 <CAOMZO5AdgM9eFnerLRdYxwE7gsOE5OvkWs6rCR4zta1XmXHj1A@mail.gmail.com>
 <20170119144641.jxj2bqg5uqjol23x@pengutronix.de>
 <20170119145642.GC27312@n2100.armlinux.org.uk>
 <20170119161441.jcctgig7np4v7sam@pengutronix.de>
 <588914F3.7050909@gmail.com>
 <20170130185444.GF27312@n2100.armlinux.org.uk>
Message-ID: <20170130194738.edzou2mgvcoegucx@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Jan 30, 2017 at 06:54:44PM +0000, Russell King - ARM Linux wrote:
> On Wed, Jan 25, 2017 at 01:13:23PM -0800, Frank Rowand wrote:
> > Adding back the chosen nodes is a bandaid that papers over the actual bug
> > in the decompressor.
> > 
> > A comment about Fabio's attempt to fix the decompressor noted a possible
> > issue with the method taken to fix the problem, but then the discussion
> > of fixing the decompressor was dropped and v3 of the patch to add chosen
> > into a bunch of .dtsi files was applied by Shawn.
> > 
> > Can someone please help Fabio to create a correct patch to fix the
> > decompressor?
> 
> I refuse to assist, see below.
> 
> The reason this has come up is that this problem has _nothing_ to do
> with the decompressor - see recent context on the linux-arm-kernel
> list.

Several people reported problems with the patch that removes
skeleton.dtsi. There are at least:

 - Russell, who saw U-Boot failing to specify the amount of RAM;
 - somebody (I forgot and I'm lazy so I didn't look up the name) who
   noticed some i.MX6 boards fail in kernelci with barebox because
   barebox assumed /chosen to be present; and
 - somebody else (...) who reported the ATAGS_DTB_COMPAT failure
   (also wrongly called "decompressor failure" in this thread).

I agree that for each single of the above issues it is worth to readd
the /chosen and /memory nodes for now. Still all three are IMHO worth to
be fixed.

barebox is already fixed in v2017.01.0 (commit f49b415b9231 (of: base:
add chosen node if it does not exist when adding initrd),
https://git.pengutronix.de/cgit/barebox/commit/?id=f49b415b9231).

Looking at the ATAGS_DTB_COMPAT problem: The code in question is
(if I understood correctly) merge_fdt_bootargs in
arch/arm/boot/compressed/atags_to_fdt.c:

	setprop_string(fdt, "/chosen", "bootargs", cmdline);

looking further:

	static int node_offset(void *fdt, const char *node_path)
	{       
		int offset = fdt_path_offset(fdt, node_path);
		if (offset == -FDT_ERR_NOTFOUND)
			offset = fdt_add_subnode(fdt, 0, node_path);
		return offset;
	}

	static int setprop_string(void *fdt, const char *node_path,
				  const char *property, const char *string)
	{
		int offset = node_offset(fdt, node_path);
		if (offset < 0)
			return offset;
		return fdt_setprop_string(fdt, offset, property, string);
	}

So it seems "/chosen" not being there should be handled. I don't have a
reproducer for this problem, but it doesn't look that hard to fix with
DEBUG_LL and a system that shows the problem.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
