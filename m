From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 28 Sep 2011 22:39:46 -0700
Subject: [PATCH 2/2] msm: Support DEBUG_LL on MSM8660 and MSM8960
In-Reply-To: <alpine.LFD.2.02.1109290012400.9106@xanadu.home>
References: <1317243959-26383-1-git-send-email-sboyd@codeaurora.org>
	<1317243959-26383-3-git-send-email-sboyd@codeaurora.org>
	<alpine.LFD.2.02.1109290012400.9106@xanadu.home>
Message-ID: <4E8404A2.10702@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/28/2011 9:21 PM, Nicolas Pitre wrote:
> On Wed, 28 Sep 2011, Stephen Boyd wrote:
>
>
>>  	.macro	senduart,rd,rx
>> +#ifdef CONFIG_MSM_HAS_DEBUG_UART_HS
>> +	@ Clear TX_READY by writing to the UARTDM_CR register
>> +	mov	r12, #0x300
>> +	str	r12, [\rx, #0x10]
>> +	@ Write 0x1 to NCF register
>> +	mov 	r12, #0x1
>> +	str	r12, [\rx, #0x40]
>> +	@ UARTDM reg. Read to induce delay
>> +	ldr	r12, [\rx, #0x08]
>> +	@ Write the 1 character to UARTDM_TF
>> +	str	\rd, [\rx, #0x70]
> This is a really bad idea to pick a register (r12) when the calling code 
> is completely unaware of that.  This _will_ break on you someday.
>
> Except for the last line, why didn't you simply fold this code into the 
> waituart macro instead?

We need to configure the uart to be ready for a write and it didn't seem
appropriate to put that in the waituart macro because it isn't actually
waiting for anything. I suppose putting it after the waiting is fine
though and avoids future breakage. Thanks.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
