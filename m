From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Mon, 29 Sep 2014 08:36:46 +0200
Subject: [PATCH 1/5] m25p80,spi-nor: Fix module aliases for m25p80
In-Reply-To: <20140928222150.GC3248@norris-Latitude-E6410>
References: <1410714624.3040.38.camel@decadent.org.uk>
 <1410714670.3040.39.camel@decadent.org.uk>
 <20140928222150.GC3248@norris-Latitude-E6410>
Message-ID: <CACna6rx=GyZ-4JpDix==WKszABseQXK6qCCkfiKCm9-WzBmM3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 September 2014 00:21, Brian Norris <computersforpeace@gmail.com> wrote:
> + Rafal
>
> Rafal has been looking at the same area of code. I'd really like to get
> this patch into 3.18 if possible, so the more eyes the better.

Thanks Brian.

I took me a while to follow this issue, too bad I wasn't subscribed to
the ML earlier. Let me try to sum it up.



1) The main urgent issue: broken auto-loading
Tracked in the thread: http://www.spinics.net/lists/linux-spi/msg01726.html
Problem: m25p80.c references spi_nor_ids (from external file)
Short-term solution: duplicate IDs in the m25p80.c

Ben: just like Brian, I think the patch like this one (
[PATCH 1/5] m25p80,spi-nor: Fix module aliases for m25p80
) is the way to go. However few comments:

a) I don't see why you modify m25p_probe in it.

b) I don't think the described clean solution (you described it in the
commit message):
> A clean solution to this will involve defining the list of device
> IDs in spi-nor.h and removing struct spi_device_id from the spi-nor
> API, but this is quite a large change.
is the correct one. I think there should be a single string to trigger
m25p80 load and the rest should be handled using JEDEC, with some
workarounds for incompatible devices only.

One thing I wonder about is sense of pushing this patch to the Linus's
tree. Do you think we could prepare a real fix for Linus and leave
this patch for stable@ only? I'm far from being an expert on such
things, just asking.



2) On going cleanups
It seems there are at least 2 ppl (me, Ben) working on some cleanups
independently.

a) There is (l2-mtd pushed) patch moving flash_platform_data into m25p80:
https://patchwork.ozlabs.org/patch/394219/

b) Removing spi_nor::read_id
https://patchwork.ozlabs.org/patch/389073/
Ben: I think this one has a NACK from me, because I'm going to use
custom read_id in the bcm53xxspiflash driver.
See following thread for bcm53xxspiflash description:
http://comments.gmane.org/gmane.linux.drivers.mtd/54578
Initial commit (it uses read_id): https://patchwork.ozlabs.org/patch/381902/

c) Obsoleting spi_device_id
It seems we both were working on the same thing, me slightly slower however ;)
https://patchwork.ozlabs.org/patch/377917/
https://patchwork.ozlabs.org/patch/389074/
https://patchwork.ozlabs.org/patch/389075/
I still have to review calmly your changes, but they need to be rebased anyway.

d) Cleaning m25p80
https://patchwork.ozlabs.org/patch/389076/
Ben: As said before, I think we should do smarter in the m25p80. We
should get rid of all that duplicated strings.
