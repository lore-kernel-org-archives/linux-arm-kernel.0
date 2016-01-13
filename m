From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 13 Jan 2016 08:35:07 +0000
Subject: [PATCH V2 03/10] irqchip,GICv3,ACPI: Add redistributor support
 via GICC structures.
In-Reply-To: <5695ADE5.7010501@linaro.org>
References: <1450353133-15992-1-git-send-email-tn@semihalf.com>
 <1450353133-15992-4-git-send-email-tn@semihalf.com>
 <5694EB92.9030109@arm.com> <56952DA1.4030401@semihalf.com>
 <5695ADE5.7010501@linaro.org>
Message-ID: <56960C3B.8030105@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/01/16 01:52, Hanjun Guo wrote:
> 
> 
> On 2016/1/13 0:45, Tomasz Nowicki wrote:
>> On 12.01.2016 13:03, Marc Zyngier wrote:
>>
>>  > +    typer = readq_relaxed(redist_base + GICR_TYPER);
>>  > +    /* don't map reserved page as it's buggy to access it */
>>  > +    size = (typer & GICR_TYPER_VLPIS) ? SZ_64K * 3 : SZ_64K * 2;
>>
>> [...]
>>
>>> Also, please map the whole region for the
>>> redistributor as we have on the DT side (4 64kB pages for VLPIS capable
>>> redistributors).
>>
>> Hanjun, is it something you had problem with?
> 
> Yes, for D02, it use 3 64kB pages for GICv4, it removed the reserved
> page. In DT case, it has "stride" binding so it can support no standard
> cases, seems that we can introduce "stride" for ACPI too.

I don't think there is any need for that, assuming this system only
exposes its redistributors via the ACPI GICC structure. In which case, I
don't think it hurts to have overlapping mappings: For redistributors A
and B, we never touch A[3] (the reserved page), but we will access B[0].

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
