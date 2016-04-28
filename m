From: Yisen.zhuang@huawei.com (Yisen Zhuang)
Date: Thu, 28 Apr 2016 09:45:31 +0800
Subject: [PATCH v2 net-next 11/13] Documentation: Bindings: Update DT
 binding for separating dsaf dev support
In-Reply-To: <CAL_JsqLHrHWtiikSt7F39LoExoL2aep5Pqax5cGWWBw-yhz79g@mail.gmail.com>
References: <1461402317-136499-1-git-send-email-Yisen.Zhuang@huawei.com>
 <1461402317-136499-12-git-send-email-Yisen.Zhuang@huawei.com>
 <20160426124847.GA26682@rob-hp-laptop> <57203309.1090501@huawei.com>
 <CAL_JsqLHrHWtiikSt7F39LoExoL2aep5Pqax5cGWWBw-yhz79g@mail.gmail.com>
Message-ID: <57216B3B.8000306@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

Thanks for you comments.

? 2016/4/27 23:25, Rob Herring ??:
> On Tue, Apr 26, 2016 at 10:33 PM, Yisen Zhuang <Yisen.zhuang@huawei.com> wrote:
>> Hi Rob and David,
>>
>> Please see my comments inline.
>>
>> David have merged this series to net-next, but we need to modify some codes according
>> to Rob's comments. I am not sure if i need to send V3 for this series, or separate
>> patches of documentation to independent series and generate a new patch for hns base
>> on current net-next?
> 
> That's David's call. I'm guessing he wants follow-up patches on top of these.

Okay, I will send a new series base on current net-next.

> 
>> ? 2016/4/26 20:48, Rob Herring ??:
>>> On Sat, Apr 23, 2016 at 05:05:15PM +0800, Yisen Zhuang wrote:
>>>> Because debug dsaf port was separated from service dsaf port, this patch
>>>> updates the related information of DT binding.
>>>
>>> Separated when? New version of the h/w? If so, where's the new
>>> compatible string? This is quite a big binding change.
>>
>> There isn't any change of h/w. I separated debug dsaf port from sevice dsaf
>> port to make the code more simple and readability.
> 
> Okay.
> 
> [...]
> 
>>>> +  serdes-syscon rather than this address.
>>>>    The third region is the PPE register base and size.
>>>> -  The fourth region is dsa fabric base register and size.
>>>> -  The fifth region is cpld base register and size, it is not required if do not use cpld.
>>>> -- phy-handle: phy handle of physicl port, 0 if not any phy device. see ethernet.txt [1].
>>>> +  The fourth region is dsa fabric base register and size. It is not required for
>>>> +  single-port mode.
>>>> +- reg-names: may be ppe-base and(or) dsaf-base. It is used to find the
>>>> +  corresponding reg's index.
>>>
>>> But you have up to 5 regions.
>>>
>>> The variable nature of what regions you have tells me you need more
>>> specific compatible strings for each chip.
>>
>> we didn't add support of new h/w. We added these regions to make code simple and readability.
>> If we need to add support of next h/w version next time, we don't need to add many branches
>> for these attributes. So we didn't add a new compatible here.
> 
> Not sure what you mean by branches. It's fine to put properties for
> things that vary among h/w versions, but new compatible strings will
> be needed for any new versions.

I mean than we put properties for things that vary among h/w versions. If we add support for
new h/w versions next time, we will add new compatible strings.

> 
> 
>>>> +- port: subnodes of dsaf. A dsaf node may contain several port nodes(Depending
>>>> +  on mode of dsaf). Port node contain some attributes listed below:
>>>> +- port-id: is physical port index in one dsaf.
>>>
>>> Indexes should generally be avoided. What does the number correspond
>>> to in h/w (if anything)?
>>
>> port-id is index for a port in dsaf, it is correspond to index of PHY showed below.
> 
> Okay, you should use reg property here instead.

Agree, thanks.

> 
>>
>>                                                          CPU
>>                                                           |
>>                                     -----------------------------------
>>                                     |                     |           |
>>     ----------------------------------------------    ---------   ---------
>>     |                         |                  |    |       |   |   |   |
>>     |                        PPE                 |    |  PPE  |   |  PPE  |
>>     |                         |                  |    |   |   |   |   |   |
>>     |                         |                  |    |   |   |   |   |   |
>>     |                      crossbar              |    |   |   |   |   |   |
>>     |                         |                  |    |   |   |   |   |   |
>>     |   ----------------------------------       |    |   |   |   |   |   |
>>     |   |     |     |      |      |      |       |    |   |   |   |   |   |
>>     |   |     |     |      |      |      |       |    |   |   |   |   |   |
>>     |  MAC   MAC   MAC    MAC    MAC    MAC      |    |  MAC  |   |  MAC  |
>>     |   |     |     |      |      |      |       |    |   |   |   |   |   |
>>     ----------------------------------------------    ---------   ---------
>>         |     |     |      |      |      |    \        /  |        /  |
>>        PHY   PHY   PHY    PHY    PHY    PHY    \      /  PHY      /  PHY
>>                                                 \    /           /
>>                                                  \  /           /
>>                                              DSAF(three platform device)
>>
>>>
>>>> +- phy-handle: phy handle of physicl port. It is not required if there isn't
> 
> Another typo here.

Agree, thanks.

> 
> Rob
> 
> .
> 
