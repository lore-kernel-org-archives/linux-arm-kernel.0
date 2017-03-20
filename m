From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Mon, 20 Mar 2017 04:52:29 -0500
Subject: [PATCH] irqchip: gic-v3-its: Don't assume GICv3 hardware supports
 16bit INTID
In-Reply-To: <a7e9f0a6-6118-a8a1-c6e9-8e6841c49f30@arm.com>
References: <1489556815-27121-1-git-send-email-shankerd@codeaurora.org>
 <a7e9f0a6-6118-a8a1-c6e9-8e6841c49f30@arm.com>
Message-ID: <e951b77e-5bc0-1895-928c-1d699091dcbd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,


On 03/17/2017 10:49 AM, Marc Zyngier wrote:
> On 15/03/17 05:46, Shanker Donthineni wrote:
>> The current ITS driver is assuming every ITS hardware implementation
>> supports minimum of 16bit INTID. But this is not true, as per GICv3
>> specification, INTID field is IMPLEMENTATION DEFINED in the range of
>> 14-24 bits. We might see an unpredictable system behavior on systems
>> where hardware support less than 16bits and software tries to use
>> 64K LPI interrupts.
>>
>> On Qualcomm Datacenter Technologies QDF2400 platform, boot log shows
>> confusing information about number of LPI chunks as shown below. The
>> QDF2400 ITS hardware supports 24bit INTID.
>>
>> This patch allocates the memory resources for PEND/PROP tables based
>> on discoverable value which is specified in GITS_TYPER.IDbits. Also
>> taking this opportunity to increase number of LPI/MSI(x) to 128K if
>> the hardware is capable, and show log message that reflects the
>> correct number of LPI chunks.
> As much as I like the idea of fixing the obvious bug that assuming 16bit
> of ID space is, what is the rational of capping the support to another
> arbitrary value?

I believe 128K LPIs are sufficient so capped to 17 bits.

> Why can't we (just like other tables) try and allocate the full amount
> required (with a possible back-off if allocations fail)?

Qualcomm ITS hardware supports 24bit LPI, it requires lot of memory to handle  2^24  entry property and pending table.

>
> Thanks,
>
> 	M.

-- 
Shanker Donthineni
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
