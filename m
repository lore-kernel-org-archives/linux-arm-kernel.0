From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Sep 2014 09:56:37 +0200
Subject: [PATCH v11 08/10] OF: PCI: Add support for parsing PCI host
 bridge resources from DT
In-Reply-To: <20140922114317.GN1994@e106497-lin.cambridge.arm.com>
References: <1411003825-21521-1-git-send-email-Liviu.Dudau@arm.com>
 <20140922093228.GA20256@rric.localhost>
 <20140922114317.GN1994@e106497-lin.cambridge.arm.com>
Message-ID: <8687285.EH4RPBeOB5@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 22 September 2014 12:43:17 Liviu Dudau wrote:
> > 
> > From e798af4fc2f664d1aff7e863489b8298f90e716e Mon Sep 17 00:00:00 2001
> > From: Robert Richter <rrichter@cavium.com>
> > Date: Mon, 22 Sep 2014 10:46:01 +0200
> > Subject: [PATCH] OF: PCI: Fix creation of mem-mapped pci host bridges
> > 
> > The pci host bridge was not created if io_base was not set when
> > calling of_pci_get_host_bridge_resources(). This is esp. the case for
> > mem-mapped io (IORESOURCE_MEM). This patch fixes this. Function
> > parameter io_base is optional now.
> 
> I think the message is misleading. What you want to do is make io_base
> optional for the case where the PCI host bridge only expects to have only
> IORESOURCE_MEM ranges and doesn't care about IORESOURCE_IO ones.
> 
> As I'm going to touch this area again to address a comment from Bjorn,
> do you mind if I roll this patch into mine with your Signed-off-by and
> the mention that you have made io_base optional?

I think the best way to deal with this is to move the check for 
io_base down into the place where it is used: As long as the DT only
specifies IORESOURCE_MEM windows, we don't need to look at io_base,
but if the host controller driver does not support IORESOURCE_IO
while the DT specifies it, I guess it would be nice to return an
error.

	Arnd
