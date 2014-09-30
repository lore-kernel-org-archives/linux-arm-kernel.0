From: ben@decadent.org.uk (Ben Hutchings)
Date: Tue, 30 Sep 2014 03:07:38 +0100
Subject: [PATCH 1/5] m25p80,spi-nor: Fix module aliases for m25p80
In-Reply-To: <CACna6rx=GyZ-4JpDix==WKszABseQXK6qCCkfiKCm9-WzBmM3A@mail.gmail.com>
References: <1410714624.3040.38.camel@decadent.org.uk>
 <1410714670.3040.39.camel@decadent.org.uk>
 <20140928222150.GC3248@norris-Latitude-E6410>
 <CACna6rx=GyZ-4JpDix==WKszABseQXK6qCCkfiKCm9-WzBmM3A@mail.gmail.com>
Message-ID: <1412042858.9388.79.camel@decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-09-29 at 08:36 +0200, Rafa? Mi?ecki wrote:
> On 29 September 2014 00:21, Brian Norris <computersforpeace@gmail.com> wrote:
> > + Rafal
> >
> > Rafal has been looking at the same area of code. I'd really like to get
> > this patch into 3.18 if possible, so the more eyes the better.
> 
> Thanks Brian.
> 
> I took me a while to follow this issue, too bad I wasn't subscribed to
> the ML earlier. Let me try to sum it up.
> 
> 
> 
> 1) The main urgent issue: broken auto-loading
> Tracked in the thread: http://www.spinics.net/lists/linux-spi/msg01726.html
> Problem: m25p80.c references spi_nor_ids (from external file)
> Short-term solution: duplicate IDs in the m25p80.c
> 
> Ben: just like Brian, I think the patch like this one (
> [PATCH 1/5] m25p80,spi-nor: Fix module aliases for m25p80
> ) is the way to go. However few comments:
> 
> a) I don't see why you modify m25p_probe in it.

Because spi_nor_scan() requires a struct spi_device_id with the
driver_data field pointing to a struct flash_info.

> b) I don't think the described clean solution (you described it in the
> commit message):
> > A clean solution to this will involve defining the list of device
> > IDs in spi-nor.h and removing struct spi_device_id from the spi-nor
> > API, but this is quite a large change.
> is the correct one. I think there should be a single string to trigger
> m25p80 load and the rest should be handled using JEDEC, with some
> workarounds for incompatible devices only.

That certainly makes sense for Linux-specific platform data, but I don't
think it works for Device Tree "compatible" strings (see
<http://mid.gmane.org/1410660009.3040.29.camel@decadent.org.uk>).

[...]
> b) Removing spi_nor::read_id
> https://patchwork.ozlabs.org/patch/389073/
> Ben: I think this one has a NACK from me, because I'm going to use
> custom read_id in the bcm53xxspiflash driver.
> See following thread for bcm53xxspiflash description:
> http://comments.gmane.org/gmane.linux.drivers.mtd/54578
> Initial commit (it uses read_id): https://patchwork.ozlabs.org/patch/381902/
[...]

But it has to use spi_nor_match_id() because of the driver_data
requirement.  This just illustrates that the read_id operation doesn't
make sense as currently defined.

I accept that there will be a need for a read_id operation, but I think
it should fill in a struct flash_info rather than requiring every chip
to be described and named in spi-nor.c.

Ben.

-- 
Ben Hutchings
The two most common things in the universe are hydrogen and stupidity.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 811 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140930/da598f26/attachment.sig>
