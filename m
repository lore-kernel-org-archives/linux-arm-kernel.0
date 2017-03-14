From: agustinv@codeaurora.org (Agustin Vega-Frias)
Date: Tue, 14 Mar 2017 18:06:09 -0400
Subject: [PATCH 00/14] arm_pmu: ACPI support
In-Reply-To: <20170314184733.GC15740@leverpostej>
References: <1489143891-11596-1-git-send-email-mark.rutland@arm.com>
 <5b5dca5f-0ea3-d7e7-63c9-dba57969d4be@arm.com>
 <20170314114508.GA15740@leverpostej> <20170314184733.GC15740@leverpostej>
Message-ID: <73d82fe7959106d78a49f50d2170ffca@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 2017-03-14 14:47, Mark Rutland wrote:
> On Tue, Mar 14, 2017 at 11:49:19AM +0000, Mark Rutland wrote:
>> On Fri, Mar 10, 2017 at 04:14:57PM -0600, Jeremy Linton wrote:
>> > I tried these patches on a m400 (which uses PPIs), and the kernel
>> > fails to come up enough to login via the network (which works with
>> > 4.11rc1 without these patches). So, I suspect there is something
>> > wrong with them.
>> 
>> Indeed; sorry about this. I'll see if I can get access to a board to 
>> try
>> local debugging.
> 
>> > About the only thing it says with any meaning when earlycon is passed is:
>> > [   10.965147] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
>> > [   11.064193] dw-apb-uart APMC0D08:00: cannot get irq
>> >
>> > and promptly hangs up.
> 
> I believe that this is a latent FW bug, in a beta FW, exposed by recent
> changes.
> 
> I managed to get access to two APM Mustang boards. I can reproduce the
> issue with a vanilla v4.11-rc1 defconfig on one, which has a beta FW.
> The same kernel boots fine on the other, which has a later released FW.
> 
> I bisected the issue down to commit:
> 
>   d44fa3d46079dc09 ("ACPI: Add support for ResourceSource/IRQ domain 
> mapping")
> 
> It seems the beta FW describes the UART interrupt with an Extended
> Interrupt Descriptor with the Consumer/Producer bit clear. Per the 
> spec,
> this means "This device produces and consumes this resource", which
> doesn't make sense here given the UART is not an interrupt controller.
> 
> The (working) released FW doesn't use an Extended Interrupt Descriptor
> for this interrupt, sidestepping the issue.
> 
> Given that (AFAICT) this only affects a known-broken, beta FW, I don't
> think that we care that much.
> 
> However, I think there is a larger potential issue here.
> 
> In acpi_irq_parse_one_cb(), we skip interrupts with an Extended
> Interrupt Descriptor with the Consumer/Producer bit clear. It sounds
> like devices which behave as interrupt controllers could legitimately
> have this bit set for interrupts they generate and deliver to
> themselves, and we'd erroneously skip these when parsing interrupts.
> 
> It's not entirely clear to me why this bit exists at all, given that
> it's not used as part of mapping the interrupt, and if you really want
> to know you can map the interrupt and look at the result.
> 

I think the best approach would be to try to amend the spec and make
zero mean producer only which is the way it is being treated in Linux.
That would mean that a device consuming its own interrupts would have to
have two resources, one for describing the resource as producer and one
as consumer.

Unfortunately the spec is vague in some areas like the feature we used
to implement secondary IRQ controllers which require this patch.

Hanjun, can you bring this up at the next ASWG meeting? I don't normally
attend but I will ask our ASWG lead to invite me so we can discuss this
in that forum.

Thanks,
Agustin

-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a 
Linux Foundation Collaborative Project.
