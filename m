From: james.morse@arm.com (James Morse)
Date: Mon, 06 Mar 2017 10:28:04 +0000
Subject: [PATCH V11 10/10] arm/arm64: KVM: add guest SEA support
In-Reply-To: <ff3aa805-0e03-9854-e294-ff6934c57f3f@codeaurora.org>
References: <1487712121-16688-1-git-send-email-tbaicar@codeaurora.org>
 <1487712121-16688-11-git-send-email-tbaicar@codeaurora.org>
 <58B00E12.5020602@arm.com>
 <ff3aa805-0e03-9854-e294-ff6934c57f3f@codeaurora.org>
Message-ID: <58BD39B4.9050809@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tyler,

On 28/02/17 19:43, Baicar, Tyler wrote:
> On 2/24/2017 3:42 AM, James Morse wrote:
>> On 21/02/17 21:22, Tyler Baicar wrote:
>>> Currently external aborts are unsupported by the guest abort
>>> handling. Add handling for SEAs so that the host kernel reports
>>> SEAs which occur in the guest kernel.

>>> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
>>> index b2d57fc..403277b 100644
>>> --- a/arch/arm64/mm/fault.c
>>> +++ b/arch/arm64/mm/fault.c
>>> @@ -602,6 +602,24 @@ static const char *fault_name(unsigned int esr)
>>>   }
>>>
>>>   /*
>>> + * Handle Synchronous External Aborts that occur in a guest kernel.
>>> + */
>>> +int handle_guest_sea(unsigned long addr, unsigned int esr)
>>> +{
>>> +    if(IS_ENABLED(HAVE_ACPI_APEI_SEA)) {
>>> +        nmi_enter();
>>> +        ghes_notify_sea();
>>> +        nmi_exit();

>> This nmi stuff was needed for synchronous aborts that may have interrupted
>> APEI's interrupts-masked code. We want to avoid trying to take the same set of
>> locks, hence taking the in_nmi() path through APEI. Here we know we interrupted
>> a guest, so there is no risk that we have interrupted APEI on the host.
>> ghes_notify_sea() can safely take the normal path.

> Makes sense, I can remove the nmi_* calls here.

Just occurs to me: if we do this we need to add the rcu_read_lock() in
ghes_notify_sea() as its not protected by the rcu/nmi weirdness.


Thanks,

James
