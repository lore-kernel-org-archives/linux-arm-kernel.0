From: robherring2@gmail.com (Rob Herring)
Date: Wed, 18 Dec 2013 09:42:09 -0600
Subject: [PATCH v3 0/2] PSCI system off and reset for KVM ARM/ARM64
In-Reply-To: <87wqj2ql57.fsf@e102391-lin.cambridge.arm.com>
References: <1387280136-13622-1-git-send-email-anup.patel@linaro.org>	<20131217185154.GN5711@cbox>
 <87wqj2ql57.fsf@e102391-lin.cambridge.arm.com>
Message-ID: <52B1C251.9040801@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding Mark Rutland.

On 12/18/2013 08:38 AM, Marc Zyngier wrote:
> Christoffer Dall <christoffer.dall@linaro.org> writes:
> 
>> On Tue, Dec 17, 2013 at 05:05:34PM +0530, Anup Patel wrote:
>>> The Power State and Coordination Interface (PSCI) specification defines
>>> SYSTEM_OFF and SYSTEM_RESET functions for system poweroff and reboot.
>>>
>>> This patchset adds emulation of PSCI SYSTEM_OFF and SYSTEM_RESET functions
>>> in KVM ARM/ARM64 by forwarding them to user space (QEMU or KVMTOOL) using
>>> KVM_EXIT_SYSTEM_EVENT exit reason.
>>>
>>> To try this patch from guest kernel, we will need PSCI-based restart and
>>> poweroff support in the guest kenel for both ARM and ARM64.
>>>
>>> Rob Herring has already submitted patches for PSCI-based restart and
>>> poweroff in ARM kernel but these are not merged yet due unstable device
>>> tree bindings of kernel PSCI support. We will be having similar patches
>>> for PSCI-based restart and poweroff in ARM64 kernel.
>>> (Refer http://www.spinics.net/lists/arm-kernel/msg262217.html)
>>> (Refer http://www.spinics.net/lists/devicetree/msg05348.html)
>>
>> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
>>
>> I can merge this series if Marc acks it as well.
> 
> The patches themselves are mostly fine. One issue though: They implement
> part of the v0.2 spec, but keep on using the range of function IDs that
> we made up for v0.1.
> 
> I just had a chat with the person responsible for the spec, and realized
> that the Function IDs mentionned in the v0.2 spec are not optional, and
> not using them would be in direct violation of the spec (the new numbers
> now come directly from the SMC calling convention).

News to me. That is exactly the opposite of what Mark Rutland told me.
This would certainly simplify things since the SMC calling convention
IDs encode the size and there would be no reason to put the IDs into DT.

> So I rekon we need to create a separate range for those. Also, I'd like
> to progress the DT and kernel side of things as well (otherwise this is
> all a bit pointless).
> 
> Rob: what are your plans regarding your PSCI v0.2 patches?

My plan was to simply add 2 optional properties for reset/off and be
done with it like is done here. I'll leave it to ARM to sort out all of
v0.2 ID and 32-bit vs. 64-bit issues.

Rob
