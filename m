From: andreiw@motorola.com (Andrei Warkentin)
Date: Sat, 12 Feb 2011 18:10:09 -0600
Subject: MMC quirks relating to performance/lifetime.
In-Reply-To: <201102121937.24933.arnd@arndb.de>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com>
	<AANLkTimjQfuNU-_rZTjAPrjxJhb=3kReVysBKoPE6Q4o@mail.gmail.com>
	<AANLkTi=a1SbU4cn-m7r2BH2KhNoad3H9e41AcXoViMm7@mail.gmail.com>
	<201102121937.24933.arnd@arndb.de>
Message-ID: <AANLkTikGvUZ2sWfox9Ws+gbuCw1JiykO=y-rk9QjL8xJ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 12, 2011 at 12:37 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 11 February 2011 23:27:51 Andrei Warkentin wrote:
>>
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>> index 7054fd5..3b32329 100644
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -312,6 +316,157 @@ out:
>> ? ? ? return err ? 0 : 1;
>> ?}
>>
>> +/*
>> + * Workaround for Toshiba eMMC performance. ?If the request is less than two
>> + * flash pages in size, then we want to split the write into one or two
>> + * page-aligned writes to take advantage of faster buffering. ?Here we can
>> + * adjust the size of the MMC request and let the block layer request handler
>> + * deal with generating another MMC request.
>> + */
>> +#define TOSHIBA_MANFID 0x11
>> +#define TOSHIBA_PAGE_SIZE 16 ? ? ? ? /* sectors */
>> +#define TOSHIBA_ADJUST_THRESHOLD 24 ?/* sectors */
>> +static bool mmc_adjust_toshiba_write(struct mmc_card *card,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct mmc_request *mrq)
>> +{
>> + ? ? if (mmc_card_mmc(card) && card->cid.manfid == TOSHIBA_MANFID &&
>> + ? ? ? ? mrq->data->blocks <= TOSHIBA_ADJUST_THRESHOLD) {
>> + ? ? ? ? ? ? int sectors_in_page = TOSHIBA_PAGE_SIZE -
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? (mrq->cmd->arg % TOSHIBA_PAGE_SIZE);
>> + ? ? ? ? ? ? if (mrq->data->blocks > sectors_in_page) {
>> + ? ? ? ? ? ? ? ? ? ? mrq->data->blocks = sectors_in_page;
>> + ? ? ? ? ? ? ? ? ? ? return true;
>> + ? ? ? ? ? ? }
>> + ? ? }
>> +
>> + ? ? return false;
>> +}
>
> This part might make sense in general, though it's hard to know the
> page size in the general case. For many SD cards, writing naturally
> aligned 64 KB blocks was the ideal case in my testing, but some need
> larger alignment or can deal well with smaller blocks.
>

...which is why I believe this should be a boot per-card parameter,
and that it really only makes sense for embedded parts, where you know
nothing else is going to be used as, say, mmcblk0.


>> +/*
>> + * This is another strange workaround to try to close the gap on Toshiba eMMC
>> + * performance when compared to other vendors. ?In order to take advantage
>> + * of certain optimizations and assumptions in those cards, we will look for
>> + * multiblock write transfers below a certain size and we do the following:
>> + *
>> + * - Break them up into seperate page-aligned (8k flash pages) transfers.
>> + * - Execute the transfers in reverse order.
>> + * - Use "reliable write" transfer mode.
>> + *
>> + * Neither the block I/O layer nor the scatterlist design seem to lend them-
>> + * selves well to executing a block request out of order. ?So instead we let
>> + * mmc_blk_issue_rq() setup the MMC request for the entire transfer and then
>> + * break it up and reorder it here. ?This also requires that we put the data
>> + * into a bounce buffer and send it as individual sg's.
>> + */
>
> A lot of the SD cards I've seen will react very badly to reverse order,
> so that is definitely a dangerous thing to put into the code.
>
> Also, the "reliable write" seems like a really interesting thing to
> rely on for performance. I believe what the card is trying to do here
> is to optimize FAT32 directory updates. By using the small blocks in
> unpredictable order (anything but linear), you tell the card to treat
> this as part of a directory, so it probably gets written in a different
> way, but that might mean that it will try to turn the current erase
> block group into a special small write mode.
>
> I could imagine that this will cause problems on your eMMC once you
> write small blocks to more than erase block group, because that probably
> causes it to start garbage collection -- it makes sense for the cards
> to know that something is a directory, but it can only know about
> a small number of directories, so it will turn the segment into a regular
> one as soon something else becomes a directory.
>

It's difficult for me to argue one way or another. The code provided
is implementing Toshiba's suggestions for mitigating excessive wear.
Basically, as far as certain Android products are concerned, Motorola
created some "typical usage" cases, and collected data logs. These
logs were analyzed by Toshiba, which reported an approx x16
multiplication factor for writes.

Analysis of data written showed that there were many random accesses
with 16KB or 32KB, meaning they go into buffer B. According to T, that
means extra GC and PE cycle. I'm guessing per write.

So T suggested for random data to better go into buffer A. How? Two suggestions.
1) Split smaller accesses into 8KB and write with reliable write.
2) Split smaller accesses into 8KB and write in reverse.

The patch does both and I am verifying if that is really necessary. I
need to go see the mmc spec and what it says about reliable write.

Basically, whatever behavior you choose is going to be wrong some set
of cards. Which is why tuning it probably only makes sense for eMMC
parts, and should be a set of runtime/compile-time quirks. What do you
think?
