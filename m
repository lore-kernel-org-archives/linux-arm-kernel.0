From: ckadabi@codeaurora.org (Channa)
Date: Thu, 08 Feb 2018 16:24:16 -0800
Subject: [PATCH 1/2] dt-bindings: Documentation for qcom,llcc
In-Reply-To: <CAHCPf3vt-ZCXgTfCZ-LSW3TSXAk5KBz3wCu-LuTOBdCB+sgGgw@mail.gmail.com>
References: <1516924513-20183-1-git-send-email-ckadabi@codeaurora.org>
 <1516924513-20183-2-git-send-email-ckadabi@codeaurora.org>
 <CAHCPf3vt-ZCXgTfCZ-LSW3TSXAk5KBz3wCu-LuTOBdCB+sgGgw@mail.gmail.com>
Message-ID: <0ce690ab886d4896506ba916d2d39554@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-02-08 08:52, Matt Sealey wrote:
> Hiya,
> 
> On 25 January 2018 at 17:55, Channagoud Kadabi <ckadabi@codeaurora.org> 
> wrote:
>> Documentation for last level cache controller device tree bindings,
>> client bindings usage examples.
> 
> [snippety snip]
> 
>> +- llcc-bank-off:
>> +       Usage: required
>> +       Value Type: <u32 array>
>> +       Definition: Offsets of llcc banks from llcc base address 
>> starting from
>> +                   LLCC bank0.
>> +
>> +- llcc-broadcast-off:
>> +       Usage: required
>> +       Value Type: <u32>
>> +       Definition: Offset of broadcast register from LLCC bank0 
>> address.
> 
> What's with the redundant namespacing?
> 
> Have we not, as a community, realised that we do not need to namespace
> properties which are only present under
> a single binding or node, or even those that aren't? This mess started
> with the regulator bindings and it's never
> stopped. What are we at now, 25 years of device trees, 10 years of FDT 
> on Arm?
> 
> Notwithstanding the complete waste of rodata in the kernel image for
> matching (& increased time to compare), why
> wouldn't you consider why "bank-offset" for your node be any different
> than a common property for any other node?

I will clean up the name space and use bank-offset for the property 
name.

> 
> And if you need to describe register offsets... why aren't you able to
> use the reg property?

Reg property did not suit well for my need, so I choose to maintain 
offsets instead.

The registers in the HW block are organized as
                 (offset1)    (offset2)     (offset3)     (offset4)
Base(Block0) -- Block1 -- Block 2 -- Block 3 -- Broadcast_Block

Each block has identical register mapping. You can think of it as 4 
instances of identical HW.
Broadcast block is to simplify writes, you don't need to write to 
individual blocks instead write to broadcast block.

I use simple-mfd/syscon as the hardware has multiple functions.
Doing regmap on the the Base (Block0) and maintaining offset makes the 
driver cleaner rather than using the reg property for
each instance.

> 
> Ta,
> Matt

-- 
--
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
a Linux Foundation Collaborative Project
