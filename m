From: architt@codeaurora.org (Archit Taneja)
Date: Thu, 2 Feb 2017 15:26:15 +0530
Subject: [PATCH V7 3/4] drm/bridge: Add driver for GE B850v3 LVDS/DP++
 Bridge
In-Reply-To: <2955-5891d280-1-64686980@191354544>
References: <2955-5891d280-1-64686980@191354544>
Message-ID: <acc9dfbb-8a71-5c8c-5c22-bcbd65d5a317@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/01/2017 05:51 PM, Peter Senna Tschudin wrote:
>
> On 01 February, 2017 12:35 CET, Daniel Vetter <daniel@ffwll.ch> wrote:
>
>> On Wed, Feb 01, 2017 at 10:58:43AM +0000, Peter Senna Tschudin wrote:
>>> Hi Archit,
>>>
>>> On 01 February, 2017 10:44 CET, Archit Taneja <architt@codeaurora.org> wrote:
>>>
>>>>
>>>>
>>>> On 01/30/2017 10:35 PM, Jani Nikula wrote:
>>>>> On Sat, 28 Jan 2017, Peter Senna Tschudin <peter.senna@collabora.com> wrote:
>>>>>> On Thu, Jan 05, 2017 at 01:18:47PM +0530, Archit Taneja wrote:
>>>>>> Hi Archit,
>>>>>>
>>>>>> Thank you for the comments!
>>>>>>
>>>>>> [...]
>>>>>>>> +	total_size = (block[EDID_EXT_BLOCK_CNT] + 1) * EDID_LENGTH;
>>>>>>>> +	if (total_size > EDID_LENGTH) {
>>>>>>>> +		kfree(block);
>>>>>>>> +		block = kmalloc(total_size, GFP_KERNEL);
>>>>>>>> +		if (!block)
>>>>>>>> +			return NULL;
>>>>>>>> +
>>>>>>>> +		/* Yes, read the entire buffer, and do not skip the first
>>>>>>>> +		 * EDID_LENGTH bytes.
>>>>>>>> +		 */
>>>>>>>
>>>>>>> Is this the reason why you aren't using drm_do_get_edid()?
>>>
>>>>>>
>>>>>> Yes, for some hw specific reason, it is necessary to read the entire
>>>>>> EDID buffer starting from 0, not block by block.
>>>>>
>>>>> Hrmh, I'm planning on moving the edid override and firmware edid
>>>>> mechanisms at the drm_do_get_edid() level to be able to truly and
>>>>> transparently use a different edid. Currently, they're only used for
>>>>> modes, really, and lead to some info retrieved from overrides, some from
>>>>> the real edid. This kind of hacks will bypass the override/firmware edid
>>>>> mechanisms then too. :(
>>>>
>>>> It seems like there is a HW issue which prevents them from reading EDID
>>>> from an offset. So, I'm not sure if it is a hack or a HW limitation.
>>>
>>>>
>>>> One way around this would be to hide the HW requirement in the
>>>> get_edid_block func pointer passed to drm_do_get_edid(). This
>>>> would, however, result in more i2c reads (equal to # of extension
>>>> blocks) than what the patch currently does.
>>>>
>>>> Peter, if you think doing extra EDID reads isn't too costly on your
>>>> platform, you could consider using drm_do_get_edid(). If not, I guess
>>>> you'll miss out on the additional functionality Jani is going to add
>>>
>>>> in the future.
>>>
>>> My concern is that for almost one year now, every time I fix something
>>> one or two new requests are made. I'm happy to fix the driver, but I
>>> want a list of the changes that are required to get it upstream, before
>>> I make more changes. Can we agree on exactly what is preventing this
>>> driver to get upstream? Then I'll fix it.
>>
>> I think addressing this edid reading question post-merge is perfectly
>> fine. Aside, want to keep maintaing your stuff as part of the drm-misc
>> group, with the drivers-in-misc experiment?

The edid thing was only a suggestion. As Daniel said, it's okay to work on
it post merge.

Please do fix the minor comments I mentioned in the latest patch set. I'll
pull in the first 3 patches once Rob H gives an Ack on the DT bindings
patch. The 4th patch needs to go through the SoC maintainer.

Thanks,
Archit

>
> Yes, sure!
>
>> -Daniel
>> --
>> Daniel Vetter
>> Software Engineer, Intel Corporation
>> http://blog.ffwll.ch
>
>
>
>
>
>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
