From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Tue, 26 Jul 2016 10:50:08 +0100
Subject: [PATCH v15 04/10] arm64: Kprobes with single stepping support
In-Reply-To: <20160725171350.GE2423@e104818-lin.cambridge.arm.com>
References: <1467995754-32508-1-git-send-email-dave.long@linaro.org>
 <1467995754-32508-5-git-send-email-dave.long@linaro.org>
 <578FA238.3050206@arm.com> <5790F960.5050007@linaro.org>
 <57910528.7070902@arm.com> <57911590.50305@linaro.org>
 <20160722101617.GA17821@e104818-lin.cambridge.arm.com>
 <57924104.1080202@linaro.org>
 <20160725171350.GE2423@e104818-lin.cambridge.arm.com>
Message-ID: <ce78f577-d14a-7b12-c96f-a6ebd8866283@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/07/16 18:13, Catalin Marinas wrote:
> On Fri, Jul 22, 2016 at 11:51:32AM -0400, David Long wrote:
>> On 07/22/2016 06:16 AM, Catalin Marinas wrote:
>>> On Thu, Jul 21, 2016 at 02:33:52PM -0400, David Long wrote:
>>> [...]
>>> The document states: "Up to MAX_STACK_SIZE bytes are copied". That means
>>> the arch code could always copy less but never more than MAX_STACK_SIZE.
>>> What we are proposing is that we should try to guess how much to copy
>>> based on the FP value (caller's frame) and, if larger than
>>> MAX_STACK_SIZE, skip the probe hook entirely. I don't think this goes
>>> against the kprobes.txt document but at least it (a) may improve the
>>> performance slightly by avoiding unnecessary copy and (b) it avoids
>>> undefined behaviour if we ever encounter a jprobe with arguments passed
>>> on the stack beyond MAX_STACK_SIZE.
>>
>> OK, it sounds like an improvement. I do worry a little about unexpected side
>> effects.
>
> You get more unexpected side effects by not saving/restoring the whole
> stack. We looked into this on Friday and came to the conclusion that
> there is no safe way for kprobes to know which arguments passed on the
> stack should be preserved, at least not with the current API.
>
> Basically the AArch64 PCS states that for arguments passed on the stack
> (e.g. they can't fit in registers), the caller allocates memory for them
> (on its own stack) and passes the pointer to the callee. Unfortunately,
> the frame pointer seems to be decremented correspondingly to cover the
> arguments, so we don't really have a way to tell how much to copy.
> Copying just the caller's stack frame isn't safe either since a
> callee/caller receiving such argument on the stack may passed it down to
> a callee without copying (I couldn't find anything in the PCS stating
> that this isn't allowed).

The PCS[1] seems (at least to me) to be pretty clear that "the address 
of the first stacked argument is defined to be the initial value of SP".

I think it is only the return value (when stacked via the x8 pointer) 
that can be passed through an intermediate function in the way described 
above. Isn't it OK for a jprobe to clobber this memory? The underlying 
function will overwrite whatever the jprobe put there anyway.

Am I overlooking some additional detail in the PCS?


Daniel.


[1] Google presented me revision IHI 0055B (via infocenter.arm.com)
