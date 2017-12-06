From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Wed, 6 Dec 2017 14:35:31 +0000
Subject: [PATCH] arm64/mm: Do not write ASID generation to ttbr0
In-Reply-To: <c08f7a93-17bc-e763-2c8e-fb46c20154ed@arm.com>
References: <1512495507-23259-1-git-send-email-julien.thierry@arm.com>
 <5A26F485.10402@arm.com> <4f4572cf-9ae1-24b9-ec46-d8bbc6179426@arm.com>
 <5A27CCDF.1050305@arm.com> <c08f7a93-17bc-e763-2c8e-fb46c20154ed@arm.com>
Message-ID: <49bbe78b-1b74-6998-37f8-f3ef8d2ce642@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/12/17 11:33, Julien Thierry wrote:
> 
> 
> On 06/12/17 10:56, James Morse wrote:
>> Hi Julien,
>>
>> On 06/12/17 10:17, Julien Thierry wrote:
>>> On 05/12/17 19:33, James Morse wrote:
>>>> On 05/12/17 17:38, Julien Thierry wrote:

>>
>>>> This would let context.c's asid_bits be arbitrary, as the hardware only uses the
>>>> masked value it exposes in the new field.
>>>>
>>>> This doesn't solve the mixed 8/16 bit case. I think we should force those
>>>> systems to use 8bit asids via cpufeature to preserve as much of the generation
>>>> counter as possible.
>>
>>> Hmmm right, I see that today we just panic the kernel when we have a smaller
>>> asid size than the boot cpu...
>>> So if we boot on a 8bit asid cpu it should work but not the other way around...
>>> I agree we probably should find a way to reduce the size of software asids
>>> system wide when we find a cpu has less bits available.
>>
>> cpufeature has some stuff for 'LOWER_SAFE' that might help here..
>>
> 
> I'll have a look.

The problem with ASIDs is that you have to allocate the ASID map early in the
init, before any of the secondaries are brought up. So this is something that
has to be decided based on the boot CPU and hence is treated as an "early" feature
(without really a CAP bit). So all new CPUs should have minimum of the ASID size
as the boot CPU, failing which we panic the system, via verfiy_cpu_asid_bits().

I am not sure if you can really delay the asid_map allocation. You could probably
start there.

Cheers
Suzuki


> 
> Cheers,
> 
