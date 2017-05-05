From: gengdj.1984@gmail.com (gengdongjiu)
Date: Fri, 5 May 2017 20:44:55 +0800
Subject: [PATCH v3 1/3] arm64: kvm: support kvmtool to detect RAS
 extension feature
In-Reply-To: <590B4D73.60000@arm.com>
References: <1493530677-4919-1-git-send-email-gengdongjiu@huawei.com>
 <5908A5BC.1060202@arm.com> <590B4D73.60000@arm.com>
Message-ID: <CAMj-D2Bjb=oDRUhY_dxUmZTuGkNZcCs6EYhKUsvjxAU4v55N7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,
     Thanks a lot for your comments.

2017-05-04 23:49 GMT+08:00 James Morse <james.morse@arm.com>:
> Hi Dongjiu Geng,
>
> On 02/05/17 16:29, James Morse wrote:
>> I think we need a new API for injecting SError for SEI from Qemu/kvmtool, but it
>> shouldn't be related to the RAS extensions. All v8.0 CPUs have HCR_EL2.VSE, so
>> we need to know KVM supports this API.
>
> Thinking about this some more, it is slightly more nuanced, KVM can always
> provide an API to inject SError, but it can only set the VSESR if the CPU has
> the RAS Extensions.

James, do you mean we need to add a new API instead of adding the
VSESR in the old API kvm_inject_vabt?

 /**
  * kvm_inject_vabt - inject an async abort / SError into the guest
  * @vcpu: The VCPU to receive the exception
  *
  * It is assumed that this code is called from the VCPU thread and that the
  * VCPU therefore is not currently executing guest code.
  */
 void kvm_inject_vabt(struct kvm_vcpu *vcpu)
 {
     vcpu_set_hcr(vcpu, vcpu_get_hcr(vcpu) | HCR_VSE);
 }



>
> Only offering the inject-SError API call if we can also set the VSESR looks a
> bit funny, but no-one has needed the no-ESR version so far.
>
> I still don't think we should let user-space make the 'RAS Extensions means
> VSESR' logical step.

 Ok. got it.

>
> So my comments on this patch become:
> Don't read id registers directly, use cpus_have_cap() which handles features
> that differ across CPUs or were turned off at compile time.
>
> Please don't call this 'KVM_CAP_ARM_RAS_EXTENSION', if we are building an API to
> inject SError, call it that instead.

Ok, thanks for your suggestion.

>
>
> Thanks,
>
> James
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
