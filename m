From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Tue, 30 Sep 2014 07:09:38 +0200
Subject: [PATCH 1/5] m25p80,spi-nor: Fix module aliases for m25p80
In-Reply-To: <1412042858.9388.79.camel@decadent.org.uk>
References: <1410714624.3040.38.camel@decadent.org.uk>
 <1410714670.3040.39.camel@decadent.org.uk>
 <20140928222150.GC3248@norris-Latitude-E6410>
 <CACna6rx=GyZ-4JpDix==WKszABseQXK6qCCkfiKCm9-WzBmM3A@mail.gmail.com>
 <1412042858.9388.79.camel@decadent.org.uk>
Message-ID: <CACna6rxBFNvF5bouv9KkS-3=TxcXVMrs30KMTS0mCjDAva4jiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 September 2014 04:07, Ben Hutchings <ben@decadent.org.uk> wrote:
> On Mon, 2014-09-29 at 08:36 +0200, Rafa? Mi?ecki wrote:
>> On 29 September 2014 00:21, Brian Norris <computersforpeace@gmail.com> wrote:
>> > + Rafal
>> >
>> > Rafal has been looking at the same area of code. I'd really like to get
>> > this patch into 3.18 if possible, so the more eyes the better.
>>
>> Thanks Brian.
>>
>> I took me a while to follow this issue, too bad I wasn't subscribed to
>> the ML earlier. Let me try to sum it up.
>>
>>
>>
>> 1) The main urgent issue: broken auto-loading
>> Tracked in the thread: http://www.spinics.net/lists/linux-spi/msg01726.html
>> Problem: m25p80.c references spi_nor_ids (from external file)
>> Short-term solution: duplicate IDs in the m25p80.c
>>
>> Ben: just like Brian, I think the patch like this one (
>> [PATCH 1/5] m25p80,spi-nor: Fix module aliases for m25p80
>> ) is the way to go. However few comments:
>>
>> a) I don't see why you modify m25p_probe in it.
>
> Because spi_nor_scan() requires a struct spi_device_id with the
> driver_data field pointing to a struct flash_info.

More friendly explanation: because spi_get_device_id uses driver's
id_table (that was now changes to pure strings).
I see the point.


>> b) I don't think the described clean solution (you described it in the
>> commit message):
>> > A clean solution to this will involve defining the list of device
>> > IDs in spi-nor.h and removing struct spi_device_id from the spi-nor
>> > API, but this is quite a large change.
>> is the correct one. I think there should be a single string to trigger
>> m25p80 load and the rest should be handled using JEDEC, with some
>> workarounds for incompatible devices only.
>
> That certainly makes sense for Linux-specific platform data, but I don't
> think it works for Device Tree "compatible" strings (see
> <http://mid.gmane.org/1410660009.3040.29.camel@decadent.org.uk>).

We could simply follow the way Linux-specific platform data works. We
could always use
compatible = "m25p80";
and then for some rare cases (where JEDEC fails) add something like
model = "at25df321a";


>> b) Removing spi_nor::read_id
>> https://patchwork.ozlabs.org/patch/389073/
>> Ben: I think this one has a NACK from me, because I'm going to use
>> custom read_id in the bcm53xxspiflash driver.
>> See following thread for bcm53xxspiflash description:
>> http://comments.gmane.org/gmane.linux.drivers.mtd/54578
>> Initial commit (it uses read_id): https://patchwork.ozlabs.org/patch/381902/
> [...]
>
> But it has to use spi_nor_match_id() because of the driver_data
> requirement.  This just illustrates that the read_id operation doesn't
> make sense as currently defined.

I agree, however there is already a patch in progress handling that:
https://patchwork.ozlabs.org/patch/377917/


> I accept that there will be a need for a read_id operation, but I think
> it should fill in a struct flash_info rather than requiring every chip
> to be described and named in spi-nor.c.

Flashes not supporting JEDEC are usually some weird versions of normal
flashes with JEDEC support. So I think we could still have them in the
spi-nor database and let users provide the name instead of filling the
whole struct flash_info.

-- 
Rafa?
