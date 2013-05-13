From: tom.leiming@gmail.com (Ming Lei)
Date: Mon, 13 May 2013 11:12:03 +0800
Subject: [PATCH V3 2/2] ARM: Handle user space mapped pages in
 flush_kernel_dcache_page
In-Reply-To: <20130511062719.GA10643@schnuecks.de>
References: <20130418135104.GA18616@arm.com>
 <20130421220629.GA25571@schnuecks.de>
 <20130430112225.GD29766@arm.com>
 <20130430210403.GA18076@schnuecks.de>
 <20130501142206.GB17387@arm.com>
 <20130501190441.GA22227@schnuecks.de>
 <20130502095431.GA20730@arm.com>
 <20130502193835.GA29144@schnuecks.de>
 <20130503100242.GB29962@arm.com>
 <CACVXFVPOuabwAa1VDmSnfDG=M-1Df02_kpbm0UVAVctCAB-U4Q@mail.gmail.com>
 <20130511062719.GA10643@schnuecks.de>
Message-ID: <CACVXFVM8OMmse1QwmY5S_cowhG0+gaDMOYwjrrbA1zr0JjV++g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 11, 2013 at 2:27 PM, Simon Baatz <gmbnomis@gmail.com> wrote:
> On Sat, May 04, 2013 at 04:21:27PM +0800, Ming Lei wrote:
>> On Fri, May 3, 2013 at 6:02 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
>> >>
>> >> I assume that you inhibited the call to flush_dcache_page() in
>> >> __get_user_pages() for anon pages.  Otherwise, you will be flooded
>> >> with warnings.
>> >
>> > I haven't done any stress testing so I don't think I hit this code path,
>> > so no warning. But yes, it should have triggered. Anyway, in this case
>> > flush_dcache_page() should have just ignored (clearing PG_arch_1 is
>> > harmless anyway if we also ignore this bit in __sync_icache_dcache for
>> > non-aliasing caches).
>>
>> Yes, maybe we can do a little optimization for O_DIRECT since no
>> dcache alias and I/D coherency problem in this case on ARMv7, how
>> about below change?
>>
>> diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
>> index 1c8f7f5..962a657 100644
>> --- a/arch/arm/mm/flush.c
>> +++ b/arch/arm/mm/flush.c
>> @@ -287,6 +287,8 @@ void flush_dcache_page(struct page *page)
>>           mapping && !mapping_mapped(mapping))
>>               clear_bit(PG_dcache_clean, &page->flags);
>>       else {
>> +             if (!mapping && cache_is_vipt_nonaliasing())
>> +                     return;
>>               __flush_dcache_page(mapping, page);
>>               if (mapping && cache_is_vivt())
>>                       __flush_dcache_aliases(mapping, page);
>>
>
> Yes, this should not be needed. However, I seem to get funny pixel
> errors on an Exynos 5 based Chromebook when not flushing in this
> case.  Strange.  This is not on a mainline kernel, I will need to
> have a look what happens here.

Yes, it is a bit strange, not sure how flush_dcache_page() is used
in memory mapped by mmap.(suppose the display buffer is mmaped)

I test O_DIRECT writing to USB mass storage with the patch, looks
the data written is correct.

[tom]$dd if=/mnt/nfs/test/usb/qieteing-512M.rmvb
of=/mnt/usb/tests/qieteing-512M.rmvb oflag=direct,sync bs=512M count=1
1+0 records in
1+0 records out
536870912 bytes (537 MB) copied, 111.631 s, 4.8 MB/s

#echo 3 > /proc/sys/vm/drop_caches

[tom]$cd /mnt/usb/tests/
[tom]$md5sum -c /mnt/nfs/test/usb/qieteing-512M.rmvb.md5
qieteing-512M.rmvb: OK


Thanks,
-- 
Ming Lei
