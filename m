From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 12 Jun 2013 12:14:41 +0100
Subject: [PATCH 04/14] bus: mvebu-mbus: Add static window allocation to
 the DT binding
In-Reply-To: <4160363.LWJuHATm2F@wuerfel>
References: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20835253.Agl4DfuI3k@wuerfel> <20130611215023.GA12649@obsidianresearch.com>
 <4160363.LWJuHATm2F@wuerfel>
Message-ID: <20130612111441.E6D603E0A56@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 12 Jun 2013 00:34:14 +0200, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 11 June 2013 15:50:23 Jason Gunthorpe wrote:
> > So, I think we can/have agree that the ranges in the FDT should
> > reflect the bootloader's settings, and if the ranges is missing an
> > element it means the bootloader didn't set it up.
> > 
> > A compatible bootloader should dump the entire mbus register table
> > into the ranges. The address encoding is such that we can represent
> > every mbus window entry in ranges. If no bootloader support is present
> > then the ranges value is forced into the mbus windows anyhow.
> > 
> > If there isn't a ranges entry, but there is a child that requires it
> > (how do we figure this out?)
> 
> I think we have to walk the entire tree of devices underneath mbus,
> at least any device node that has a 'reg' property, following children
> of any device node with a 'ranges' property. We might need to
> add a variant of of_get_address() that does a partial translation
> up to a given node (the mbus) instead of all the way to the root.

I think we should have almost everything needed already to do this.
of_bus allows arbitrary mapping code to be used at any stage in the
translation. We might need to add some glue so that of_busses[] can
be assembled by the linker to allow an mbus of_bus stanza to live
outside of drivers/of/address.c
