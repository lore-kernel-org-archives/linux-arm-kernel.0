From: will.deacon@arm.com (Will Deacon)
Date: Tue, 18 Feb 2014 19:10:23 +0000
Subject: [PATCH v3 3/3] PCI: ARM: add support for generic PCI host
 controller
In-Reply-To: <2340480.VAU4NNbBD8@wuerfel>
References: <1392726043-31088-1-git-send-email-will.deacon@arm.com>
 <1392726043-31088-4-git-send-email-will.deacon@arm.com>
 <2340480.VAU4NNbBD8@wuerfel>
Message-ID: <20140218191023.GG2010@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 01:46:44PM +0000, Arnd Bergmann wrote:
> On Tuesday 18 February 2014 12:20:43 Will Deacon wrote:
> 
> > +static int gen_pci_alloc_io_offset(u32 sz, resource_size_t *offset)
> > +{
> > +	static DECLARE_BITMAP(io_map, (IO_SPACE_LIMIT + 1) / SZ_64K);
> > +	int idx, num_wins;
> > +
> > +	if (sz > SZ_64K)
> > +		return -ENOSPC;
> > +
> > +	num_wins = (IO_SPACE_LIMIT + 1) / SZ_64K;
> > +	idx = 0;
> > +	do {
> > +		idx = find_next_zero_bit(io_map, num_wins, idx);
> > +		if (idx == num_wins)
> > +			return -ENOSPC;
> > +	} while (test_and_set_bit(idx, io_map));
> > +
> > +	*offset = idx * SZ_64K;
> > +	return 0;
> > +}
> 
> Sicne you're always starting the search at 0 and you never free
> the map, this is essentially the same as remembering the last number
> that was used and using the next one, right?

Yes, I can implement that easily enough. I was wondering if there was a case
for allowing windows to be freed, but it doesn't feel especially compelling.

> You should also pass the rang->pci_addr here to calculate the
> offset in case the pci_addr is not zero.
> 
> > +	/* Register our I/O and Memory resources */
> > +	res_valid = 0;
> > +	list_for_each_entry(win, &pci->host.windows, list) {
> > +		struct resource *parent;
> > +
> > +		if (resource_type(win->res) == IORESOURCE_IO) {
> > +			parent = &ioport_resource;
> > +			err = pci_ioremap_io(win->offset, win->res->start);
> 
> and consequently pass the pci_addr rather than the offset here. How about
> moving the pci_ioremap_io() call into gen_pci_alloc_io_offset()?

Can do.

Thanks for the feedback.

Will
