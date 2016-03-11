From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 11 Mar 2016 14:45:46 +0000
Subject: [PATCH 1/2] iommu/io-pgtable: Add MTK 4GB mode in Short-descriptor
In-Reply-To: <56D6DD2E.4030207@arm.com>
References: <1456268552-16635-1-git-send-email-yong.wu@mediatek.com>
 <1456268552-16635-2-git-send-email-yong.wu@mediatek.com>
 <56D6DD2E.4030207@arm.com>
Message-ID: <56E2DA1A.9010902@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/03/16 12:31, Robin Murphy wrote:
> Hi Yong,
>
> On 23/02/16 23:02, Yong Wu wrote:
>> Mediatek extend bit9 in the lvl1 and lvl2 pgtable descriptor of the
>> Short-descriptor as the 4GB mode in which the dram size will be
>> over 4GB.
>>
>> We add a special quirk for this MTK-4GB mode, And in the standard
>> spec, Bit9 in the lvl1 is "IMPLEMENTATION DEFINED", while it's AP[2]
>> in the lvl2, therefore if this quirk is enabled, NO_PERMS is also
>> expected.
>
> Would you be able to explain exactly what this "4GB mode" actually is?
> I've been trying to make sense of it from the original M4U patches and
> the patch for the I2C driver, but it has me completely baffled.

Many thanks to Joe for the explanation!

[...]
>> diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
>> index d4f5027..a84a60a 100644
>> --- a/drivers/iommu/io-pgtable.h
>> +++ b/drivers/iommu/io-pgtable.h
>> @@ -60,10 +60,16 @@ struct io_pgtable_cfg {
>>        * IO_PGTABLE_QUIRK_TLBI_ON_MAP: If the format forbids caching
>> invalid
>>        *    (unmapped) entries but the hardware might do so anyway,
>> perform
>>        *    TLB maintenance when mapping as well as when unmapping.
>> +     *
>> +     * IO_PGTABLE_QUIRK_MTK_4GB_EXT: Mediatek extend bit9 in the lvl1
>> and
>> +     *    lvl2 descriptor of the Short-descriptor as the 4GB mode.
>> +     *    Note that: Bit9 in the lvl1 is "IMPLEMENTATION DEFINED", while
>> +     *    it is AP[2] in the lvl2.
>
> Unfortunately that comment doesn't really explain anything - I'd be
> happy to suggest a more helpful wording, If only I understood what it
> actually did.

OK, now that I think I've got it, how about this?

    IO_PGTABLE_QUIRK_ARM_MTK_4GB: (ARM v7s format) Set bit 9 in all
	PTEs, for Mediatek IOMMUs which treat it as a 33rd address bit
	when the SoC is in "4GB mode" and they can only access the high
	remap of DRAM (0x1_00000000 to 0x1_ffffffff).

Robin.
