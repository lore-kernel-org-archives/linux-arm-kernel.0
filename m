From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Sat, 25 Aug 2018 08:27:22 +0200
Subject: [PATCH v2 01/29] nvmem: add support for cell lookups
In-Reply-To: <20180824152740.GD27483@lunn.ch>
References: <20180810080526.27207-1-brgl@bgdev.pl>
 <20180810080526.27207-2-brgl@bgdev.pl>
 <20180824170848.29594318@bbrezillon>
 <20180824152740.GD27483@lunn.ch>
Message-ID: <20180825082722.567e8c9a@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 24 Aug 2018 17:27:40 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> On Fri, Aug 24, 2018 at 05:08:48PM +0200, Boris Brezillon wrote:
> > Hi Bartosz,
> > 
> > On Fri, 10 Aug 2018 10:04:58 +0200
> > Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >   
> > > +struct nvmem_cell_lookup {
> > > +	struct nvmem_cell_info	info;
> > > +	struct list_head	list;
> > > +	const char		*nvmem_name;
> > > +};  
> > 
> > Hm, maybe I don't get it right, but this looks suspicious. Usually the
> > consumer lookup table is here to attach device specific names to
> > external resources.
> > 
> > So what I'd expect here is:
> > 
> > struct nvmem_cell_lookup {
> > 	/* The nvmem device name. */
> > 	const char *nvmem_name;
> > 
> > 	/* The nvmem cell name */
> > 	const char *nvmem_cell_name;
> > 
> > 	/*
> > 	 * The local resource name. Basically what you have in the
> > 	 * nvmem-cell-names prop.
> > 	 */
> > 	const char *conid;
> > };
> > 
> > struct nvmem_cell_lookup_table {
> > 	struct list_head list;
> > 
> > 	/* ID of the consumer device. */
> > 	const char *devid;
> > 
> > 	/* Array of cell lookup entries. */
> > 	unsigned int ncells;
> > 	const struct nvmem_cell_lookup *cells;
> > };
> > 
> > Looks like your nvmem_cell_lookup is more something used to attach cells
> > to an nvmem device, which is NVMEM provider's responsibility not the
> > consumer one.  
> 
> Hi Boris
> 
> There are cases where there is not a clear providier/consumer split. I
> have an x86 platform, with a few at24 EEPROMs on it. It uses an off
> the shelf Komtron module, placed on a custom carrier board. One of the
> EEPROMs contains the hardware variant information. Once i know the
> variant, i need to instantiate other I2C, SPI, MDIO devices, all using
> platform devices, since this is x86, no DT available.
> 
> So the first thing my x86 platform device does is instantiate the
> first i2c device for the AT24. Once the EEPROM pops into existence, i
> need to add nvmem cells onto it. So at that point, the x86 platform
> driver is playing the provider role. Once the cells are added, i can
> then use nvmem consumer interfaces to get the contents of the cell,
> run a checksum, and instantiate the other devices.
> 
> I wish the embedded world was all DT, but the reality is that it is
> not :-(

Actually, I'm not questioning the need for this feature (being able to
attach NVMEM cells to an NVMEM device on a platform that does not use
DT). What I'm saying is that this functionality is provider related,
not consumer related. Also, I wonder if defining such NVMEM cells
shouldn't go through the provider driver instead of being passed
directly to the NVMEM layer, because nvmem_config already have a fields
to pass cells at registration time, plus, the name of the NVMEM cell
device is sometimes created dynamically and can be hard to guess at
platform_device registration time.

I also think non-DT consumers will need a way to reference exiting
NVMEM cells, but this consumer-oriented nvmem cell lookup table should
look like the gpio or pwm lookup table (basically what I proposed in my
previous email).
