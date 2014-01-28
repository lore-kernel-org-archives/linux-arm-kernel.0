From: vkale@apm.com (Vinayak Kale)
Date: Tue, 28 Jan 2014 11:01:15 +0530
Subject: [PATCH] arm64: add DSB after icache flush in __flush_icache_all()
In-Reply-To: <20140127121613.GB6547@mudshark.cambridge.arm.com>
References: <1390823984-23046-1-git-send-email-vkale@apm.com>
 <20140127121613.GB6547@mudshark.cambridge.arm.com>
Message-ID: <CAPrCYkd_bB6heTGx9531Jh1JcBFiAziihG0hAk-_pc2-h=aChA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 27, 2014 at 5:46 PM, Will Deacon <will.deacon@arm.com> wrote:
> Hi Vinayak,
>
> On Mon, Jan 27, 2014 at 11:59:44AM +0000, Vinayak Kale wrote:
>> Add DSB after icache flush operation.
>
> Please elaborate a bit on what this achieves (i.e. completion of the
> maintenance operation).

Okay.

>
>> Signed-off-by: Vinayak Kale <vkale@apm.com>
>> ---
>>  arch/arm64/include/asm/cacheflush.h |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
>> index fea9ee3..88932498 100644
>> --- a/arch/arm64/include/asm/cacheflush.h
>> +++ b/arch/arm64/include/asm/cacheflush.h
>> @@ -116,6 +116,7 @@ extern void flush_dcache_page(struct page *);
>>  static inline void __flush_icache_all(void)
>>  {
>>       asm("ic ialluis");
>
> This needs a "memory" clobber to prevent re-ordering by GCC. We should
> probably check the rest of the code for other occurrences of this too.

Okay.

>
>> +     dsb();
>
> Can you make a corresponding change for arch/arm/ too, please? I think we're
> missing the barrier there as well.

I could have, but I don't have hardware to test it on.

>
> Will
