From: ylmao@marvell.com (Yilu Mao)
Date: Thu, 26 Apr 2012 18:09:26 +0800
Subject: [PATCH] ARM: cache-l2x0.c: save aux ctrl for resume in case that
 l2x0 is enabled before init
In-Reply-To: <20120426094400.GD18136@arm.com>
References: <1335235280-25148-1-git-send-email-ylmao@marvell.com>
 <20120424082810.GA9367@arm.com> <4F98D659.4030709@marvell.com>
 <20120426083554.GB18136@arm.com> <4F99148B.4020900@marvell.com>
 <20120426094400.GD18136@arm.com>
Message-ID: <4F991ED6.8060109@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/26/2012 05:44 PM, Catalin Marinas wrote:
> On Thu, Apr 26, 2012 at 10:25:31AM +0100, Yilu Mao wrote:
>> On 04/26/2012 04:35 PM, Catalin Marinas wrote:
>>> On Thu, Apr 26, 2012 at 06:00:09AM +0100, Yilu Mao wrote:
>>>> On 04/24/2012 04:28 PM, Catalin Marinas wrote:
>>>>> On Tue, Apr 24, 2012 at 03:41:20AM +0100, Yilu Mao wrote:
>>>>>> +	l2x0_saved_regs.aux_ctrl = aux;
>>>>>> +
>>>>>>     	aux&= aux_mask;
>>>>>>     	aux |= aux_val;
>>>>>
>>>>> I think that's the wrong place to save it, it should be after the
>>>>> masking was done.
>>>>>
>>>>> Anyway, if we cannot write this register in l2x0_init() because the L2
>>>>> was enabled, do we expect the L2 to be disabled during resume?
>>>>>
>>>> Sorry, I don't think so.
>>>> This is the right place to save it because we must make sure the saved
>>>> aux_ctrl is the same as what it is set.
>>>> If we save it after masking was done, the saved value will be different
>>>> because we can't actually change the real setting.
>>>
>>> And since we can't actually change the real setting on the resume path,
>>> why do we need to save it anyway. Is your L2 cache disabled on the
>>> resume path but not on the cold boot one?
>>
>> We can't change L2 aux ctrl setting when do init because it has been
>> enabled.
>
> This is normally for the case where the kernel running in non-secure
> mode is not allowed to write the L2 aux ctrl register. Does this
> permission change with core idle?
>
Yes, your understanding of previous mail is right. The L2 is enabled on 
code boot and it is disabled on the resume in our case.
So if we don't have such patch, when core idle exit, L2 cache aux ctrl 
register will be set to 0x0 because l2x0_saved_regs.aux_ctrl is not 
initialized.

-- 
Thanks.

Best Wishes,
Yilu Mao
