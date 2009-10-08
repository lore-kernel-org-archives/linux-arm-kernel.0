From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 7 Oct 2009 23:12:54 -0400
Subject: [PATCH 1/5] pxa3xx_nand: enable PXA3xx bad block management
In-Reply-To: <771cded00909251900v7ee60bf6uf4c5724075c65826@mail.gmail.com>
References: <771cded00909250457w19686a53obdc178488368dd43@mail.gmail.com>
	<69f617130909251004y2a17cdetb45f6022a37b4249@mail.gmail.com>
	<771cded00909251900v7ee60bf6uf4c5724075c65826@mail.gmail.com>
Message-ID: <771cded00910072012n51522ce9q32691346e96c4e55@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 25, 2009 at 10:00 PM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> On Sat, Sep 26, 2009 at 1:04 AM, Mok Keith <ek9852@gmail.com> wrote:
>> Hi,
>>
>> Any reason to limit the max slot to 40 (PXA_MAX_SLOT). It seems the
>> bad block management scheme is not scalable and have a limitation of
>> up to 256M bytes flash size only. (256M, 128kB per block = 2048 blocks
>> = 40 bad blocks)
>
> Each slot is one page. It's used to record the relocation information.
> Each relocation
> information is composed by two items. One is the bad block number, the other one
> is relocated block number. Both of these two items cost 16 bits. For
> the large block
> flash, it can save 511 relocation information at most.
>
> In the head of slot, a 16-bit magic number and 16-bit total number of
> relocation items are
> recorders.
>
> When the slot is used, the next written will be moved to the next
> slot. It's used to protect
> relocation recorders. If one slot is broken, driver could load the previous one.
>
> When all 40 slots are used, driver could erase the whole block and
> write again. This feature
> isn't enabled in the patch.
>>
>> Also for the calibration of the 2% bad block area, according to most
>> NAND specifications (checked Samsung, Hynix, Micron), nand flash
>> vendor guarantee no more than 20 bad block per 1024 blocks and this
>> rule is apply linearly.
>>
>> Would it be better to use the following otherwise when nand size is
>> greater than 256M the no of bad block entries is not matched to
>> specification:
>> instead of:
>>> + ? ?entries = (entries * 2) / 100;
>>
>> use:
>> + ? ?entries = (entries * 10) / 512;
>
> Yes, this formula is better. I will use this. Maybe I can use this
> formula whatever
> the flash is beyond 256M or not.
>
>>
>> May I know what is the use of PXA_BEGIN_SLOT ?
> I'm sorry that I removed usage of PXA_BEGIN_SLOT. But I didn't clear the macro
> definition.
>>
>> Keith
>>
>
> Now the new patch is in below.
>
> From 57dc033ff95a12ee83f9189c5f72827d755c5432 Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Fri, 25 Sep 2009 15:00:28 -0400
> Subject: [PATCH] [MTD] [NAND] pxa3xx_nand: enable PXA3xx bad block management
>
> There's a custom bad block management in PXA3xx series.
>
> This BBM needs to allocate a reserved area at the bottom of NAND chip.
> The reserved area should be protected from normal usage. The first block
> of NAND is also reserved in order to storing the relocation information.
>
> The reserved area is also called as relocation area. It occupies 2% of
> the whole NAND space.
>
> When NAND controller finds a bad block, it marks the block as bad and
> allocate a unused block from relocation area in bottom. The new block is
> used to replace the original bad one. From OS view, there's no bad block
> at the time. It's handled by NAND driver. Then driver records the replacement
> information in the first block.
>
> There're 40 pages are reserved in the first block. Each page is a independant
> relocation table. If the current relocation table is broken, driver will fetch
> the previous one. Each relocation information cost a 32-bit word.
>
>

Hi David,

How do you think that this patch series on PXA3xx bad block
management? Is it acceptable or not?

Thanks
Haojian
