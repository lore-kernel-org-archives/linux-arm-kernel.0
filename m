From: dhdang@apm.com (Duc Dang)
Date: Sun, 11 Oct 2015 10:13:39 -0700
Subject: [PATCH RFC 1/1] irqchip/GICv2m: Add support for multiple v2m
 frames
In-Reply-To: <56178483.5040404@arm.com>
References: <1444290518-18527-1-git-send-email-dhdang@apm.com>
 <56178483.5040404@arm.com>
Message-ID: <CADaLNDmQn7F_dEdfqhZxtqaLE9i16LpWtu2kk-yjyOUnE=E4-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 9, 2015 at 2:10 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> Hi Duc,
>
> On 08/10/15 08:48, Duc Dang wrote:
>> GICv2m driver currently only supports single v2m frame. This
>> patch extend this driver to support multiple v2m frames. All of
>> the v2m frames will be own by a single MSI domain. Each PCIe node
>> can specify msi-parent as the first frame of the v2m frame list
>> to be able to use all available v2m frames for MSI interrupts.
>>
>> This patch should be applied on top of patch
>> (irqchip/GICv2m: Add workaround for APM X-Gene GICv2m erratum):
>> https://lkml.org/lkml/2015/10/6/922
>>
>> Signed-off-by: Duc Dang <dhdang@apm.com>
>> ---
>>  drivers/irqchip/irq-gic-v2m.c | 221 ++++++++++++++++++++++++++++++------------
>>  1 file changed, 159 insertions(+), 62 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
>> index 4c17c18..8ecaf9e 100644
>> --- a/drivers/irqchip/irq-gic-v2m.c
>> +++ b/drivers/irqchip/irq-gic-v2m.c
>> @@ -51,13 +51,19 @@
>>  #define GICV2M_NEEDS_SPI_OFFSET              0x00000001
>>
>>  struct v2m_data {
>> -     spinlock_t msi_cnt_lock;
>>       struct resource res;    /* GICv2m resource */
>>       void __iomem *base;     /* GICv2m virt address */
>>       u32 spi_start;          /* The SPI number that MSIs start */
>>       u32 nr_spis;            /* The number of SPIs for MSIs */
>> -     unsigned long *bm;      /* MSI vector bitmap */
>>       u32 flags;              /* v2m flags for specific implementation */
>> +     struct list_head list;  /* Link to other v2m frames */
>> +};
>> +
>> +struct gicv2m_ctrlr {
>> +     spinlock_t v2m_ctrlr_lock;      /* Lock for all v2m frames */
>> +     u32 nr_vecs;                    /* Total MSI vectors */
>> +     unsigned long *bm;              /* MSI vector bitmap */
>> +     struct list_head v2m_frms;      /* List of v2m frames */
>>  };
>>
>>  static void gicv2m_mask_msi_irq(struct irq_data *d)
>> @@ -98,11 +104,29 @@ static int gicv2m_set_affinity(struct irq_data *irq_data,
>>       return ret;
>>  }
>>
>> +static struct v2m_data *irq_data_to_v2m_frm(struct irq_data *data,
>> +                                         struct gicv2m_ctrlr *v2m_ctrlr)
>> +{
>> +     struct v2m_data *v2m;
>> +
>> +     list_for_each_entry(v2m, &v2m_ctrlr->v2m_frms, list) {
>> +             if ((data->hwirq >= v2m->spi_start) &&
>> +                 (data->hwirq < (v2m->spi_start + v2m->nr_spis)))
>> +                     return v2m;
>> +     }
>> +
>> +     return NULL;
>> +}
>> +
>>  static void gicv2m_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>>  {
>> -     struct v2m_data *v2m = irq_data_get_irq_chip_data(data);
>> -     phys_addr_t addr = v2m->res.start + V2M_MSI_SETSPI_NS;
>> +     struct gicv2m_ctrlr *v2m_ctrlr = irq_data_get_irq_chip_data(data);
>> +     struct v2m_data *v2m;
>> +     phys_addr_t addr;
>>
>> +     v2m = irq_data_to_v2m_frm(data, v2m_ctrlr);
>> +     WARN_ON(!v2m);
>> +     addr = v2m->res.start + V2M_MSI_SETSPI_NS;
>
> At that particular point, I've stopped reading.
>
> Pointlessly iterating over the frames when you can store the right one
> in irq_data was bad enough, but having a WARN_ON() followed by a panic
> is just not acceptable. Either you warn and avoid the crash, or you just
> assume that the whole thing is sane and will never be inconsistent.

Yes, my bad.
>
> You are also changing the way this driver works, and not for the best.
> I've just written something fairly similar, with the following diffstat:
>
>  1 file changed, 76 insertions(+), 45 deletions(-)
>
> The current infrastructure is sound, you just have to make use of it.
>
> I've pushed the following (untested) patch:
>
> https://git.kernel.org/cgit/linux/kernel/git/maz/arm-platforms.git/commit/?h=irq/multi-v2m&id=45e35adb60087792626570ff21bb23ab0f67a6ac
>
> Let me know if that works for you.

Yes! I try and your patch definitely works on my X-Gene 2 board.

>
> Thanks,
>
>         M.
> --
> Jazz is not dead. It just smells funny...

Thanks and regards,
Duc Dang.
