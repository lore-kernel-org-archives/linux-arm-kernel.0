From: eric.auger@linaro.org (Eric Auger)
Date: Wed, 28 Jan 2015 12:08:34 +0100
Subject: [PATCH v2 2/5] KVM: ARM: on IO mem abort - route the call to
 KVM MMIO bus
In-Reply-To: <20150127213853.GE9055@cbox>
References: <20141207093641.17563.84226.stgit@i3820>
 <20141207093749.17563.12497.stgit@i3820> <54B3FFB9.3050406@linaro.org>
 <CADDJ2=Os6Uws6HN=iKg=uhx1artwBFXeyFKq9Co2Sgoo=63bOQ@mail.gmail.com>
 <20150127213853.GE9055@cbox>
Message-ID: <54C8C332.60007@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/27/2015 10:38 PM, Christoffer Dall wrote:
> On Sat, Jan 24, 2015 at 03:02:33AM +0200, Nikolay Nikolaev wrote:
>> On Mon, Jan 12, 2015 at 7:09 PM, Eric Auger <eric.auger@linaro.org> wrote:
>>> Hi Nikolay,
>>> On 12/07/2014 10:37 AM, Nikolay Nikolaev wrote:
>>>> On IO memory abort, try to handle the MMIO access thorugh the KVM
>>>> registered read/write callbacks. This is done by invoking the relevant
>>>> kvm_io_bus_* API.
>>>>
>>>> Signed-off-by: Nikolay Nikolaev <n.nikolaev@virtualopensystems.com>
>>>> ---
>>>>  arch/arm/kvm/mmio.c |   33 +++++++++++++++++++++++++++++++++
>>>>  1 file changed, 33 insertions(+)
>>>>
>>>> diff --git a/arch/arm/kvm/mmio.c b/arch/arm/kvm/mmio.c
>>>> index 4cb5a93..e42469f 100644
>>>> --- a/arch/arm/kvm/mmio.c
>>>> +++ b/arch/arm/kvm/mmio.c
>>>> @@ -162,6 +162,36 @@ static int decode_hsr(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>>>       return 0;
>>>>  }
>>>>
>>>> +/**
>>>> + * handle_kernel_mmio - handle an in-kernel MMIO access
>>>> + * @vcpu:    pointer to the vcpu performing the access
>>>> + * @run:     pointer to the kvm_run structure
>>>> + * @mmio:    pointer to the data describing the access
>>>> + *
>>>> + * returns true if the MMIO access has been performed in kernel space,
>>>> + * and false if it needs to be emulated in user space.
>>>> + */
>>>> +static bool handle_kernel_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
>>>> +             struct kvm_exit_mmio *mmio)
>>>> +{
>>>> +     int ret;
>>>> +
>>>> +     if (mmio->is_write) {
>>>> +             ret = kvm_io_bus_write(vcpu, KVM_MMIO_BUS, mmio->phys_addr,
>>>> +                             mmio->len, &mmio->data);
>>>> +
>>>> +     } else {
>>>> +             ret = kvm_io_bus_read(vcpu, KVM_MMIO_BUS, mmio->phys_addr,
>>>> +                             mmio->len, &mmio->data);
>>>> +     }
>>>> +     if (!ret) {
>>>> +             kvm_prepare_mmio(run, mmio);
>>>> +             kvm_handle_mmio_return(vcpu, run);
>>>> +     }
>>>> +
>>>> +     return !ret;
>>> in case ret < 0 (-EOPNOTSUPP = -95) aren't we returning true too? return
>>> (ret==0)?
>>>
>>>> +}
>>>> +
>>>>  int io_mem_abort(struct kvm_vcpu *vcpu, struct kvm_run *run,
>>>>                phys_addr_t fault_ipa)
>>>>  {
>>>> @@ -200,6 +230,9 @@ int io_mem_abort(struct kvm_vcpu *vcpu, struct kvm_run *run,
>>>>       if (vgic_handle_mmio(vcpu, run, &mmio))
>>>>               return 1;
>>>>
>>>> +     if (handle_kernel_mmio(vcpu, run, &mmio))
>>>> +             return 1;
>>>> +
>>>>       kvm_prepare_mmio(run, &mmio);
>>>>       return 0;
>>> currently the io_mem_abort returned value is not used by mmu.c code. I
>>> think this should be handed in kvm_handle_guest_abort. What do you think?
>>
>> You're right that the returned value is not handled further after we
>> exit io_mem_abort, it's just passed up the call stack.
>> However I'm not sure how to handle it better. If you have ideas, please share.
>>
> I'm confused: the return value from io_mem_abort is assigned to a
> variable 'ret' in kvm_handle_guest_abort and that determines if we
> should run the VM again or return to userspace (with some work for
> userspace to do or with an error).

hum well apologies for that. Guess I was tired when reading that piece
of code :-(

Best Regards
Eric
> 
> -Christoffer
> 
