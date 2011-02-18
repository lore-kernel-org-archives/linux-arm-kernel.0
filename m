From: andreiw@motorola.com (Andrei Warkentin)
Date: Fri, 18 Feb 2011 16:40:16 -0600
Subject: MMC quirks relating to performance/lifetime.
In-Reply-To: <AANLkTi=W16NxpzhrBhxJPmk-CSe+yyxAXMh6YYq6oaEt@mail.gmail.com>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com>
	<AANLkTinaY2RM86tX4ex+zsMwFKUdBNVpdZ8fFrt-e12_@mail.gmail.com>
	<AANLkTikjUEjr=Sd1Ewyj8-yAKPV3Wa2Ch1aE=0DtrXP6@mail.gmail.com>
	<201102181444.24476.arnd@arndb.de>
	<AANLkTi=W16NxpzhrBhxJPmk-CSe+yyxAXMh6YYq6oaEt@mail.gmail.com>
Message-ID: <AANLkTi=rg2Du2RbakqpRNZZ7HHkhrsobz713YL29Wqoi@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 18, 2011 at 1:47 PM, Andrei Warkentin <andreiw@motorola.com> wrote:
> On Fri, Feb 18, 2011 at 7:44 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> I'm curious. Neither the manfid nor the oemid fields of either card
>> match what I have seen on SD cards, I would expect them to be
>>
>> Sandisk: manfid 0x000003, oemid 0x5344
>> Toshiba: manfid 0x000002, oemid 0x544d
>>
>> I have not actually seen any Toshiba SD cards, but I assume that they
>> use the same controllers as Kingston.
>>
>> Does anyone know if the IDs have any correlation between MMC and SD
>> controllers?
>>
>> ? ? ? ?Arnd
>>
>
> I'm unsure about the older scheme (assigned by MMCA), but ever since
> MMC is now JEDEC-controlled, the IDs have changed. Sandisk's new id
> will be 0x45, and Toshiba I guess will be 0x11.
>

Flashbench timings for both Sandisk and Toshiba cards. Attaching due to size.

Some interesting things that I don't understand. For the align test, I
extended it to do a write align test (-A). I tried two partitions that
I could write over, and both read and writes behaved differently for
the two partitions on same device. Odd. They are both 4MB aligned.

On the sandisk it was the write align that made the page size stand
out.  The read align had pretty constant results.

On the toshiba the results varied wildly for the two partitions. For
partition 6, there was a clear pattern in the diff values for read
align. For 9, it was all over the place. For 9 with the write align,
8K and 16K the crossing writes took ~115ms!! Look in attached files
for all the data.

The AU tests were interesting too, especially how with several open
AUs the throughput is higher for certain smaller sizes on sandisk, but
if I interpret it correctly both cards have at least 4 AUs, as I
didn't see yet a significant drop for small sizes. The larger ones I
am running now on mmcblk0p9 which is sufficiently larger for these
tests... (mmcblk0p6 is only 40mb, p9 is 314 mb)

Thanks,
A
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: toshiba.txt
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110218/3e560d5a/attachment.txt>
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: sandisk.txt
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110218/3e560d5a/attachment-0001.txt>
