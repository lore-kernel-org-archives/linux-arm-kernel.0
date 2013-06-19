From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 19 Jun 2013 14:58:24 -0300
Subject: [PATCH v3 05/12] ARM: mvebu: Remove the harcoded BootROM window
 allocation
In-Reply-To: <20130619165834.GB32155@obsidianresearch.com>
References: <1371554737-25319-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1371554737-25319-6-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130618173906.GC2204@obsidianresearch.com>
 <20130619100159.GB16138@localhost>
 <20130619165834.GB32155@obsidianresearch.com>
Message-ID: <20130619175823.GB2324@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 19, 2013 at 10:58:34AM -0600, Jason Gunthorpe wrote:
> On Wed, Jun 19, 2013 at 07:02:00AM -0300, Ezequiel Garcia wrote:
> 
> > > Verifying the DT is setup this way and aborting if it is not seems
> > > like a good idea..
> > 
> > I agree it's a nice idea, but I'm not too sure how to accomplish this
> > in a simple and generic way. There's nothing in the DT that allows you
> > to know which of the ranges entries correspond to the BootROM, unless you go
> > through each of the entries comparing against the known target ID and
> > attribute.
> 
> I think you need to have a defined compatible string for the bootrom,
> use one of the of_find.. functions to locate the node, then translate
> the regs to get a CPU address, ensure it is the right base and size..
> 

I wasn't sure you wanted to panic(), to clip on available CPUs,
or to just do a pr_warn / WARN(), so here's a piece of code:
(disclaimer: non-tested, non-compiled, etc.)

	/*
	 * In order to boot the secondary CPUs we need to ensure
	 * the bootROM is mapped at the correct address.
	 */
	node = of_find_compatible_node(NULL, NULL, "bootrom");
	if (!node) {
		pr_warn("No 'bootrom' node found");
		return;
	}

	err = of_address_to_resource(node, 0, &res);
	if (err < 0) {
		pr_warn("Cannot get 'bootrom' node address");
		return;
	}

	if (res.start != AXP_BOOTROM_BASE||
	    resource_size(&res) != AXP_BOOTROM_SIZE) {
		pr_warn("bootrom address is incorrect");
		return;
	}

How does it look?

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
