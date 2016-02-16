From: szabolcs.nagy@arm.com (Szabolcs Nagy)
Date: Tue, 16 Feb 2016 11:48:14 +0000
Subject: [PATCH] arm64: Add support for Half precision floating point
In-Reply-To: <20160128160022.GM775@arm.com>
References: <1453823566-26742-1-git-send-email-suzuki.poulose@arm.com>
 <20160126160257.GB28238@arm.com>
 <20160126161151.GE14823@e104818-lin.cambridge.arm.com>
 <20160128160022.GM775@arm.com>
Message-ID: <56C30C7E.1030005@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/01/16 16:00, Will Deacon wrote:
> On Tue, Jan 26, 2016 at 04:11:51PM +0000, Catalin Marinas wrote:
>> On Tue, Jan 26, 2016 at 04:02:58PM +0000, Will Deacon wrote:
>>> On Tue, Jan 26, 2016 at 03:52:46PM +0000, Suzuki K Poulose wrote:
>>>> +#define HWCAP_FPHP		(1 << 9)
>>>> +#define HWCAP_ASIMDHP		(1 << 10)
>>>
>>> Where did we get to with the mrs trapping you proposed here?
>>>
>>>   http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/374609.html
>>>
>>> At some point, we need to consider whether or not we want to continue
>>> adding new HWCAPs or whether your suggestion above is actually useful
>>> to userspace.
>>
>> IMO, even if we merge the MRS emulation, I would still like to see
>> HWCAPs exported. We are not short on bits yet (53 to go ;)).
> 
> I'm less keen. HWCAPs don't align well with the way that the ARM
> architecture versions features and we should be encouraging people to
> use the MRS emulation if it exists.
> 
>>> Did the libc guys get anywhere with a prototype? What do we need to do
>>> to make progress with it?
>>
>> This investigation should indeed continue but I think it is orthogonal.
> 
> Not if its intended to replace HWCAPs in the longterm.
> 

userspace needs HWCAP bits independently of the MIDR emulation.

MIDR cannot replace HWCAP:

- MIDR does not map to features in a future-proof way
  (we don't know which MIDR will indicate fp16 availability)

- MIDR would be useful for more fine-grained uarch specific
  tuning decisions, HWCAP is for arch extensions like fp16.

- We don't yet know if the proposed MIDR emulation solves
  all userspace issues we want it to solve. I'll try to
  investigate that as well as the alternative VDSO based
  approach (if VDSO can work, that would be better for
  userspace). There are nasty issues here so the conclusion
  might take a while, but that should not hold up HWCAPs.

thanks
