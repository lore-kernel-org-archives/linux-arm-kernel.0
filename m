From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 21 Jun 2014 10:58:13 +0100
Subject: [PATCH v4 11/14] ARM64: KVM: fix vgic_bitmap_get_reg function for
 BE 64bit case
In-Reply-To: <20140614150451.GG14023@lvm> (Christoffer Dall's message of "Sat,
 14 Jun 2014 16:04:51 +0100")
References: <1402590613-3341-1-git-send-email-victor.kamensky@linaro.org>
 <1402590613-3341-12-git-send-email-victor.kamensky@linaro.org>
 <20140614150451.GG14023@lvm>
Message-ID: <86wqcak2iy.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 14 2014 at 04:04:51 PM, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> On Thu, Jun 12, 2014 at 09:30:10AM -0700, Victor Kamensky wrote:
>> Fix vgic_bitmap_get_reg function to return 'right' word address of
>> 'unsigned long' bitmap value in case of BE 64bit image.
>> 
>> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
>> ---
>>  virt/kvm/arm/vgic.c | 24 ++++++++++++++++++++++--
>>  1 file changed, 22 insertions(+), 2 deletions(-)
>> 
>> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
>> index 529c336..b4ffd82 100644
>> --- a/virt/kvm/arm/vgic.c
>> +++ b/virt/kvm/arm/vgic.c
>> @@ -101,14 +101,34 @@ static u32 vgic_nr_lr;
>>  
>>  static unsigned int vgic_maint_irq;
>>  
>> +/*
>> + * struct vgic_bitmap contains unions that provide two views of
>> + * the same data. In one case it is an array of registers of
>> + * u32's, and in the other case it is a bitmap of unsigned
>> + * longs.
>> + *
>> + * This does not work on 64-bit BE systems, because the bitmap access
>> + * will store two consecutive 32-bit words with the higher-addressed
>> + * register's bits at the lower index and the lower-addressed register's
>> + * bits at the higher index.
>> + *
>> + * Therefore, swizzle the register index when accessing the 32-bit word
>> + * registers to access the right register's value.
>> + */
>> +#if defined(CONFIG_CPU_BIG_ENDIAN) && BITS_PER_LONG == 64
>> +#define REG_OFFSET_SWIZZLE	1
>> +#else
>> +#define REG_OFFSET_SWIZZLE	0
>> +#endif
>> +
>>  static u32 *vgic_bitmap_get_reg(struct vgic_bitmap *x,
>>  				int cpuid, u32 offset)
>>  {
>>  	offset >>= 2;
>>  	if (!offset)
>> -		return x->percpu[cpuid].reg;
>> +		return x->percpu[cpuid].reg + (offset ^ REG_OFFSET_SWIZZLE);
>>  	else
>> -		return x->shared.reg + offset - 1;
>> +		return x->shared.reg + ((offset - 1) ^ REG_OFFSET_SWIZZLE);
>>  }
>>  
>>  static int vgic_bitmap_get_irq_val(struct vgic_bitmap *x,
>> -- 
>> 1.8.1.4
>> 
>
> I had wished there was a cleaner way to abstract this, but I can't think
> of a cleaner solution, and restructuring the whole thing would be very
> invasive.
>
> I'm curious to hear from Marc on this one, but you can add:
>
> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
>
> because it looks correct.
>
> Thanks for picking up my suggestion on the commenting.

I tried hard to find another solution, but I think this is unfortunately
the best we can have... ;-)

So:
        Acked-by: Marc Zyngier <narc.zyngier@arm.com>

I will have to fold in a similar solution for the vgic-dyn series.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
