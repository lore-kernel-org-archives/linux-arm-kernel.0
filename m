From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 08 Nov 2011 20:11:17 -0800
Subject: [PATCHv3 2/2] msm: Support DEBUG_LL on MSM8660 and MSM8960
In-Reply-To: <alpine.LFD.2.02.1111081406220.3307@xanadu.home>
References: <1320777184-22446-1-git-send-email-sboyd@codeaurora.org>
 <1320777184-22446-3-git-send-email-sboyd@codeaurora.org>
 <alpine.LFD.2.02.1111081406220.3307@xanadu.home>
Message-ID: <4EB9FD65.3030900@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/08/11 11:08, Nicolas Pitre wrote:
>> +	.macro	senduart, rd, rx
>> +#ifdef CONFIG_MSM_HAS_DEBUG_UART_HS
>> +	@ Write the 1 character to UARTDM_TF
>> +	str	\rd, [\rx, #0x70]
>> +#else
>>  	teq	\rx, #0
>>  	strne	\rd, [\rx, #0x0C]
>> +#endif
>>  	.endm
> Why testing for zero in the #else part?  The upper level code should 
> never call this macro with a null byte.
>

Ok I poked into the git logs (thanks Bryan). It was first introduced in
bcc0f6a ([ARM] msm: clean up iomap and devices, 2008-09-10). It seems
that debug_ll support on MSM at the time had to remove the virtual
mapping for the uart base. Thus when the MMU was enabled the addruart
macro returned 0 and the senduart macro would test for 0 so that
senduart could disable debug_ll when the MMU was enabled. Something
about "problems with the peripheral window".

Later on, the virtual mapping was added back in 6339f66 (msm: make
debugging UART (for DEBUG_LL) configurable, 2009-11-02) but the patch
forgot to remove the teq. So as it stands the teq has been useless for
two years.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
