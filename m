From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 3 Oct 2017 11:15:35 +0100
Subject: [PATCH v2] arm64: dts: foundation-v8: Enable PSCI mode
In-Reply-To: <8c4a4114-b7f7-301e-20b8-960e6234b661@linaro.org>
References: <20170918153832.16356-1-daniel.thompson@linaro.org>
 <20170919183204.12751-1-daniel.thompson@linaro.org>
 <da8a0cf5-3c1e-1398-b5c3-ac489ae955fa@arm.com>
 <9a542b9a-3c37-ed8a-04e6-de41493f4b0d@linaro.org>
 <e49177f9-a9a8-e322-3743-5c58277c46ea@arm.com>
 <8c4a4114-b7f7-301e-20b8-960e6234b661@linaro.org>
Message-ID: <CAKv+Gu9dN8173b5cqBAw2kMNQvmf+qTO8Z=sJQveJQ_DgTOuDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 October 2017 at 10:12, Daniel Thompson <daniel.thompson@linaro.org> wrote:
> On 02/10/17 18:26, Sudeep Holla wrote:
>>
>> Sorry for late response, I thought I had sent this mail out long back
>> but was sitting in my draft :(
>
>
> No worries. I've been at Linaro connect this last week anyway.
>
>
>> On 20/09/17 12:17, Daniel Thompson wrote:
>>>
>>> On 20/09/17 10:42, Sudeep Holla wrote:
>>>>
>>>>
>>>>
>>>> On 19/09/17 19:32, Daniel Thompson wrote:
>>>>>
>>>>> Currently if the Foundation model is running ARM Trusted Firmware then
>>>>> the kernel, which is configured to use spin tables, cannot start
>>>>> secondary
>>>>> processors or "power off" the simulation.
>>>>>
>>>>> After adding a couple of labels to the include file and splitting out
>>>>> the
>>>>> spin-table configuration into a header, we add a couple of new headers
>>>>> together with two new DTs (GICv2+PSCI and GICv3+PSCI).
>>>>>
>>>>> The new GICv3+PSCI DT has been boot tested, the remaining three (two of
>>>>> which existed prior to this patch) have been "tested" by decompiling
>>>>> the
>>>>> blobs and comparing them against a reference.
>>>>>
>>>>
>>>> How different are these from the ones hosted in [1] ?
>>>
>>>
>>> They look like they were either independently written or diverged a long
>>> time ago. The existing kernel DTs describe hardware absent from the ARM
>>> TF ones and vice versa.
>>>
>>
>> OK.
>>
>>> With specific reference to PSCI it looks like my patches could perhaps
>>> be improved by adding idle-state support.
>>
>>
>> Yes I know.
>
>
> You want a v3 with it added?
>
>
>>>> On argument is that we want to take the DTS out of device tree as
>>>> firmware is responsible for generating them. Alternatively, we may be
>>>> duplicating resulting in discrepancies over time by coping it into
>>>> kernel.
>>>
>>>
>>> The general problem is copying from where?
>>>
>>> The kernel DTs are a well maintained centralized repository which is
>>> *really* useful. git grep across the kernel DTs is a hugely powerful
>>> tool when trying to better understand an ecosystem as sprawling and
>>> diverse as ARMs. In fact I've even seen those sort of searchs used as a
>>> basis to clean up unused code. Seeing that centralized repository
>>> splinter into separate per-vendor silos would be a huge loss for kernel
>>> developers.
>>>
>>
>> Agreed. But models are configurable and last time this discussion came
>> up, some argued that the DTs must be modified based on the configuration
>> automatically by models or some external scripts.
>
>
> Indeed. I can definitely understand why the *models* might want
> to be bundled with DTs (or a DT generator, or a
> --just-give-me-a-working-dt-for-my-command-line-options-option).
>
>

The UEFI firmware for the FVP models does implement automatic
selection between a variety of builtin DTBs. I.e., FVP base or
foundation model, with either GICv2 for GICv3. I think the maintainer
of the binary releases chose not to enable this in the builds he
distributes, but it is certainly unnecessary to fiddle with DT images
if you build the firmware yourself (but you need to set DTB_DIR when
building)
