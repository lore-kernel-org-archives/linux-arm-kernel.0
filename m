From: rnayak@ti.com (Rajendra Nayak)
Date: Wed, 16 May 2012 10:54:57 +0530
Subject: [PATCHv4 4/8] ARM: OMAP4: hwmod: flag hwmods/modules supporting
 module level context status
In-Reply-To: <87pqa5axuo.fsf@ti.com>
References: <1334913591-26312-1-git-send-email-t-kristo@ti.com>	<1334913591-26312-5-git-send-email-t-kristo@ti.com>	<4F957ACD.2040103@ti.com>
 <1335278815.2149.93.camel@sokoban>	<4F96DF8C.6040400@ti.com>
 <87pqa5axuo.fsf@ti.com>
Message-ID: <4FB33A29.4030404@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 16 May 2012 03:52 AM, Kevin Hilman wrote:
> "Cousson, Benoit"<b-cousson@ti.com>  writes:
>
>> On 4/24/2012 4:46 PM, Tero Kristo wrote:
>>> On Mon, 2012-04-23 at 10:52 -0500, Jon Hunter wrote:
>>>> Hi Tero,
>>>>
>>>> On 04/20/2012 04:19 AM, Tero Kristo wrote:
>>>>> From: Rajendra Nayak<rnayak@ti.com>
>>>>>
>>>>> On OMAP4 most modules/hwmods support module level context status. On
>>>>> OMAP3 and earlier, we relyed on the power domain level context status.
>>>>> Identify all such modules using a 'HWMOD_CONTEXT_REG' flag, all such
>>>>> hwmods already have a valid 'context_offs' populated in .prcm structure.
>>>>
>>>> Is it necessary to add another flag? Can't we just check if context_offs
>>>> is non-zero? Would save adding a lot more lines to an already large file
>>>> :-)
>>>
>>> Actually one of the older versions of this patch was just checking
>>> against a non-zero value, but it was decided to be changed as
>>> potentially the context_offs can be zero even if it is a valid offset.
>
> Potentially?  Is that the case on OMAP4/5 today?  I don't see any for
> OMAP4 in mainline.

No, we don;t have any such cases today in either OMAP4 or OMAP5.

>
> If zero really is a valid offset somewhere (where?), then we could use
> -1 (or USHRT_MAX in this case.)

This makes sense for OMAP4 and beyond (and same with having a flag
to indicate the *lack* of having the feature) as it will mean just
adding a few entries in hwmod data files to indicate IP blocks (very
few) which do not support this feature.

However since none of OMAP2/3 varients (except I guess the AMxxxx
family) support this, it would also mean we mark
*most* blocks in OMAP2/3 to indicate they *lack* this feature, which
would mean bloating the OMAP2/3 data files, but your
comment below about doing it for all IPs during hwmod registration
makes sense at least for OMAP2 since *all* blocks can be marked at
registration. OMAP3 would probably need more data files to be updated
to indicate which ones support and which ones don't.

Having said that I also see 'context_reg' being defined inside
omap_hwmod_omap4_prcm would need to be fixed if we have to
support this for SoCs which fall as OMAP3 varients.

>
>> Yeah, but still, every OMAP4 IPs are supporting that except two of
>> them I guess, so it is a pity to add that to every IPs.
>>
>> We'd better add a HWMOD_NO_CONTEXT_REG to the few IPs that are not
>> supporting that. Since OMAP 2&  3 does not have this feature at all,
>> we can check on the cpu revision.
>>
>> I think the issue raised by Rajendra was about AM35xx that looks like
>> an OMAP3 variant but does have these registers like an OMAP4
>> variant:-(
>
> If AM335x is missing it for *all* IPs, that's easy enough to solve
> without bloating the data file: just set .context_offs field (or flag)
> to the magic value for all IPs during hwmod registration.
>
> Paul/Benoit should make the call whether to use a special value in the
> .context_offs field (0 or -1) or add a new flag.  If a flag is chosen, I
> agree with Benoit that it should indicate the *lack* of the feature,
> since having the feature is the norm.
>
> Kevin
>
