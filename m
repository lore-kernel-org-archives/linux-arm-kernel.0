From: james.morse@arm.com (James Morse)
Date: Fri, 13 Oct 2017 17:53:57 +0100
Subject: [PATCH v3 15/20] KVM: arm64: Set an impdef ESR for Virtual-SError
 using VSESR_EL2.
In-Reply-To: <f5f7859b-71a5-5f65-0344-7682bfac43bb@huawei.com>
References: <20171005191812.5678-1-james.morse@arm.com>
 <20171005191812.5678-16-james.morse@arm.com>
 <f5f7859b-71a5-5f65-0344-7682bfac43bb@huawei.com>
Message-ID: <59E0EFA5.1020103@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi gengdongjiu,

On 13/10/17 10:25, gengdongjiu wrote:
> After checking this patch, I think my patch[1] already include this logic(only a little
> difference).

Your kvm_handle_guest_sei() is similar to where this series ends up, but the
purpose of this patch is to keep KVMs existing behaviour.

KVM already injects SError into the guest all by itself, now with the RAS
extensions it can specify and ESR, and because of the new ESR encoding it can't
use the reset value of all-zeroes.


> In my first version patch [2], It sets the virtual ESR in the KVM, but Marc and
> other people disagree that[3][4],and propose to set its value and injection by userspace(when
> RAS is enabled). 

Not quite: for RAS errors.
When we want to hand a RAS error to a guest, Qemu should be driving that.

What about impdef SError? Qemu should be able to drive that with the same API.

What about this nasty corner where KVM already injects an impdef SError
directly? This patch keeps that working.


I'd love to get rid of KVMs internal use of kvm_inject_vabt(). But what do we
replace it with? It needs to be a guest exit type that existing software can't
ignore...

(The best I can suggest is: Once we have a mechanism to inject SError into a
guest from Qemu, KVM could make an impdef SError pending, then give Qemu the
opportunity to kill the guest, or set a different ESR. Existing software can
ignore the exit, and take the existing behaviour.)


> So I think we no need to submit another patch, it will be duplicated, and waste our review
> time. thank you very much. I will combine that.

I agree we're posting competing series, there was some off-list co-ordination on
this with Xie XiuQi and Xiongfeng Wang in ~may, it looks like you weren't
involved at that point.

In your last series touching all this:
https://lkml.org/lkml/2017/8/31/698

You had Xie XiuQi's RAS-cpufeature patch in isolation, without the SError rework
underneath it. Applied like this SError is still always masked in the kernel, so
any system without firmware-first will silently consume and discard an
uncontained-RAS-error using the esb() in __switch_to(). We can't do this, hence
the first half of this series.


James
