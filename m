From: andreiw@motorola.com (Andrei Warkentin)
Date: Sun, 20 Feb 2011 05:27:39 -0600
Subject: MMC quirks relating to performance/lifetime.
In-Reply-To: <201102171647.46190.arnd@arndb.de>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com>
	<201102151816.57104.arnd@arndb.de>
	<AANLkTimoqCtWMmBJ40v+1UjR0U2Sdh9pp+2fwYpi3fUx@mail.gmail.com>
	<201102171647.46190.arnd@arndb.de>
Message-ID: <AANLkTimGrT_p_5xdXJv5UURPMC0cwJCPkZ=xcX5Nk=o=@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 17, 2011 at 9:47 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> I think I'd try to reduce the number of sysfs files needed for this.
> What are the values you would typically set here?
>
> My feeling is that separating unaligned page writes from full pages
> or multiples of pages could always be benefitial for all cards, or at
> least harmless, but that will require more measurements.
> Whether to do the reliable write or not could be a simple flag
> if the numbers are the same.

I thought about this some more, and I realized it would be ugly if
everybody added enable_workaround_sec_start/enable_workaround_sec_end
for every novel idea of working around some issue with
performance/reliability on mmc/sd cards.

What about letting the user/embedder create policies for how certain
accesses are done? That way you give runtime-accessible
blocks for tuning mmc block layer while having one interface to
manipulate (and combine) multiple workarounds, all the while catching
conflicts and
without forcing specific policy in code.

Essentially under /sys/block/mmcblk0/device you have an attribute
called "policies". Example:

# echo mypol0 > /sys/block/mmcblk0/device/policies
# ls /sys/block/mmcblk0/device/mypol0
debug
delete
start_block
end_block
access_size_low
access_size_high
write_policy
erase_policy
read_policy
# cat /sys/block/mmcblk0/device/mypol0/write_policy
Current: none
0x00000001: Split unaligned writes across page_size
0x00000002: Split writes into page_size chunks and write using reliable writes
0x00000004: Use reliable writes for WRITE_META blocks.
# cat /sys/block/mmcblk0/device/mypol0/erase_policy
Current: none
0x00000001: Use secure erase.
# echo 1 > delete
# Policy is deleted.

The policies are all stored in a rb-tree. First order of business
inside mmc_blk_issue_rw_rq/mmc_blk_issue_* is to fetch an existing
policy given the access type and block start/end (which both tells
where the access is going and the size of the access). Later, it's
that policy information which controls how the request is translated
into MMC commands. I'm almost done with a prototype.

I noticed that all sysfs attributes are managed by code under
core/mmc.c and core/sd.c, duplicating where necessary. I think some of
the new block-related settings like page_size (or policies) are
generic enough that they should live in the card/block code. How about
putting all future sysfs block related things into block-sysfs.c?

Thanks,
A
