From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 17 Jan 2018 09:03:48 +0000
Subject: [PATCH RFC v1] arm64: Handle traps from accessing CNTVCT/CNTFRQ
 for CONFIG_COMPAT
In-Reply-To: <20180117021346.GA26166@Asurada-Nvidia>
References: <1515645816-14063-1-git-send-email-nicoleotsuka@gmail.com>
 <e750e380-f06b-dbbf-a61c-4281c0168b05@arm.com>
 <20180116203218.GA6318@Asurada-Nvidia> <86r2qpec32.wl-marc.zyngier@arm.com>
 <20180116213745.GA9545@Asurada-Nvidia>
 <20180117021346.GA26166@Asurada-Nvidia>
Message-ID: <83b9c187-7fbf-3e05-6321-de7fa05fd868@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/01/18 02:13, Nicolin Chen wrote:
> On Tue, Jan 16, 2018 at 01:37:46PM -0800, Nicolin Chen wrote:
>> On Tue, Jan 16, 2018 at 09:19:13PM +0000, Marc Zyngier wrote:
>>
>>>> I understand that it should take care of the condition field as
>>>> a general instruction handler. Just for curiosity: If we confine
>>>> the topic to read access of CNTVCT/CNTFRQ, what'd be the penalty
>>>> by ignoring the condition field and executing it anyway?
>>>
>>> Do you mean, apart from severely corrupting userspace execution?
>>> That's a rhetorical question, right?
>>
>> I don't quite understand the corrupting userspace execution part.
>> What I see for a conditional CNTVCT read is more likely:
>> 	if (condition) {	// in this case, if (true)
>> 		r1 = lower32(cntvct);
>> 		r2 = higher32(cntvct);
>> 	}
>>
>> Could you please elaborate a bit? Thank you.
> 
> I guess I got it now. The concern seems to be Thumb instructions.

Not only.

> So ignoring a condition for a Thumb instruction may cause its IT
> scope shifting. For ARM mode, the only penalty could be two Rts
> getting written -- which shouldn't corrupt userspace execution.
> 
> Please correct me if I am wrong or not thorough.

Consider the following:
	
	mov	r0, #0
	mov	r1, #0
	cmp	r1, #3
	mrrceq	r0, r1, cntvct // simplified version

Oh look, you've corrupted r0 and r1, which should never have be changed.
Whatever uses the content r0 and r1 after the mrrc will misbehave. How
is that an acceptable behaviour? How do you expect userspace to cope
with such a brain damage?

If you intend to emulate the CPU, you must emulate it fully, to the
letter of the architecture. No ifs, no buts.

	M.
-- 
Jazz is not dead. It just smells funny...
