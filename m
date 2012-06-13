From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 13 Jun 2012 11:49:55 +0530
Subject: [PATCH V2 03/10] ARM: OMAP4: Re-map the CTIs IRQs from MPU to
 DEBUGSS
In-Reply-To: <CAFm5wm2h9X-ELks7adT=NmRzVkvWhQEkefuBSvVHS6+AvstLwA@mail.gmail.com>
References: <1339104132-26885-1-git-send-email-jon-hunter@ti.com>
 <1339104132-26885-4-git-send-email-jon-hunter@ti.com>
 <CAFm5wm07QXCLA9SoFSqQP1NbdU0XynmyxKfjNJEMvziEAtphJQ@mail.gmail.com>
 <CAFm5wm2h9X-ELks7adT=NmRzVkvWhQEkefuBSvVHS6+AvstLwA@mail.gmail.com>
Message-ID: <CAMQu2gwLwOFaneDy07V9B=v9=8PWwgknm2+o1rTFJ4kAfEVsLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2012 at 11:43 AM, Pandita, Vikram <vikram.pandita@ti.com> wrote:
> On Tue, Jun 12, 2012 at 11:07 PM, Pandita, Vikram <vikram.pandita@ti.com> wrote:
>> On Thu, Jun 7, 2012 at 2:22 PM, Jon Hunter <jon-hunter@ti.com> wrote:
>>> In order to use the CTI interrupts inconjunction with the DEBUGSS we need to
>>> re-map the CTI IRQs to the DEBUGSS HWMOD. The purpose for doing this is so we
>>> can create a PMU device based upon the DEBUGSS HWMOD and use the CTI interrupts
>>> for routing ARM PMU events for OMAP4430 devices.
>>>
>>> This is based upon Benoit Cousson's patch [1].
>>>
>>> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2011-November/073319.html
>>>
>>> Cc: Ming Lei <ming.lei@canonical.com>
>>> Cc: Will Deacon <will.deacon@arm.com>
>>> Cc: Benoit Cousson <b-cousson@ti.com>
>>> Cc: Paul Walmsley <paul@pwsan.com>
>>> Cc: Kevin Hilman <khilman@ti.com>
>>>
>>> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
>>> ---
>>> ?arch/arm/mach-omap2/omap_hwmod_44xx_data.c | ? ?9 +++++++--
>>> ?1 file changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>>> index 950454a..faf5a6d 100644
>>> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>>> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>>> @@ -482,10 +482,17 @@ static struct omap_hwmod_class omap44xx_debugss_hwmod_class = {
>>> ?};
>>>
>>> ?/* debugss */
>>> +static struct omap_hwmod_irq_info omap44xx_debugss_irqs[] = {
>>> + ? ? ? { .name = "cti0", .irq = 1 + OMAP44XX_IRQ_GIC_START },
>>> + ? ? ? { .name = "cti1", .irq = 2 + OMAP44XX_IRQ_GIC_START },
>>
>> Data manual assigns cit0 == MA_IRQ_1 and cti1 == MA_IRQ_2
>> Why do you add 32 base GIC_START ?
>
> Looks we do the same for pl310:
> { .name = "pl310", .irq = 0 + OMAP44XX_IRQ_GIC_START },
>
> so u can ignore my comment .. excuse the noise...
>
All the SPI ( shared Peripheral IRQ's) have offset since first 32 IRQs
are dedicated
for SGI and PPI's.

CTIx and PL310 interrupts are mapped on SPI and hence they need that offset.

Regards
Santosh
