From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 04 Jun 2013 19:19:35 +0200
Subject: [PATCH v2 1/2] ARM PJ4B: Add support for errata 4742
In-Reply-To: <20130604145958.GY18614@n2100.arm.linux.org.uk>
References: <1370354598-12920-1-git-send-email-gregory.clement@free-electrons.com>
 <1370354598-12920-2-git-send-email-gregory.clement@free-electrons.com>
 <20130604145958.GY18614@n2100.arm.linux.org.uk>
Message-ID: <51AE21A7.5080907@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Russell King,

On 06/04/2013 04:59 PM, Russell King - ARM Linux wrote:
> On Tue, Jun 04, 2013 at 04:03:17PM +0200, Gregory CLEMENT wrote:
>> From: Lior Amsalem <alior@marvell.com>
>>
>> This commit fixes the regression on Armada 370 (the kernal hang during
>> boot) introduced by the commit: "ARM: 7691/1: mm: kill unused
>> TLB_CAN_READ_FROM_L1_CACHE and use ALT_SMP instead".
>>
>> When coming out of either a Wait for Interrupt (WFI) or a Wait for
>> Event (WFE) IDLE states, a specific timing sensitivity exists between
>> the retiring WFI/WFE instructions and the newly issued subsequent
>> instructions. This sensitivity can result in a CPU hang scenario.  The
>> workaround is to insert either a Data Synchronization Barrier (DSB) or
>> Data Memory Barrier (DMB) command immediately after the WFI/WFE
>> instruction
> 
> Wouldn't a DMB be cheaper than a full blown DSB here?

I let Lior answer to this question.

> 
> Also, we could detect the PJ4B and only implement the workaround
> on those CPUs rather than having to have it on every v7 CPU - which
> is important when you consider the single zImage issues.

At least we can detect the PJ4B and maybe even the detect the if it
is the PJ4B or the PJ4B-MP.

Do you mean to add this test in the cpu_v7_do_idle() function?

Or patching the pointer to the cpu_v7_do_idle() on the fly? In this
last case it seems a little tricky to me, as we should have to modify
a pointer function in the .proc.info.init section.

Thanks for your review,

Gregory
