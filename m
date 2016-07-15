From: anup.patel@broadcom.com (Anup Patel)
Date: Fri, 15 Jul 2016 21:57:28 +0530
Subject: [PATCH 7/8] uio: bind uio_dmem_genirq via OF
In-Reply-To: <20160715132835.GC19840@leverpostej>
References: <1468573443-4670-1-git-send-email-anup.patel@broadcom.com>
 <1468573443-4670-8-git-send-email-anup.patel@broadcom.com>
 <20160715132835.GC19840@leverpostej>
Message-ID: <CAALAos9KVS3SveQzGWGhcdxZNPapWnmTwZe+4y2g3LNGP3muDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 15, 2016 at 6:58 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> [adding devicetree list]
>
> On Fri, Jul 15, 2016 at 02:34:02PM +0530, Anup Patel wrote:
>> From: Jan Viktorin <viktorin@rehivetech.com>
>>
>> The uio_dmem_genirq works in a similar ways as uio_pdrv_genirq now.
>>
>> It accepts the of_id module parameter to specify UIO compatible
>> string as module parameter. There are few other module parameters
>> to specify DT property name for number bits in DMA mask and details
>> about dynamic regions.
>>
>> Following are the newly added module parameters:
>> 1) of_id: The UIO compatible string to be used for DT probing
>> 2) of_dma_bits_prot: This is name of OF property which will be
>> used to specify number of DMA mask bits in UIO DT node.
>> 3) of_dmem_count_prop: This is name of OF property which will be
>> used to specify number of dynamic regions in UIO DT node.
>> 4) of_dmem_sizes_prop: This is name of OF property which will be
>> used to specify sizes of each dynamic regions in UIO DT node.
>>
>> Signed-off-by: Jan Viktorin <viktorin@rehivetech.com>
>> Signed-off-by: Anup Patel <anup.patel@broadcom.com>
>> ---
>>  drivers/uio/uio_dmem_genirq.c | 113 +++++++++++++++++++++++++++++++++---------
>>  1 file changed, 89 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/uio/uio_dmem_genirq.c b/drivers/uio/uio_dmem_genirq.c
>> index a4d6d81..0a0cc19 100644
>> --- a/drivers/uio/uio_dmem_genirq.c
>> +++ b/drivers/uio/uio_dmem_genirq.c
>> @@ -144,46 +144,107 @@ static int uio_dmem_genirq_irqcontrol(struct uio_info *dev_info, s32 irq_on)
>>       return 0;
>>  }
>>
>> +static char uio_of_dma_bits_prop[128] = "uio,dma-bits";
>> +static char uio_of_dmem_count_prop[128] = "uio,number-of-dynamic-regions";
>> +static char uio_of_dmem_sizes_prop[128] = "uio,dynamic-regions-sizes";
>
> What are these proeprties? What is a "dynamic region" in hardware terms?

"Dynamic region" is DMAble memory alloced using dma_alloc_xxx() APIs
for the device.

For DMA-capable devices accessed from user-space, we need DMAble
memory available to user-space. Sometime such devices are also
cache-coherent (or IO-coherent) so in such case user-space will need
cacheable DMAble memory.

Number of "Dynamic regions" required by UIO dmem device depends
on the type of HW device hence we describe number of "Dynamic regions"
and size of "Dynamic regions" via DT attributes.

>
> Why must they be in the DT, and why are the *property names* arbitrarily
> overridable as module parameters? What exactly do you expect there to be
> in a DT?

They must be in DT for platform devices created using DT probing. The
number of "Dynamic regions" required by UIO device will depend on the
nature of device. We cannot have same number and sizes of "Dynamic
regions" for different UIO dmem devices.

The UIO dmem driver is a generic driver and not specific to any type of
HW. In fact, UIO dmem driver is generic enough to access variety of
platform devices from user-space using UIO framework.

Based on this Rob had previously suggested to not have any (or enforce
any) DT bindings for UIO dmem driver.

Refer, https://lkml.org/lkml/2016/5/18/457
Link to original Jan's patchset is https://lkml.org/lkml/2016/5/17/141

We had two options:
1) Get details of "Dynamic regions" via module parameter but this
would mean using same number and sizes of "Dynamic regions" for
all UIO dmem devices.
2) Pass names of DT attributes used by UIO dmem driver as
module parameters.

>
> DT bindings need documentation, but there was none as part of this series.
>
> I do not think this makes sense from a DT perspective.
>

As explained above, we are not fixing DT compatible string and
DT attributes names for UIO dmem driver instead we pass all
these as module parameters (preferable via kernel args or at
time of module insertion). Due to this we don't require DT bindings
document.

Regards,
Anup
