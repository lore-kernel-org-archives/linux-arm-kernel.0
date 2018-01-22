From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Mon, 22 Jan 2018 15:34:03 +0000
Subject: [PATCH v2 1/6] arm64: cpufeature: Allow early detect of specific
 features
In-Reply-To: <8e65a2e4-4058-1711-605d-481c0cb57e1c@arm.com>
References: <1516190084-18978-1-git-send-email-julien.thierry@arm.com>
 <1516190084-18978-2-git-send-email-julien.thierry@arm.com>
 <ce6469ab-b864-fec7-7d97-d44340f5b2e0@arm.com>
 <2f2a406b-fddf-6c30-4052-650f57ac317a@arm.com>
 <2fa17395-d268-5ec9-6033-08ecb7eba44a@arm.com>
 <5cafee50-c2ee-6c04-756c-785cdf822b27@arm.com>
 <4a8dc4ec-2762-e1cd-8126-ff44abcb67f2@arm.com>
 <8e65a2e4-4058-1711-605d-481c0cb57e1c@arm.com>
Message-ID: <8796d5da-8d0f-5c60-619a-40b471433988@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/01/18 15:23, Julien Thierry wrote:
> 
> 
> On 22/01/18 15:13, Suzuki K Poulose wrote:
>> On 22/01/18 15:01, Julien Thierry wrote:
>>>
>>>
>>> On 22/01/18 14:45, Suzuki K Poulose wrote:
>>>> On 22/01/18 12:21, Julien Thierry wrote:
>>>>>
>>>>>
>>>>> On 22/01/18 12:05, Suzuki K Poulose wrote:
>>>>>> On 17/01/18 11:54, Julien Thierry wrote:
>>>>>>> From: Daniel Thompson <daniel.thompson@linaro.org>

>>>>>> Julien,
>>>>>>
>>>>>> One potential problem with this is that we don't have a way
>>>>>> to make this work on a "theoretical" system with and without
>>>>>> GIC system reg interface. i.e, if we don't have the CONFIG
>>>>>> enabled for using ICC system regs for IRQ flags, the kernel
>>>>>> could still panic. I understand this is not a "normal" configuration
>>>>>> but, may be we could make the panic option based on whether
>>>>>> we actually use the system regs early enough ?
>>>>>>
>>>>>
>>>>> I see, however I'm not sure what happens in the GIC drivers if we have a CPU running with a GICv3 and other CPUs with something else... But of course this is not technically limited by the arm64 capabilities handling.
>>>>>
>>>>> What behaviour would you be looking for? A way to prevent the CPU to be brought up instead of panicking?
>>>>>
>>>>
>>>> If we have the CONFIG enabled for using system regs, we can continue
>>>> to panic the system. Otherwise, we should ignore the mismatch early,
>>>> as we don't use the system register access unless all boot time active
>>>> CPUs have it.
>>>>
>>>
>>> Hmmm, we use the CPUIF (if available) in the first CPU pretty much as soon as we re-enable interrupts in the GICv3 driver, which is way before the other CPUs are brought up.
>>
>> Isn't this CPUIF access an alternative, patched only when CPUIF feature
>> enabled ? (which is done only after all the allowed SMP CPUs are brought up )
> 
> The GICv3 doesn't rely on the alternatives, most of the operations are done via the CPUIF (ack IRQ, eoi, send sgi, etc ...).
> 
> So once GICv3 has been successfully probed and interrupts enabled, CPUIF might get used by the GICv3 driver.
> 

Aha, OK. I am sorry. I was thinking that the ARM64_HAS_SYSREG_GIC_CPUIF was used just for that.
In that case, I think you are not breaking any current behavior, so thats fine.

>>>
>>> other CPUs get to die_early().
>>
>> Really ? I thought only late CPUs are sent to die_early().
> 
> Hmmm, I might be wrong here but that was my understanding of the call to verify_local_cpu_features in verify_local_cpu_capabilities.
> 

The verify_local_cpu_features() is invoked only if the CPU is brought up late from userspace,
after we have finalised the system wide capabilities.

Sorry for the noise.

Suzuki
