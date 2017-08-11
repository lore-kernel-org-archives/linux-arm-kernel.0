From: james.morse@arm.com (James Morse)
Date: Fri, 11 Aug 2017 18:24:59 +0100
Subject: [PATCH v2 06/16] arm64: entry.S: convert elX_sync
In-Reply-To: <598C908C.9030506@arm.com>
References: <20170728141019.9084-1-james.morse@arm.com>
 <20170728141019.9084-7-james.morse@arm.com>
 <20170809172527.yrkpthrrtqoxi4d7@armageddon.cambridge.arm.com>
 <598C908C.9030506@arm.com>
Message-ID: <598DE86B.4030106@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On 10/08/17 17:57, James Morse wrote:
> On 09/08/17 18:25, Catalin Marinas wrote:
>> On Fri, Jul 28, 2017 at 03:10:09PM +0100, James Morse wrote:
>>> @@ -520,9 +514,16 @@ el1_preempt:
>>>  el0_sync:
>>>  	kernel_entry 0
>>>  	mrs	x25, esr_el1			// read the syndrome register
>>> +	mrs	x26, far_el1
>>
>> Just checking, since we are going to access far_el1 even when we get a
>> syscall, have you noticed any overhead?

(I can get rid of the extra far_el1 reads by doing a better job of this patch.)


> Good point, I haven't checked because I've been doing all this with the software
> model.
> 
> I will set this running on Seattle overnight, results in v3's cover letter.

So the series does make microbenchmarks like calling getpid() in a loop slower,
but its not the far_el1 read causing this, its the unconditional masking of
exceptions in kernel_exit. This doesn't show up once I start doing real work
(like fork or exec).

I may be able to get rid of this but keep SError unmasked in the kernel and
masked over eret by merging EL0-returns disable_daif with its existing
irq-masked ret-to-user loop.



Thanks,

James
