From: dan.j.williams@intel.com (Dan Williams)
Date: Sun, 30 Jan 2011 21:48:39 -0800
Subject: [PATCH 2/2] DMA: PL08x: fix channel pausing to timeout rather
	than lockup
In-Reply-To: <20110130165324.GB27436@n2100.arm.linux.org.uk>
References: <20110127123253.GC25968@n2100.arm.linux.org.uk>
	<20110127123744.GA28855@n2100.arm.linux.org.uk>
	<AANLkTinF0hfp81n_6jo3bGFVJadtKQUV8vc4Hxn5JSc2@mail.gmail.com>
	<20110130165324.GB27436@n2100.arm.linux.org.uk>
Message-ID: <AANLkTimitPA3X5tGpTTkg9qKzm-kSxYm2EJ6bc8T18sR@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 30, 2011 at 8:53 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sun, Jan 30, 2011 at 08:48:27AM -0800, Dan Williams wrote:
>> On Thu, Jan 27, 2011 at 4:37 AM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > If a transfer is initiated from memory to a peripheral, then data is
>> > fetched and the channel is marked busy. ?This busy status persists until
>> > the HALT bit is set and the queued data has been transfered to the
>> > peripheral. ?Waiting indefinitely after setting the HALT bit results in
>> > system lockups. ?Timeout this operation, and print an error when this
>> > happens.
>> >
>> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>> > ---
>> > This happens when a M->P transfer is started, but the peripheral doesn't
>> > take the data. ?The DMA controller will mark itself active and fetch data
>> > from memory, in anticipation of the peripheral wanting the data. ?This
>> > advances the source address.
>> >
>> > An alternative approach here is to just set the HALT bit and return
>> > immediately, without waiting for the primecell to show that it is no
>> > longer active. ?In any case, resuming the channel will allow the
>> > transfer to continue without data loss.
>> >
>>
>> Ok, and the other infinite busy wait in pl08x_start_txd() is
>> guaranteed to be after a resume operation, or does it also need a
>> timeout?
>
> The channel should not be active at that point. ?If it is, that means
> we're trying to setup a new transfer on a physical channel on top of an
> already active transfer, which obviously could result in the previous
> transfer being destroyed.
>
> Maybe a BUG_ON(pl08x_phy_channel_busy(phychan)) would be more appropriate
> there - but I think that's something to address in future patches.

Applied 1 and 2.

Thanks,
Dan
