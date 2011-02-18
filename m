From: andreiw@motorola.com (Andrei Warkentin)
Date: Fri, 18 Feb 2011 17:17:51 -0600
Subject: MMC quirks relating to performance/lifetime.
In-Reply-To: <AANLkTi=rg2Du2RbakqpRNZZ7HHkhrsobz713YL29Wqoi@mail.gmail.com>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com>
	<AANLkTinaY2RM86tX4ex+zsMwFKUdBNVpdZ8fFrt-e12_@mail.gmail.com>
	<AANLkTikjUEjr=Sd1Ewyj8-yAKPV3Wa2Ch1aE=0DtrXP6@mail.gmail.com>
	<201102181444.24476.arnd@arndb.de>
	<AANLkTi=W16NxpzhrBhxJPmk-CSe+yyxAXMh6YYq6oaEt@mail.gmail.com>
	<AANLkTi=rg2Du2RbakqpRNZZ7HHkhrsobz713YL29Wqoi@mail.gmail.com>
Message-ID: <AANLkTimWAnPg2sYiLbfZXAAUiu7P5T3LmNoVbPi9RTEG@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/2/18 Andrei Warkentin <andreiw@motorola.com>:
> On Fri, Feb 18, 2011 at 1:47 PM, Andrei Warkentin <andreiw@motorola.com> wrote:
>> On Fri, Feb 18, 2011 at 7:44 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>>> I'm curious. Neither the manfid nor the oemid fields of either card
>>> match what I have seen on SD cards, I would expect them to be
>>>
>>> Sandisk: manfid 0x000003, oemid 0x5344
>>> Toshiba: manfid 0x000002, oemid 0x544d
>>>
>>> I have not actually seen any Toshiba SD cards, but I assume that they
>>> use the same controllers as Kingston.
>>>
>>> Does anyone know if the IDs have any correlation between MMC and SD
>>> controllers?
>>>
>>> ? ? ? ?Arnd
>>>
>>
>> I'm unsure about the older scheme (assigned by MMCA), but ever since
>> MMC is now JEDEC-controlled, the IDs have changed. Sandisk's new id
>> will be 0x45, and Toshiba I guess will be 0x11.
>>
>
> Flashbench timings for both Sandisk and Toshiba cards. Attaching due to size.
>
> Some interesting things that I don't understand. For the align test, I
> extended it to do a write align test (-A). I tried two partitions that
> I could write over, and both read and writes behaved differently for
> the two partitions on same device. Odd. They are both 4MB aligned.
>
> On the sandisk it was the write align that made the page size stand
> out. ?The read align had pretty constant results.
>
> On the toshiba the results varied wildly for the two partitions. For
> partition 6, there was a clear pattern in the diff values for read
> align. For 9, it was all over the place. For 9 with the write align,
> 8K and 16K the crossing writes took ~115ms!! Look in attached files
> for all the data.
>
> The AU tests were interesting too, especially how with several open
> AUs the throughput is higher for certain smaller sizes on sandisk, but
> if I interpret it correctly both cards have at least 4 AUs, as I
> didn't see yet a significant drop for small sizes. The larger ones I
> am running now on mmcblk0p9 which is sufficiently larger for these
> tests... (mmcblk0p6 is only 40mb, p9 is 314 mb)
>
> Thanks,
> A
>

I thought this was pretty interesting -

# echo 0 > /sys/block/mmcblk0/device/page_size
# ./flashbench -A -b 1024 /dev/block/mmcblk0p9
write align 8388608	pre 3.59ms	on 6.54ms	post 3.65ms	diff 2.92ms
write align 4194304	pre 4.13ms	on 7.37ms	post 4.27ms	diff 3.17ms
write align 2097152	pre 3.62ms	on 6.81ms	post 3.94ms	diff 3.03ms
write align 1048576	pre 3.62ms	on 6.53ms	post 3.55ms	diff 2.95ms
write align 524288	pre 3.62ms	on 6.51ms	post 3.63ms	diff 2.88ms
write align 262144	pre 3.62ms	on 6.51ms	post 3.63ms	diff 2.89ms
write align 131072	pre 3.62ms	on 6.5ms	post 3.63ms	diff 2.88ms
write align 65536	pre 3.61ms	on 6.49ms	post 3.62ms	diff 2.88ms
write align 32768	pre 3.61ms	on 6.49ms	post 3.61ms	diff 2.88ms
write align 16384	pre 3.68ms	on 107ms	post 3.51ms	diff 103ms
write align 8192	pre 3.74ms	on 121ms	post 3.91ms	diff 117ms
write align 4096	pre 3.88ms	on 3.87ms	post 3.87ms	diff -2937ns
write align 2048	pre 3.89ms	on 3.88ms	post 3.88ms	diff -8734ns
# fjnh84 at fjnh84-desktop:~/src/n/src/flash$ adb -s 17006185428011d7 shell
# echo 8192 > /sys/block/mmcblk0/device/page_size
# cd data
# ./flashbench -A -b 1024 /dev/block/mmcblk0p9
write align 8388608	pre 3.33ms	on 6.8ms	post 3.65ms	diff 3.31ms
write align 4194304	pre 4.34ms	on 8.14ms	post 4.53ms	diff 3.71ms
write align 2097152	pre 3.64ms	on 7.31ms	post 4.09ms	diff 3.44ms
write align 1048576	pre 3.65ms	on 7.52ms	post 3.65ms	diff 3.87ms
write align 524288	pre 3.62ms	on 6.8ms	post 3.63ms	diff 3.17ms
write align 262144	pre 3.62ms	on 6.84ms	post 3.63ms	diff 3.22ms
write align 131072	pre 3.62ms	on 6.85ms	post 3.44ms	diff 3.32ms
write align 65536	pre 3.39ms	on 6.8ms	post 3.66ms	diff 3.28ms
write align 32768	pre 3.64ms	on 6.86ms	post 3.66ms	diff 3.21ms
write align 16384	pre 3.67ms	on 6.86ms	post 3.65ms	diff 3.2ms
write align 8192	pre 3.66ms	on 6.84ms	post 3.64ms	diff 3.19ms
write align 4096	pre 3.71ms	on 3.71ms	post 3.64ms	diff 38.6?s
write align 2048	pre 3.71ms	on 3.71ms	post 3.72ms	diff -656ns

This was with the split unaligned accesses patch... Which I am
attaching for comments.

Thanks,
A
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-MMC-Split-non-page-size-aligned-accesses.patch
Type: text/x-diff
Size: 5195 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110218/333fe63e/attachment-0001.bin>
