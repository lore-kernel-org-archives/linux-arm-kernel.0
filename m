From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 23 Mar 2017 07:23:06 +0800
Subject: [PATCH 00/14] arm_pmu: ACPI support
In-Reply-To: <20170322121944.GB3940@red-moon>
References: <1489143891-11596-1-git-send-email-mark.rutland@arm.com>
 <5b5dca5f-0ea3-d7e7-63c9-dba57969d4be@arm.com>
 <20170314114508.GA15740@leverpostej> <20170314184733.GC15740@leverpostej>
 <20170322121944.GB3940@red-moon>
Message-ID: <58D3075A.3020605@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/22/2017 08:19 PM, Lorenzo Pieralisi wrote:
> On Tue, Mar 14, 2017 at 06:47:34PM +0000, Mark Rutland wrote:
>> On Tue, Mar 14, 2017 at 11:49:19AM +0000, Mark Rutland wrote:
>>> On Fri, Mar 10, 2017 at 04:14:57PM -0600, Jeremy Linton wrote:
>>>> I tried these patches on a m400 (which uses PPIs), and the kernel
>>>> fails to come up enough to login via the network (which works with
>>>> 4.11rc1 without these patches). So, I suspect there is something
>>>> wrong with them.
>>>
>>> Indeed; sorry about this. I'll see if I can get access to a board to try
>>> local debugging.
>>
>>>> About the only thing it says with any meaning when earlycon is passed is:
>>>> [   10.965147] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
>>>> [   11.064193] dw-apb-uart APMC0D08:00: cannot get irq
>>>>
>>>> and promptly hangs up.
>>
>> I believe that this is a latent FW bug, in a beta FW, exposed by recent
>> changes.
>>
>> I managed to get access to two APM Mustang boards. I can reproduce the
>> issue with a vanilla v4.11-rc1 defconfig on one, which has a beta FW.
>> The same kernel boots fine on the other, which has a later released FW.
>>
>> I bisected the issue down to commit:
>>
>>    d44fa3d46079dc09 ("ACPI: Add support for ResourceSource/IRQ domain mapping")
>>
>> It seems the beta FW describes the UART interrupt with an Extended
>> Interrupt Descriptor with the Consumer/Producer bit clear. Per the spec,
>> this means "This device produces and consumes this resource", which
>> doesn't make sense here given the UART is not an interrupt controller.
>>
>> The (working) released FW doesn't use an Extended Interrupt Descriptor
>> for this interrupt, sidestepping the issue.
>>
>> Given that (AFAICT) this only affects a known-broken, beta FW, I don't
>> think that we care that much.
>>
>> However, I think there is a larger potential issue here.
>>
>> In acpi_irq_parse_one_cb(), we skip interrupts with an Extended
>> Interrupt Descriptor with the Consumer/Producer bit clear. It sounds
>> like devices which behave as interrupt controllers could legitimately
>> have this bit set for interrupts they generate and deliver to
>> themselves, and we'd erroneously skip these when parsing interrupts.
>>
>> It's not entirely clear to me why this bit exists at all, given that
>> it's not used as part of mapping the interrupt, and if you really want
>> to know you can map the interrupt and look at the result.
>
> It is not entirely clear to anyone (and it has been a source of major
> trouble for other descriptors - ie memory - to the point that it has been
> deprecated for *some* descriptors). IIRC (Hanjun ?) the only reason why
> Agustin added the check for that bit in drivers/acpi/resource.c
> (is_gsi()) is to prevent ACPI core code allocating IRQs for the MBIgen
> device that, _erroneously_, was using an extended interrupt descriptor
> to list IRQ lines (that I have no idea what they represent) in order to
> count how many MSI vectors it would have to allocate.

I'm not sure it's error for a interrupt producer device (such as MBIgen)
to represent its interrupt resources using Interrupt under _CRS, from
the spec, we didn't violate anything, but in the OS side we expect a
better way to count MSI vectors.

>
> The gist is: removing the check for the extended interrupt descriptor
> producer/consumer bit in ACPI code therefore ignoring that bit should
> be harmless (given that the MBIgen bindings should be changed anyway).
>
> The meaning of that bit (and how we can flag up a FW bug) it is still
> a bit fuzzy IMO.
>
> Agustin, Hanjun, comments ?

I think it's firmware bug in the first place, PRODUCER bit can't be
clear if the device itself is not an interrupt controller, as we
can see that it's UART interrupt and UART can't be a interrupt
controller right? and the default value for the Consumer/Producer bit
is 1, not 0, the spec clearly say that.

So I think we need to fix the firmware (then the code is still not
violate any platforms), and also we need to fix the spec to clarify
things (As Agustin proposed), I reported this issue to ASWG but seems
my email was blocked, I will raise an ECR for discussion.

Thanks
Hanjun
