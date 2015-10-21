From: andre.przywara@arm.com (Andre Przywara)
Date: Wed, 21 Oct 2015 11:01:30 +0100
Subject: [PATCH] EDAC: Add AMD Seattle SoC EDAC
In-Reply-To: <20151021093536.GA3575@pd.tnic>
References: <1445282597-18999-1-git-send-email-brijeshkumar.singh@amd.com>
 <20151019205236.GB453@leverpostej> <56266F7E.6030404@amd.com>
 <20151020165744.GE31130@pd.tnic> <20151020172654.GC4943@leverpostej>
 <20151020173639.GH31130@pd.tnic> <5626F09F.4050107@huawei.com>
 <20151021093536.GA3575@pd.tnic>
Message-ID: <5627627A.9010906@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 21/10/15 10:35, Borislav Petkov wrote:
> On Wed, Oct 21, 2015 at 09:55:43AM +0800, Hanjun Guo wrote:
>> So I think the meaning of those error register is the same, but the way
>> of handle it may different from SoCs, for single bit error:
>>
>>  - SoC may trigger a interrupt;
>>  - SoC may just keep silent so we need to scan the registers using poll
>>    mechanism.
>>
>> For Double bit error:
>>   - SoC may also keep silent
>>   - Trigger a interrupt
>>   - Trigger a SEI (system error)
>>
>> Any suggestion to cover those cases?
> 
> Well, I guess we can implement all those and have them configurable
> in the sense that a single driver loads, it has all functionality and
> dependent on the vendor detection, it does only what the vendor wants
> like trigger an interrupt or remain silent or ...

I guess the firmware (running in EL3) will take precedence over this
driver anyway, so we could just optimistically implement all errors, as
the driver will just never see errors that are handled in firmware (?)
In case of a critical error for instance I expect the firmware to never
return to EL1.

> 
> Btw, in talking about this with Andre last night, he had the suggestion
> that this functionality is also in other implementations besides A57 so
> maybe the driver should be called arm_cortex_edac...

Yeah, so looking at the A-72 and the A-53 TRM I see those registers to
be there as well. The A-72 and the A-57 versions look identical to me,
the A-53 version is only slightly different, but apparently still
compatible.
So I'd suggest to let this driver load on detecting all three MIDRs.
Should later revisions of any of those parts change the register
meaning, we could add a blacklist or specific MIDR detection.

But let's just not assume the worst in the first place ;-)

Cheers,
Andre.
