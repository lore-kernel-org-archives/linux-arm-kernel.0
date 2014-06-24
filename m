From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 24 Jun 2014 19:40:27 +0200
Subject: [PATCH v2] ARM: save/restore diagnostic register on Cortex-A9
 suspend/resume
In-Reply-To: <20140624163320.GM9121@arm.com>
References: <1403432119-1409-1-git-send-email-shawn.guo@freescale.com>
 <53A9A746.6080200@samsung.com> <20140624163320.GM9121@arm.com>
Message-ID: <53A9B80B.7020608@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 24.06.2014 18:33, Will Deacon wrote:
> On Tue, Jun 24, 2014 at 05:28:54PM +0100, Tomasz Figa wrote:
>> Hi Shawn,
>>
>> On 22.06.2014 12:15, Shawn Guo wrote:
>>> The CP15 diagnostic register holds ARM errata bits on Cortex-A9, so it
>>> needs to be saved/restored on suspend/resume.  Otherwise, the
>>> effectiveness of errata workaround gets lost together with diagnostic
>>> register bit across suspend/resume cycle.
>>>
>>> The patch adds a couple of Cortex-A9 specific suspend and resume
>>> functions to handle the diagnostic register across suspend/resume cycle.
>>
>> [snip]
>>
>>> +ENTRY(cpu_ca9mp_do_resume)
>>> +	ldmia	r0!, {r4}
>>> +	mcr	p15, 0, r4, c15, c0, 1  @ Diagnostic register
>>
>> What about platforms running in non-secure mode in which the register is
>> read-only?
> 
> On A9, it should be write-ignore. Are you seeing problems on a real SoC?

I'm observing a complete system hang on Exynos4412-based Trats2 board if
I try to write this register in resume from system-wide sleep.

Note that the board is running under secure firmware, but there is no
support for suspend/resume of such boards in mainline yet, so I'm
testing on a work in progress (but mostly finished) series that is yet
to be sent.

Best regards,
Tomasz
