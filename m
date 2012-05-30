From: b-cousson@ti.com (Cousson, Benoit)
Date: Wed, 30 May 2012 14:16:53 +0200
Subject: [RFC PATCH 11/11] ARM: DT: Add support to system control module
 for OMAP4
In-Reply-To: <20120530104253.GB3261@besouro>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
 <1337934361-1606-12-git-send-email-eduardo.valentin@ti.com>
 <4FC49BA5.5050008@dev.rtsoft.ru> <4FC5DC9F.7080104@ti.com>
 <4FC5E2EE.8030504@dev.rtsoft.ru> <4FC5E7DE.2060905@ti.com>
 <4FC5F3C3.2000309@dev.rtsoft.ru> <4FC5F4F9.6020106@ti.com>
 <20120530104253.GB3261@besouro>
Message-ID: <4FC60FB5.9050804@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/30/2012 12:42 PM, Eduardo Valentin wrote:
> Hello,
>
> On Wed, May 30, 2012 at 12:22:49PM +0200, Cousson Benoit wrote:
>> On 5/30/2012 12:17 PM, Konstantin Baydarov wrote:
>>>    Hi.
>>> On 05/30/2012 01:26 PM, Cousson, Benoit wrote:
>>>> On 5/30/2012 11:05 AM, Konstantin Baydarov wrote:
>>>>> On 05/30/2012 12:38 PM, Cousson, Benoit wrote:
>>>>>> On 5/29/2012 11:49 AM, Konstantin Baydarov wrote:
>>>>>>> Hi, Eduardo.
>>>>>>>
>>>>>>> On 05/25/2012 12:26 PM, Eduardo Valentin wrote:
>>>>>>>> This patch add device tree entries on OMAP4 based boards for
>>>>>>>> System Control Module (SCM).
>>>>
>>>> ...
>>>>
>>>>>>> I believe that CPU-specific bandgap definition should be moved to
>>>>>>> bard specific dts.
>>>>>>
>>>>>> Mmm, why, since it is CPU specific and not board specific. I has to
>>>>>> be in the SoC file.
>>>>> Speaking about omap4430 - omap4430 bandgap differs from omap4460, so
>>>>> if omap4430 bandgap support will be added to omap-bandgap driver the
>>>>> version of bandgap should specified in dts file. omap4.dtsi is a
>>>>> common for omap4 boards, that is why I'm suggesting to move bandgap
>>>>> description to probably board specific file.
>>>>
>>>> OK, I got your point, but in that case we could potentially define a omap4460.dtsi file.
>>>>
>>>>> Another solution is to
>>>>> determine bandgap type in driver probe function, but in that case
>>>>> "ti,omap4460-bandgap" in omap4.dtsi should be replaced to
>>>>> "ti,omap4-bandgap".
>>>>
>>>> Yes, this is the best solution, but that assume that we can identify the control module version from the HW, which is not necessarily true :-(
>>>>
>>>> The IP_REVISION (offset = 0) value are unfortunately not documented, so we should read it to check if they are different from omap4430 and 4460.
>>>>
>>>> The bitfield layout in that register is:
>>>>
>>>> IP_REV_MAJOR: 8..10
>>>> IP_REV_CUSTOM: 6..7
>>>> IP_REV_MINOR: 0..5
>
> I have the weird deja vu feeling...

I know :-)

> The DT entry I sent, I already knew it would cause troubles :-)
> Having it per board it would be really a PITA. Image that every
> body doing a 4430 board needs to define a BG entry...
> That would work, but still do we want this?

No, in fact I do not want to do that if we can avoid it.

> Benoit, I guess you should know my option by now.
> Ideally we should rely on revision register to decide what to do in the driver.
> And as we discussed, looks like for BG this is somewhat non-existing.

Oops, sorry I was thinking about the SCM revision :-(

The register seems to be there with the layout detailed before. I just 
do not have a clue about the value we should expect. That's why we have 
to read it on both 4430 and 4460 to check if some bits are different.

> If we go with the SCM revision register, what do we do if the BG goes away from SCM?

Yeah, good point.
But, if at some point the BG becomes a real IP with an OCP port, then we 
will have a TI wrapper on top of it with the proper revision register... 
at least in theory :-)

> If we go with "ti,omap4-bandgap", we still need a way to say if it is 4430, 4460 or 4470.

Yeah, so we should check if at least that SCM revision field is meaningful.

> There are configuration / settings specific for each. Not only on bandgap,
> but also wrt to sensor location and hotspot extrapolation rules.

Assuming the SCM version is usable we can extract from that some SW 
revision for each sub IP.
But it is still not clear how the children will be aware of the parent 
revision :-(
Exported a get_scm_revision is doable potentially.

> Because we lack a revision register for bandgap, one way to go is to have still the
> revisioning on the same way: "ti,omapXXXX-bandgap", but having a omapXXXX.dtsi
> per omap revision. But do we want to this only due to bandgap?
> BTW, is it only BG which is suffering of this issue?

Mmm, probably not, that being said, SCM is probably the worst IP we have 
on OMAP :-)

Regards,
Benoit


>>> Probably, cpu_is_omap443x() and cpu_is_omap446x() can be used in bandgap driver probe function. Actually many drivers use cpu_is_omap*():
>
>
> No please! Let's not use that stuff...
>
>>
>> No, we cannot, we are in the process of getting rid of that.
>> A driver should only focus on the IP version in theory. The CPU
>> version is not the proper way of getting that. It will make the
>> driver not scalable at all for future OMAP revision.
>>
>>> drivers/mfd/omap-usb-host.c
>>> drivers/mfd/twl-core.c
>>
>> Yeah, these are the ones that still need to be fixed...
>
> agreed with Benoit here.
>
>>
>> Regards,
>> Benoit
