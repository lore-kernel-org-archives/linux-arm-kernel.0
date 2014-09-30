From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 29 Sep 2014 20:55:58 -0700
Subject: [PATCH 1/5] m25p80,spi-nor: Fix module aliases for m25p80
In-Reply-To: <1412042858.9388.79.camel@decadent.org.uk>
References: <1410714624.3040.38.camel@decadent.org.uk>
 <1410714670.3040.39.camel@decadent.org.uk>
 <20140928222150.GC3248@norris-Latitude-E6410>
 <CACna6rx=GyZ-4JpDix==WKszABseQXK6qCCkfiKCm9-WzBmM3A@mail.gmail.com>
 <1412042858.9388.79.camel@decadent.org.uk>
Message-ID: <20140930035558.GA8687@brian-ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 30, 2014 at 03:07:38AM +0100, Ben Hutchings wrote:
> On Mon, 2014-09-29 at 08:36 +0200, Rafa? Mi?ecki wrote:
> > b) I don't think the described clean solution (you described it in the
> > commit message):
> > > A clean solution to this will involve defining the list of device
> > > IDs in spi-nor.h and removing struct spi_device_id from the spi-nor
> > > API, but this is quite a large change.
> > is the correct one. I think there should be a single string to trigger
> > m25p80 load and the rest should be handled using JEDEC, with some
> > workarounds for incompatible devices only.
> 
> That certainly makes sense for Linux-specific platform data, but I don't
> think it works for Device Tree "compatible" strings (see
> <http://mid.gmane.org/1410660009.3040.29.camel@decadent.org.uk>).

I think it might work.

Your quote from that thread:

  "I think that a DT node is always supposed to include a compatible
  string for the specific device.  It could also include a generic
  compatible string for SPI NOR chips, but the *only* thing a driver can
  do with that is to use the JEDEC ID command.  It can't even
  generically read a single byte, since addresses may be either 3 or 4
  bytes long!  So I think that if a generic compatible string is
  defined, the DT binding must also define the properties that spi-nor
  currently reads out of its static table."

For every current entry (except the "*-nonjedec" entries; I don't think
we should be supporting any more entries like this, and I'd like to kill
the existing ones if possible), we can do just that; read out the JEDEC
ID and go from there. (Rafal is also looking at non-JEDEC RDID commands,
but that would just require a different type of binding.)

In fact, for most of these entries, we'll read out the ID and override
the match provided by the driver anyway. See:

int spi_nor_scan(...)
{
...
	[Note: almost all 'info' entries provide a non-zero jedec_id field]
	if (info->jedec_id) {
		const struct spi_device_id *jid;

		jid = nor->read_id(nor);
		if (IS_ERR(jid)) {
			return PTR_ERR(jid);
		} else if (jid != id) {
			/*
			 * JEDEC knows better, so overwrite platform ID. We
			 * can't trust partitions any longer, but we'll let
			 * mtd apply them anyway, since some partitions may be
			 * marked read-only, and we don't want to lose that
			 * information, even if it's not 100% accurate.
			 */
			dev_warn(dev, "found %s, expected %s\n",
				 jid->name, id->name);
			id = jid;
			info = (void *)jid->driver_data;
		}
	}
...
}

I think this chunk might be reworked (or at least, modify the comments)
to note how we primarily expect to override the input ID. We might even
drop the dev_warn() eventually, and make it more informative instead.

> [...]
> > b) Removing spi_nor::read_id
> > https://patchwork.ozlabs.org/patch/389073/
> > Ben: I think this one has a NACK from me, because I'm going to use
> > custom read_id in the bcm53xxspiflash driver.
> > See following thread for bcm53xxspiflash description:
> > http://comments.gmane.org/gmane.linux.drivers.mtd/54578
> > Initial commit (it uses read_id): https://patchwork.ozlabs.org/patch/381902/
> [...]
> 
> But it has to use spi_nor_match_id() because of the driver_data
> requirement.  This just illustrates that the read_id operation doesn't
> make sense as currently defined.

Right. I think it may turn out better to drop it and force a redesign
for the next user.

> I accept that there will be a need for a read_id operation, but I think
> it should fill in a struct flash_info rather than requiring every chip
> to be described and named in spi-nor.c.

Maybe struct flash_info, but this still leaks more spi-nor.c internal
info into drivers. Perhaps Rafal's use case could be served by a
select-able 'READ ID' opcode, with his flash_info structs still stored
in spi_nor_ids[] -- or possibly as a separate ID table within spi-nor.c.

But either way, I agree the current read_id() hook is not satisfactory.

Brian
