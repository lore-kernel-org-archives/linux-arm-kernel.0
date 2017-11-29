From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 29 Nov 2017 17:35:16 +0000
Subject: [PATCH v2 01/16] KVM: Take vcpu->mutex outside vcpu_load
In-Reply-To: <51b1bb38-7fa8-d785-3281-5a239639989e@redhat.com>
References: <20171129164116.16167-1-christoffer.dall@linaro.org>
 <20171129164116.16167-2-christoffer.dall@linaro.org>
 <25c1daca-1d8b-48e7-af2d-5cf47d0d278b@redhat.com>
 <1cf0f391-960c-a457-29e5-f31ee410a9d1@redhat.com>
 <51b1bb38-7fa8-d785-3281-5a239639989e@redhat.com>
Message-ID: <CAMJs5B_sYAQDF6Z3tDD4u8S3gJWns+gR1CE_hrcD83L_wmpEwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 29, 2017 at 5:22 PM, David Hildenbrand <david@redhat.com> wrote:
> On 29.11.2017 18:20, Paolo Bonzini wrote:
>> On 29/11/2017 18:17, David Hildenbrand wrote:
>>> On 29.11.2017 17:41, Christoffer Dall wrote:
>>>> As we're about to call vcpu_load() from architecture-specific
>>>> implementations of the KVM vcpu ioctls, but yet we access data
>>>> structures protected by the vcpu->mutex in the generic code, factor
>>>> this logic out from vcpu_load().
>>>>
>>>> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
>>>> ---
>>>>  arch/x86/kvm/vmx.c       |  4 +---
>>>>  arch/x86/kvm/x86.c       | 20 +++++++-------------
>>>>  include/linux/kvm_host.h |  2 +-
>>>>  virt/kvm/kvm_main.c      | 17 ++++++-----------
>>>>  4 files changed, 15 insertions(+), 28 deletions(-)
>>>>
>>>> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
>>>> index 714a067..e7c46d2 100644
>>>> --- a/arch/x86/kvm/vmx.c
>>>> +++ b/arch/x86/kvm/vmx.c
>>>> @@ -9559,10 +9559,8 @@ static void vmx_switch_vmcs(struct kvm_vcpu *vcpu, struct loaded_vmcs *vmcs)
>>>>  static void vmx_free_vcpu_nested(struct kvm_vcpu *vcpu)
>>>>  {
>>>>         struct vcpu_vmx *vmx = to_vmx(vcpu);
>>>> -       int r;
>>>>
>>>> -       r = vcpu_load(vcpu);
>>>> -       BUG_ON(r);
>>>> +       vcpu_load(vcpu);
>>> I am most likely missing something, why don't we have to take the lock
>>> in these cases?
>>
>> See earlier discussion, at these points there can be no concurrent
>> access; the file descriptor is not accessible yet, or is already gone.
>>
>> Paolo
>
> Thanks, this belongs into the patch description then.
>
Fair enough, I'll add that.

Thanks for having a look.

-Christoffer
