From: ccross@android.com (Colin Cross)
Date: Tue, 3 May 2011 11:41:41 -0700
Subject: [PATCHv2 4/4] ARM: tegra: irq: Add tegra_eoi
In-Reply-To: <1304414973.27863.2.camel@e102144-lin.cambridge.arm.com>
References: <1304284213-11950-5-git-send-email-ccross@android.com>
	<1304288854-11011-1-git-send-email-ccross@android.com>
	<1304414973.27863.2.camel@e102144-lin.cambridge.arm.com>
Message-ID: <BANLkTi=a26_A7yAAfkQd5NSxbR+reQCZ1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 3, 2011 at 2:29 AM, Will Deacon <will.deacon@arm.com> wrote:
> Hi Colin,
>
> On Sun, 2011-05-01 at 23:27 +0100, Colin Cross wrote:
>> Implement irq_eoi to allow the GIC irq chip flow controller to
>> be changed to fasteoi.
>>
>> Signed-off-by: Colin Cross <ccross@android.com>
>> ---
>> v2: Add tegra_eoi without removing tegra_ack, patch can now be
>> ? ? merged safely before Will Deacon's gic fasteoi patch
>>
>> ?arch/arm/mach-tegra/irq.c | ? ?9 +++++++++
>> ?1 files changed, 9 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-tegra/irq.c b/arch/arm/mach-tegra/irq.c
>> index da17491..4956c3c 100644
>> --- a/arch/arm/mach-tegra/irq.c
>> +++ b/arch/arm/mach-tegra/irq.c
>> @@ -95,6 +95,14 @@ static void tegra_ack(struct irq_data *d)
>> ? ? ? ? tegra_irq_write_mask(d->irq, ICTLR_CPU_IEP_FIR_CLR);
>> ?}
>>
>> +static void tegra_eoi(struct irq_data *d)
>> +{
>> + ? ? ? if (d->irq < FIRST_LEGACY_IRQ)
>> + ? ? ? ? ? ? ? return;
>> +
>> + ? ? ? tegra_irq_write_mask(d->irq, ICTLR_CPU_IEP_FIR_CLR);
>> +}
>> +
>> ?static int tegra_retrigger(struct irq_data *d)
>> ?{
>> ? ? ? ? if (d->irq < FIRST_LEGACY_IRQ)
>> @@ -116,6 +124,7 @@ void __init tegra_init_irq(void)
>> ? ? ? ? }
>>
>> ? ? ? ? gic_arch_extn.irq_ack = tegra_ack;
>> + ? ? ? gic_arch_extn.irq_eoi = tegra_eoi;
>> ? ? ? ? gic_arch_extn.irq_mask = tegra_mask;
>> ? ? ? ? gic_arch_extn.irq_unmask = tegra_unmask;
>> ? ? ? ? gic_arch_extn.irq_retrigger = tegra_retrigger;
>> --
>> 1.7.4.1
>
> Just the job!
>
> Acked-by: Will Deacon <will.deacon@arm.com>
>
> Thanks,
>
> Will
>
>

What is your plan for merging the fasteoi patches?  If you are
planning to put them in 2.6.40, can you pull these patches into your
tree?  I don't have any other Tegra changes planned for 2.6.40, so
they shouldn't cause conflicts later.
