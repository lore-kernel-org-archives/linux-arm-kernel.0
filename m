From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 25 Apr 2013 16:25:52 -0700
Subject: [PATCHv2 1/4] Documentation: Add memory mapped ARM architected
 timer binding
In-Reply-To: <5179B6ED.9000301@gmail.com>
References: <1365812863-5367-1-git-send-email-sboyd@codeaurora.org>
 <1365812863-5367-2-git-send-email-sboyd@codeaurora.org>
 <516C6F12.5020208@gmail.com> <516C7231.6060305@codeaurora.org>
 <5179A488.5050102@gmail.com> <5179B2B2.8000201@codeaurora.org>
 <5179B6ED.9000301@gmail.com>
Message-ID: <5179BB80.9060405@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/25/13 16:06, Rob Herring wrote:
> On 04/25/2013 05:48 PM, Stephen Boyd wrote:
>
>> We don't really care about CNTFRQ because it's duplicated into each
>> view. We do care about CNTNSAR. Luckily the spec "just works" there in
>> the sense that we can use CNTTIDR in conjunction with CNTACRn and
>> determine if we have access to a frame we're interested in if the
>> CNTTIDR bits say the frame is present and the CNTACRn register says we
>> can access it. If not then it must be locked down for secure users.
>>
>> Unfortunately hardware doesn't have a way to say that a particular frame
>> is reserved for the hypervisor or the guest kernel/userspace. We need
>> some help from software, so we have the status property express that a
>> particular frame is available. We have to assume the DT is going to be
>> different depending on if you're the hypervisor or the guest. That's a
>> valid assumption right? Otherwise I hope we can do some trapping of the
>> guest's mapping to the control base and then rewrite what they read so
>> that they only see the frame that we want to be available to them.
> Yeah, I believe the only way to prevent access within non-secure world
> is with the MMU. So I guess the example is just policy that the
> hypervisor would/may not create a stage2 mapping. You still have the
> same issue that the guest should not be passed the control base. You
> could make the reg property optional, but then what do you do with the
> node name?

I don't follow. Why shouldn't we tell the guest about the hardware
that's there? Shouldn't they be able to safely assume they can access
the control base just like a non-guest kernel running in PL1 would be
able to?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
