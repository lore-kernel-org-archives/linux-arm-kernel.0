From: s-anna@ti.com (Suman Anna)
Date: Wed, 10 Aug 2016 17:44:48 -0500
Subject: [PATCH 1/2] remoteproc: core: Add rproc OF look-up functions
In-Reply-To: <20160810211947.GW26240@tuxbot>
References: <20160719154905.23344-1-lee.jones@linaro.org>
 <20160810174049.GO26240@tuxbot> <7650e5fa-f52c-1ab5-e197-8630fd7d0322@ti.com>
 <20160810204049.GV26240@tuxbot> <f9641050-0a3f-11de-fa69-e587034e0527@ti.com>
 <20160810211947.GW26240@tuxbot>
Message-ID: <b1a01567-7a5d-20de-a2b5-b673b9ce67ec@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10/2016 04:19 PM, Bjorn Andersson wrote:
> On Wed 10 Aug 14:04 PDT 2016, Suman Anna wrote:
> 
>> On 08/10/2016 03:40 PM, Bjorn Andersson wrote:
>>> On Wed 10 Aug 12:37 PDT 2016, Suman Anna wrote:
>>>
>>>> Hi Lee, Bjorn,
>>>>
>>>> On 08/10/2016 12:40 PM, Bjorn Andersson wrote:
>>>>> On Tue 19 Jul 08:49 PDT 2016, Lee Jones wrote:
>>>>>
>>>>>> - of_rproc_by_index(): look-up and obtain a reference to a rproc
>>>>>>                        using the DT phandle "rprocs" and a index.
>>>>>>
>>>>>> - of_rproc_by_name():  lookup and obtain a reference to a rproc
>>>>>>                        using the DT phandle "rprocs" and "rproc-names".
>>>>>>
>>>>>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>>>>>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>>>>>> ---
>>>>>
>>>>> I'm happy with this, so I whipped up a binding document describing our
>>>>> two new properties. Waiting for an opinion on that before I merge this.
>>>>
>>>> Yeah, I like the two new API too, I have just about run into the need
>>>> for the same on my product trees. We can probably make it less
>>>> complicated than what the current series is. The wkup_m3_ipc usage was
>>>> before there was any standardization on the property names, so we went
>>>> with a ti, prefixed property specific to the wkup_m3_ipc node and a
>>>> general API that is agnostic of property name. We don't have all the
>>>> pieces for PM on AM335x/AM437x SoCs on upstream kernel yet, so we should
>>>> be able to switch over to using the new property as we cannot achieve
>>>> the desired functionality even though we can boot the wkup_m3.
>>>>
>>>
>>> Glad to hear you're onboard with dropping the old property name, even if
>>> it's later.
>>>
>>>> Here's what I propose:
>>>> 1. Let's not burden the new of_get_rproc_by_index() API with having to
>>>> fall-back and look for ti,rprocs. The rproc_get_by_phandle() core logic
>>>> of looking up against the rproc list is self-contained, and the API
>>>> usage is limited to just the wkup_m3_ipc driver at the moment.
>>>> 2. Keep the rproc_get_by_phandle API as is but mark it as deprecated.
>>>> IMHO, the rename of this API to of_get_rproc_by_phandle() in Patch 2 but
>>>> using a device node pointer as input argument doesn't add any value.
>>>> 3. Provide a fallback in wkup_m3_ipc driver to look for both rprocs and
>>>> ti,rproc property, while switching over the node to use rprocs property.
>>>> 4. We can get rid of the rproc_get_by_phandle() API after the
>>>> wkup_m3_ipc transition is done to use of_get_rproc_by_index() API.
>>>>
>>>
>>> I don't fancy the idea of leaving the kernel builds with a deprecation
>>> warning for some time and I don't feel the cost of carrying those 2
>>> extra statements is a bigger issue than keeping a deprecated API around.
>>> And it will be less than the dance we have to do in wkup_m3_ipc.
>>>
>>> So I think that we should merge these patches and if it can be concluded
>>> that we don't need backwards compatibility with the old DT property we
>>> can drop the inner conditional in the API.
>>
>> Yeah, I am fine with dropping the inner ti,rproc processing in the new
>> of_rproc_get_by_index() API and keeping it clean. What's not clear to me
>> is why we would still need a get_by_phandle API alongside the two new
>> API once the wkup_m3_ipc is converted to the new API?  Or is it just to
>> clean up the consumer interface? If latter, I will fixup the wkup_m3_ipc
>> driver without the need for remoteproc core changes, and switch over to
>> the new API.
>>
> 
> of_get_rproc_by_phandle() is just a convenience for not having to get by
> index 0, as most drivers is only having one rproc.

OK, then better to name this as simply of_rproc_get(), the _by_phandle()
does not match up with the other two of_get_rproc_xxx API.
Suggest also a rename from of_get_rproc_xxx to of_rproc_get_xxx like in
other subsystems.

> 
> As far as cleaning up wkup_m3_ipc, patch 2 does that and cleans out the
> old implementation and with that wkup_m3_ipc is moved to the new API.
> 
> So the only issue is that the wkup_m3_ipc DT binding states that the
> property should be named "ti,rproc" and as such someone has to send a
> patch to that and make an argument that we don't have to maintain
> backwards compatibility. But as this is used in am33xx.dtsi and
> am4372.dtsi that might be too late?

I could fix up the wkup_m3_ipc driver using of_update_property() /
of_remove_property(), but looks like these are not exported. I am not
sure if there are any specific reasons as to why these were not
exported. So, for now, we may have to go with the current code.

Tony,
Do you have any issues with us switching to the new properties in
wkup_m3_ipc nodes?

regards
Suman
