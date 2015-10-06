From: dhdang@apm.com (Duc Dang)
Date: Tue, 6 Oct 2015 15:30:46 -0700
Subject: [PATCH 1/1] irqchip/GICv2m: Add workaround for APM X-Gene GICv2m
 erratum
In-Reply-To: <20151003142650.16b291b4@arm.com>
References: <1443824209-23611-1-git-send-email-dhdang@apm.com>
 <20151003142650.16b291b4@arm.com>
Message-ID: <CADaLNDkHP=Fs=wnmYuzWppZKcL26txOT2v1XA-ac20-C2bM3oA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 3, 2015 at 6:26 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On Fri, 2 Oct 2015 15:16:49 -0700
> Duc Dang <dhdang@apm.com> wrote:
>
> Hi Duc,
>
>> APM X-Gene GICv2m implementation has an erratum where the
>> MSI data needs to be the offset from the spi_start in order to
>> trigger the correct MSI interrupt. This is different from the
>> standard GICv2m implementation where the MSI data is the absolute
>> value within the range from spi_start to (spi_start + num_spis)
>> of each v2m frame.
>>
>> This patch reads MSI_IIDR register (present in all GICv2m
>> implementations) to identify X-Gene GICv2m implementation and
>> apply workaround to change the data portion of MSI vector.
>>
>> Signed-off-by: Duc Dang <dhdang@apm.com>
>> ---
>>  drivers/irqchip/irq-gic-v2m.c | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
>> index db04fc1..470972c 100644
>> --- a/drivers/irqchip/irq-gic-v2m.c
>> +++ b/drivers/irqchip/irq-gic-v2m.c
>> @@ -43,6 +43,10 @@
>>
>>  #define V2M_MSI_TYPER_NUM_SPI(x)       ((x) & V2M_MSI_TYPER_NUM_MASK)
>>
>> +#define V2M_MSI_IIDR                 0xFCC
>
> Please group this with the rest of the registers.
>
>> +/* APM X-Gene with GICv2m MSI_IIDR register value */
>> +#define XGENE_GICV2M_MSI_IIDR                0x06000170
>> +
>
> Is this value guaranteed to only identify the affected implementation?
> Do we have strong guarantees that a fixed implementation will not have
> this value?
>
> If not, I'd strongly suggest using a different method (compatible
> string).
>

I got confirmation from my designer. This value (0x06000170) is unique
for affected implementation. The fixed implementation will not have
this value for MSI_IIDR register.

>>  struct v2m_data {
>>       spinlock_t msi_cnt_lock;
>>       struct resource res;    /* GICv2m resource */
>> @@ -98,6 +102,16 @@ static void gicv2m_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>>       msg->address_hi = (u32) (addr >> 32);
>>       msg->address_lo = (u32) (addr);
>>       msg->data = data->hwirq;
>> +     /*
>> +      * APM X-Gene GICv2m implementation has an erratum where
>> +      * the MSI data needs to be the offset from the spi_start
>> +      * in order to trigger the correct MSI interrupt. This is
>> +      * different from the standard GICv2m implementation where
>> +      * the MSI data is the absolute value within the range from
>> +      * spi_start to (spi_start + num_spis).
>> +      */
>> +     if (readl_relaxed(v2m->base + V2M_MSI_IIDR) == XGENE_GICV2M_MSI_IIDR)
>> +             msg->data = data->hwirq - v2m->spi_start;
>>  }
>>
>>  static struct irq_chip gicv2m_irq_chip = {
>
> Please add a set of flags to struct v2m_data as well as a flag
> (GICV2M_NEEDS_SPI_OFFSET?) that can be checked in the compose method
> (we don't needs to read the IIDR register each time we program an MSI):
>
>         if (v2m->flags & GICV2M_NEEDS_SPI_OFFSET)
>                 msg->data -= v2m->spi_start;
>
> You can set that flag from the probe function.

Yes, I will update the patch with your suggestion shortly.
>
> Thanks,
>
>         M.
> --
> Jazz is not dead. It just smells funny.

Regards,
Duc Dang.
