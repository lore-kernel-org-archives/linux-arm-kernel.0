From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 18 May 2011 19:56:42 +0900
Subject: [PATCH] shmobile: fix map_io init usage
In-Reply-To: <20110516074928.GJ30539@n2100.arm.linux.org.uk>
References: <1304267322-19022-1-git-send-email-plagnioj@jcrosoft.com>
	<20110513015653.GM18952@game.jcrosoft.org>
	<BANLkTikorWv-9VnRG51v30YFQksRMxVS5Q@mail.gmail.com>
	<20110516074928.GJ30539@n2100.arm.linux.org.uk>
Message-ID: <BANLkTikakFc5fC098PG36_+ML3hnbStOQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 16, 2011 at 4:49 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, May 16, 2011 at 01:28:34PM +0900, Magnus Damm wrote:
>> On Fri, May 13, 2011 at 10:56 AM, Jean-Christophe PLAGNIOL-VILLARD
>> <plagnioj@jcrosoft.com> wrote:
>> > On 18:28 Sun 01 May ? ? , Jean-Christophe PLAGNIOL-VILLARD wrote:
>> >> switch early init to init_early and introduce soc map_io
>> >>
>> >> with this Patch we will not do any more early device setup during the map io
>> >>
>> >> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
>> >> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
>> >> Cc: Paul Mundt <lethal@linux-sh.org>
>> >> Cc: Magnus Damm <magnus.damm@gmail.com>
>> > ping
>>
>> Why? The device init order is changed by this patch to setup the
>> serial console later. I fail to see the benefit. Basically, the serial
>> console setup is delayed to happen in ->init_early() instead of
>> ->map_io(). In practice this means that we restrict ourselves to not
>> be able to output debug messages on the serial console from a bunch of
>> calls in setup_arch().
>
> Because that's how its supposed to work. ?map_io is for setting up the
> device mappings. ?Those mappings need flushing out to RAM on some CPUs
> to be visible, and that's taken care of _after_ map_io has returned.
>
> If the page table entries haven't found their way to RAM, accessing
> devices in map_io will cause a fault, and produce a silently non-booting
> kernel. ?With a write-alloc writeback cache policy, this becomes more
> likely than the default policy of a read-alloc writeback cache.
>
> Platforms should not do their own cache and TLB maintainence in their
> map_io callback to make it work either - should we need to change
> things that means going through all platforms.

Ok, I understand. Thanks for the detailed explanation Russell.

I've just tested this patch on AG5EVM / sh73a0 and it seems to work well.

Acked-by: Magnus Damm <damm@opensource.se>
