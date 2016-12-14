From: panand@redhat.com (Pratyush Anand)
Date: Wed, 14 Dec 2016 17:51:05 +0530
Subject: [PATCH 1/2] arm64: Add enable/disable d-cache support for
 purgatory
In-Reply-To: <20161214113701.GE17982@leverpostej>
References: <cover.1479788404.git.panand@redhat.com>
 <7a4866b928c0905ec1074dce1bfc7984c968a58a.1479788404.git.panand@redhat.com>
 <5838834D.90205@arm.com> <d8f354da-1e61-feaf-f76a-18e90361e98b@redhat.com>
 <9a79b666-7990-2a23-2d74-52b3317ce272@redhat.com> <58512A01.70101@arm.com>
 <20161214113701.GE17982@leverpostej>
Message-ID: <3a6ac655-bfa6-0d90-6351-731ce36e99eb@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wednesday 14 December 2016 05:07 PM, Mark Rutland wrote:
> On Wed, Dec 14, 2016 at 11:16:17AM +0000, James Morse wrote:
>> Hi Pratyush,
>>
>> On 14/12/16 10:12, Pratyush Anand wrote:
>>> On Wednesday 14 December 2016 03:08 PM, Pratyush Anand wrote:
>>>>> I would go as far as to generate the page tables at 'kexec -l' time,
>>>>> and only if
>>>>
>>>> Ok..So you mean that I create a new section which will have page table
>>>> entries mapping physicalmemory represented by remaining section, and
>>>> then purgatory can just enable mmu with page table from that section,
>>>> right? Seems doable. can do that.
>>>
>>> I see a problem here. If we create  page table as a new segment then, how can we
>>> verify in purgatory that sha for page table is correct? We need page table
>>> before sha verification start,and we can not rely the page table created by
>>> first kernel until it's sha is verified. So a chicken-egg problem.
>>
>> There is more than one of those! What happens if your sha256 calculation code is
>> corrupted? You have to run it before you know. The same goes for all the
>> purgatory code.
>>
>> This is why I think its better to do this in the kernel before we exit to
>> purgatory, but obviously that doesn't work for kdump.
>
> I see in an earlier message that the need for sha256 was being discussed
> in another thread. Do either of you happen to have a pointer to that.
>

patch 0/2 of this series.

> To me, it seems like it doesn't come with much benefit for the kdump
> case given that's best-effort anyway, and as above the verification code
> could have been be corrupted. In the non-kdump case it's not strictly
> necessary and seems like a debugging aid rather than a necessary piece
> of functionality -- if that's the case, a 20 second delay isn't the end
> of the world...


Even for the non-kdump ie `kexec -l` case we do not have a functionality 
to bypass sha verification in kexec-tools. --lite option with the 
kexec-tools was discouraged and not accepted. So,it is 20s for both 
`kexec -l` and `kexec -p`.
Also other arch like x86_64 takes negligible time in sha verification.

~Pratyush
