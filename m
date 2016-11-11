From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 11 Nov 2016 21:33:22 +0800
Subject: [PATCH V6 2/3] ACPI: Add support for ResourceSource/IRQ domain
 mapping
In-Reply-To: <20161110175814.GA12446@red-moon>
References: <1477687696-1509-1-git-send-email-agustinv@codeaurora.org>
 <1477687696-1509-3-git-send-email-agustinv@codeaurora.org>
 <42ff0a81-7836-11f6-58e0-979bd1d0be20@linaro.org>
 <60c1d53146c0aebd3a05095823229224@codeaurora.org>
 <20161110175814.GA12446@red-moon>
Message-ID: <5825C8A2.3040302@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

On 11/11/2016 01:58 AM, Lorenzo Pieralisi wrote:
> On Thu, Nov 10, 2016 at 10:02:35AM -0500, agustinv at codeaurora.org wrote:
>> Hey Hanjun,
>>
>> On 2016-11-09 21:36, Hanjun Guo wrote:
>>> Hi Marc, Rafael, Lorenzo,
>>>
>>> Since we agreed to add a probe deferral if we failed to get irq
>>> resources which mirroring the DT does (patch 1 in this patch set),
>>> I think the last blocker to make things work both for Agustin and
>>> me [1] is this patch, which makes the interrupt producer and consumer
>>> work in ACPI, we have two different solution for one thing, we'd happy
>>> to work together for one solution, could you give some suggestions
>>> please?
>>>
>>> [1]: https://mail-archive.com/linux-kernel at vger.kernel.org/msg1257419.html
>>>
>>> Agustin, I have some comments below.
>>>
>>> On 2016/10/29 4:48, Agustin Vega-Frias wrote:
>>>> This allows irqchip drivers to associate an ACPI DSDT device to
>>>> an IRQ domain and provides support for using the ResourceSource
>>>> in Extended IRQ Resources to find the domain and map the IRQs
>>>> specified on that domain.
>>>>
>>>> Signed-off-by: Agustin Vega-Frias <agustinv@codeaurora.org>
>>>> ---
>>>> drivers/acpi/Makefile    |   1 +
>>>> drivers/acpi/irqdomain.c | 119
>>>> +++++++++++++++++++++++++++++++++++++++++++++++
>>>
>>> Could we just reuse the gsi.c and not introduce a new
>>> file, probably we can change the gsi.c to irqdomain.c
>>> or something similar, then reuse the code in gsi.c.
>>
>> I was thinking just that after we chatted off-list.
>
> Yes, that's a fair point.
>
>> I might revisit and see what I come up with given that we already have
>> a device argument and we could pass the IRQ source there.
>
> I agree with the approach taken by this patch, I do not like much
> passing around struct acpi_resource_source *source (in particular
> the dummy struct) I do not think it is needed, I will comment on
> the code.

thanks for your time to have a look:)

>
> Hopefully there is not any buggy FW out there that does use the
> resource source inappropriately otherwise we will notice on x86/ia64
> (ie you can't blame FW if it breaks the kernel) but I suspect the
> only way to find out is by trying, the patch has to go through Rafael's
> review anyway before getting there so it is fine.

I think we can avoid that by not touching the logic that x86/ia64
already used, but only adding interrupt producer/consumer function.

Thanks
Hanjun
