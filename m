From: agraf@suse.de (Alexander Graf)
Date: Tue, 10 Dec 2013 23:36:31 +0100
Subject: [PATCH 1/2] KVM: Add KVM_EXIT_RESET to user space API header
In-Reply-To: <20131210222707.GA2871@cbox>
References: <1385394599-15439-1-git-send-email-anup.patel@linaro.org>
 <1385394599-15439-2-git-send-email-anup.patel@linaro.org>
 <B781AC83-E85A-45E5-BD8C-3979D1E74D34@suse.de> <20131210222707.GA2871@cbox>
Message-ID: <05BE7CC4-C9CD-4E6A-9735-BB32CD3C9D0A@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 10.12.2013, at 23:27, Christoffer Dall <christoffer.dall@linaro.org> wrote:

> On Tue, Dec 10, 2013 at 03:13:34AM +0100, Alexander Graf wrote:
>> 
>> On 25.11.2013, at 16:49, Anup Patel <anup.patel@linaro.org> wrote:
>> 
>>> Currently, we don't have an exit reason for VM reset emulation
>>> in user space hence this patch adds exit reason KVM_EXIT_RESET
>>> for this purpose.
>>> 
>>> This newly added KVM_EXIT_RESET will be used by KVM arm/arm64
>>> in-kernel PSCI support to reset VMs.
>>> 
>>> Signed-off-by: Anup Patel <anup.patel@linaro.org>
>>> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
>>> ---
>>> include/uapi/linux/kvm.h |    1 +
>>> 1 file changed, 1 insertion(+)
>>> 
>>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>>> index 902f124..64a04cc 100644
>>> --- a/include/uapi/linux/kvm.h
>>> +++ b/include/uapi/linux/kvm.h
>>> @@ -171,6 +171,7 @@ struct kvm_pit_config {
>>> #define KVM_EXIT_WATCHDOG         21
>>> #define KVM_EXIT_S390_TSCH        22
>>> #define KVM_EXIT_EPR              23
>>> +#define KVM_EXIT_RESET            24
>> 
>> I have to admit that I'm not particularly happy with the exit name. It's not obvious from the name under which circumstances it gets triggered. Does it get triggered when a core level reset happens? Does it get triggered when a system level reset happened? When the guest requests one?
>> 
>> I know what it does, but I find the name too generic for what it is. What you're really doing is introduce a new communication channel in parallel to MMIO / PIO / HCALL which is only used for system level reset / shutdown today.
>> 
>> Can we treat it as such? Could you please make this a common exit number that's called something like
>> 
>>  KVM_EXIT_SYSTEM_EVENT
>> 
>> with a parameter that can either be TRIGGER_SHUTDOWN or TRIGGER_RESET.
>> 
>> That way it's obvious what's going on and people don't get confused.
>> 
> I didn't realize what the KVM_EXIT_SHUTDOWN really was, thanks for
> explaining that.  In that case, the SYSTEM_EVENT sounds good to me.
> 
> How do you propose the parameter gets passed?  As a new struct to the
> untion in kvm_run ?

Yup, that's how we usually pass information along with an exit reason. Make sure to add a flags field so it can be extended if we need to pass in more later for future unknown events. PPC for example has fun system wide hypercalls like "enable little endian mode on all virtual cpus". I don't even want to start imagining what people will come up with next.


Alex
