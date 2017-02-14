From: cov@codeaurora.org (Christopher Covington)
Date: Tue, 14 Feb 2017 18:43:06 -0500
Subject: [PATCH 1/2] tty: pl011: Work around QDF2400 E44 stuck BUSY bit
In-Reply-To: <5e18324f-d09d-d652-df23-d4a3f8f053fd@codeaurora.org>
References: <20170208005736.18724-1-cov@codeaurora.org>
 <bd4a0127-0f32-a8be-c8ee-34c1cccc6d5d@codeaurora.org>
 <6afb0a98-0973-33ec-0b76-fc6378e64309@codeaurora.org>
 <5e18324f-d09d-d652-df23-d4a3f8f053fd@codeaurora.org>
Message-ID: <5b771f8f-5a39-4c57-34a1-8e3f6d729a11@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/08/2017 06:04 PM, Timur Tabi wrote:
> On 02/08/2017 04:22 PM, Christopher Covington wrote:
>>>> >> -    while (pl011_read(uap, REG_FR) & uap->vendor->fr_busy)
>>>> >> +    while ((pl011_read(uap, REG_FR) ^ uap->vendor->inv_fr)
>>>> >> +                        & uap->vendor->fr_busy)
>>> >
>>> > I really think the XOR logic needs to be documented wherever it's
>>> > used. It's just too confusing.
>> References such as the following for basic bit operations like
>> setting, clearing, and toggling are easy enough to come by.
>>
>> http://stackoverflow.com/questions/47981/how-do-you-set-clear-and-toggle-a-single-bit-in-c-c
> 
> I know what XOR does. I was thinking a more high-level comment would
> be appropriate. With E44, we want to ignore the BUSY bit and use TXFE
> instead. So was hoping to a comment that says that:
> 
> /* Normally, we poll until BUSY=0, but E44 says we should poll until
> TXFE=1 instead. So with E44, we set fr_busy to TXFE, but we have to
> invert it. */

Oh, yeah, that'd be good. I'll include better comments in v2.

Cheers,
Cov

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc. Qualcomm Technologies, Inc. is a member of the Code
Aurora Forum, a Linux Foundation Collaborative Project.
