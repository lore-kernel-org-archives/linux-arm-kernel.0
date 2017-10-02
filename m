From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 2 Oct 2017 18:26:04 +0100
Subject: [PATCH v2] arm64: dts: foundation-v8: Enable PSCI mode
In-Reply-To: <9a542b9a-3c37-ed8a-04e6-de41493f4b0d@linaro.org>
References: <20170918153832.16356-1-daniel.thompson@linaro.org>
 <20170919183204.12751-1-daniel.thompson@linaro.org>
 <da8a0cf5-3c1e-1398-b5c3-ac489ae955fa@arm.com>
 <9a542b9a-3c37-ed8a-04e6-de41493f4b0d@linaro.org>
Message-ID: <e49177f9-a9a8-e322-3743-5c58277c46ea@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry for late response, I thought I had sent this mail out long back
but was sitting in my draft :(

On 20/09/17 12:17, Daniel Thompson wrote:
> On 20/09/17 10:42, Sudeep Holla wrote:
>>
>>
>> On 19/09/17 19:32, Daniel Thompson wrote:
>>> Currently if the Foundation model is running ARM Trusted Firmware then
>>> the kernel, which is configured to use spin tables, cannot start
>>> secondary
>>> processors or "power off" the simulation.
>>>
>>> After adding a couple of labels to the include file and splitting out
>>> the
>>> spin-table configuration into a header, we add a couple of new headers
>>> together with two new DTs (GICv2+PSCI and GICv3+PSCI).
>>>
>>> The new GICv3+PSCI DT has been boot tested, the remaining three (two of
>>> which existed prior to this patch) have been "tested" by decompiling the
>>> blobs and comparing them against a reference.
>>>
>>
>> How different are these from the ones hosted in [1] ?
> 
> They look like they were either independently written or diverged a long
> time ago. The existing kernel DTs describe hardware absent from the ARM
> TF ones and vice versa.
> 

OK.

> With specific reference to PSCI it looks like my patches could perhaps
> be improved by adding idle-state support.
> 
> 

Yes I know.

>> On argument is that we want to take the DTS out of device tree as
>> firmware is responsible for generating them. Alternatively, we may be
>> duplicating resulting in discrepancies over time by coping it into
>> kernel.
> 
> The general problem is copying from where?
> 
> The kernel DTs are a well maintained centralized repository which is
> *really* useful. git grep across the kernel DTs is a hugely powerful
> tool when trying to better understand an ecosystem as sprawling and
> diverse as ARMs. In fact I've even seen those sort of searchs used as a
> basis to clean up unused code. Seeing that centralized repository
> splinter into separate per-vendor silos would be a huge loss for kernel
> developers.
> 

Agreed. But models are configurable and last time this discussion came
up, some argued that the DTs must be modified based on the configuration
automatically by models or some external scripts.
> 
>> Since users of ARM TF must be able to access these, I am not sure if it
>> makes sense to merge these. Or we remove it from ARM TF to avoid any
>> conflicts/discrepancies. >
>> Thoughts ?
> 
> I kind of agree that maintaining DTs and DT documentation in the kernel
> is a little odd given that the kernel is not the only player here
> (FreeBSD, u-boot, etc). However it is sufficiently well maintained that
> projects are content(ish) to regard the kernel as the canonical source
> for these things (u-boot, for example, seeks to shadow kernel DTs
> without modifying them).
> 

No argument there.

> However regardless of the above I'd say they should be removed from ARM
> TF. ARM TF does not use, modify, pass on or in any way consume DT... it
> has no skin in the game here. Why does it want to own a few of blobs for
> a small subset of the platforms it supports? I'm afraid that makes no
> sense to me, to the extent that it didn't even occur to me to *look* in
> the ARM TF sources to find any DTs for FVP until you pointed them out.
> 

Agreed, I can talk to TF guys if required.

> In other words, whilst people could discuss alternative ways to manage
> DTs[1], I can't see any universe where ARM TF would be a logical place
> to keep them.
> 
> [1] ... and I'd further suggest that only perhaps people who are
> ??? prepared to put resources into fixing it should convene such a
> ??? discussion.

While I agree with you, I am worried on the scalability. Models provide
tons of options(may not be foundation platform but for sure the base AEM
ones). It may so get unmanageable if we keep adding one DTS per
configuration.

If we are OK restricting the set of configurations to what you have
proposed, then it seems fine.

I will try to push this for v4.15, but I still want to hear more
opinions on the scalability part here.

-- 
Regards,
Sudeep
