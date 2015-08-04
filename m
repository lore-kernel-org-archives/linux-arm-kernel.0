From: wcohen@redhat.com (William Cohen)
Date: Tue, 4 Aug 2015 11:07:43 -0400
Subject: [RFC PATCH V2 00/10] ARM64: Uprobe support added
In-Reply-To: <55BF707F.7020208@linaro.org>
References: <cover.1434598237.git.panand@redhat.com>
 <20150803110908.GC10501@arm.com> <55BF7019.9080007@linaro.org>
 <55BF707F.7020208@linaro.org>
Message-ID: <55C0D53F.6080403@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/03/2015 09:45 AM, David Long wrote:
> On 08/03/15 09:43, David Long wrote:
>> On 08/03/15 07:09, Will Deacon wrote:
>>> On Thu, Jun 18, 2015 at 04:58:47AM +0100, Pratyush Anand wrote:
>>>> These patches have been prepared on top of ARM64 kprobe v7 patches [1].
>>>> Keeping as RFC, because kprobe-v7 still need to be ACKed.
>>>
>>> Unfortunately, I've not seen any movement on the kprobes patches
>>> recently,
>>> so this is out of the picture for 4.3.
>>>
>>> Dave: did you plan to respin your series after Steve's comments on v7?
>>>
>>> Will
>>>
>>
>> Catalin's comments last week helped me clarify in my own mind that we
>> should be able to simplfy the register pushing somewhat. Will, does that
>> also make sense to you?
>>
> 
> ^^ That question was aimed at Will Cohen, just to clarify.

Hi Dave,

The suggestion to only save the caller saved registers would make the save and restore code shorter and faster.  There would be cases reduced saved and restore could be visible to systemtap scripts using print_reg() and register() functions such when  a call to a return probed function is followed by a call to a function with a kprobe on entry.  I worry about cases where code is broken (not following the calling conventions maybe assembly code functions) and using a return probe causes things to fail in a different way making it more difficult to diagnose the problem.  There are less than 50 "*.S" files for arm64, but I prefer to minimize the chances that the return probe changes something.

There is room for improvements for the patch.  The magic offset numbers in the save restore code could be eliminated.

-Will

> 
>> So, also taking into consideration Steve's suggestions about
>> reorganizing the asm code, I am now working on a new revision.
>>
>> -dl
>>
> 
