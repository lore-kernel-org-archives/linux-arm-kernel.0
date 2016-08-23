From: John.Youn@synopsys.com (John Youn)
Date: Tue, 23 Aug 2016 11:37:47 -0700
Subject: [Bug] usb: dwc2: host function broken in OTG mode on bcm283x
In-Reply-To: <1408689388.21552.709cd5b7-97dd-4dda-9392-7c46ec5e192c.open-xchange@email.1und1.de>
References: <907297251.436328.d9cd30e0-7476-4a28-8bab-dde17515cd9c.open-xchange@email.1und1.de>
 <785fc063-9b72-84a9-db91-c2710c19cdf9@synopsys.com>
 <183575717.19886.709cd5b7-97dd-4dda-9392-7c46ec5e192c.open-xchange@email.1und1.de>
 <37db5022-b98c-7f26-ca77-3ee9ba664edf@synopsys.com>
 <1408689388.21552.709cd5b7-97dd-4dda-9392-7c46ec5e192c.open-xchange@email.1und1.de>
Message-ID: <a058e07d-ac9a-3e70-af7d-059d21875fba@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/22/2016 9:41 PM, Stefan Wahren wrote:
> Hi John,
> 
>> John Youn <John.Youn@synopsys.com> hat am 23. August 2016 um 00:08
>> geschrieben:
>>
>>
>> On 8/22/2016 1:47 PM, Stefan Wahren wrote:
>>> Hi John,
>>>
>>>> John Youn <John.Youn@synopsys.com> hat am 22. August 2016 um 22:06
>>>> geschrieben:
>>>>
>>>>
>>>> On 8/20/2016 6:03 AM, Stefan Wahren wrote:
>>>>> Hi John,
>>>>>
>>>>>
>>>>
>>>> Hi Stefan,
>>>>
>>>> Why doesn't DT work? I think all the properties are there to set
>>>> these.
>>>
>>> it only works for the future releases, not for existing DT blobs. The DT is
>>> part
>>> of the ABI.
>>>
>>> Yes, i already send a patch to fix the DT [1], but it would be better to fix
>>> the
>>> issue in deep.
>>
>> I don't know much about DT issues. So I'm not sure what the issue is
>> with this.The properties for the gadget fifo sizes already exist so
>> there's no change to the ABI, correct?
> 
> It's correct the ABI doesn't change, but it also means that newer kernel must
> work with older DTB files. So the fix should be better in the driver and not in
> the DT sources.
> 
>>
>> Also, the patch you linked doesn't seem to have settings for the FIFO
>> sizes.
> 
> It wouldn't make sense to provide gadget fifo sizes for a host-only setup. The
> mentioned patch doesn't really fix this issue, that's why i mentioned that we
> should fix this issue first.
> 
>>
>>>
>>>>
>>>> I hesitate to change the legacy/default settings in case it breaks any
>>>> existing drivers that depend on them.
>>>
>>> Platforms? I didn't expected that other drivers use these settings.
>>
>> Yes, I mean platforms.
>>
>> I believe these values were hard-coded since before the unified "dwc2"
>> existed. So for sure there are platforms using these settings and to
>> lower them will negatively impact those platforms. The DT properties
>> were introduced to override these.
> 
> Unfortunately the gadget fifo sizes should have been marked as required for OTG
> and gadget mode. But now it's too late. We only can improve DT binding here or
> at least add a warning during probe.
> 
>>
>> I think it is best to override them in the broken platforms. Either
>> that or fix it so that the defaults are more intelligently determined
>> in a way that maximizes the fifo sizes and cannot fail, as opposed to
>> some other arbitrary values.
>>
> 
> I don't have the knowledge for the second solution and i wouldn't prefer much
> more detection intelligence.
> 

How about we fall back to smaller defaults if the original values
fail? And don't configure more than the amount of endpoints.

That should take care of most of the cases. If an irregular
configuration shows up, require it to use the DT properties.

Regards,
John
