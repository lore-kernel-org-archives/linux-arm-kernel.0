From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 13 Sep 2016 10:04:17 +0100
Subject: [PATCH v4 07/10] ARM: Introduce MPIDR_LEVEL_SHIFT macro
In-Reply-To: <20160913083855.GC5680@cbox>
References: <1473691764-29424-1-git-send-email-vladimir.murzin@arm.com>
 <1473691764-29424-8-git-send-email-vladimir.murzin@arm.com>
 <20160913083855.GC5680@cbox>
Message-ID: <57D7C111.7000405@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/09/16 09:38, Christoffer Dall wrote:
> On Mon, Sep 12, 2016 at 03:49:21PM +0100, Vladimir Murzin wrote:
>> vgic-v3 driver uses architecture specific MPIDR_LEVEL_SHIFT macro to
>> encode the affinity in a form compatible with ICC_SGI* registers.
>> Unfortunately, that macro is missing on ARM, so let's add it.
>>
>> Cc: Russell King <rmk+kernel@armlinux.org.uk>
>> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
>> ---
>>  arch/arm/include/asm/cputype.h |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
>> index 1ee94c7..e2d94c1 100644
>> --- a/arch/arm/include/asm/cputype.h
>> +++ b/arch/arm/include/asm/cputype.h
>> @@ -55,6 +55,7 @@
>>  
>>  #define MPIDR_LEVEL_BITS 8
>>  #define MPIDR_LEVEL_MASK ((1 << MPIDR_LEVEL_BITS) - 1)
>> +#define MPIDR_LEVEL_SHIFT(level) (MPIDR_LEVEL_BITS * level)
>>  
> 
> I'm not sure I follow the correctness of this completely.
> 
> This is called from vgic_v3_dispatch_sgi, which takes a u64 value, which
> may have something in the Aff3 field, which we now shift left 24 bits,
> but that is not the Aff3 field of AArch32's MPIDR.
> 
> What is the rationale for this making sense again?

IIUC, in such case we construct mpidr which won't match in match_mpidr()
with the value we get from kvm_vcpu_get_mpidr_aff() and no SGI will be
sent to the guest.

Since we get that u64 value from the guest, I'd think it is something
wrong is going on in the guest in case Aff3 is non-zero; however, we can
hide it by zeroing out SGI Aff3 bits in access_gic_sgi().

Cheers
Vladimir

> 
> Thanks,
> -Christoffer
> 
>>  #define MPIDR_AFFINITY_LEVEL(mpidr, level) \
>>  	((mpidr >> (MPIDR_LEVEL_BITS * level)) & MPIDR_LEVEL_MASK)
>> -- 
>> 1.7.9.5
>>
> 
> 
