From: peter.maydell@linaro.org (Peter Maydell)
Date: Sat, 11 May 2013 09:04:52 +0100
Subject: [PATCH v3 30/32] arm64: KVM: enable initialization of a 32bit vcpu
In-Reply-To: <20130511003842.GE30999@chazy>
References: <1365437854-30214-1-git-send-email-marc.zyngier@arm.com>
 <1365437854-30214-31-git-send-email-marc.zyngier@arm.com>
 <20130423230229.GN20569@gmail.com> <5177E303.7050801@arm.com>
 <CAEDV+g+OL+37w9jA8=0WGea5FgW5y3mazqFzv9GLxDgjCe6dtg@mail.gmail.com>
 <51892DA4.4050401@arm.com> <20130511003842.GE30999@chazy>
Message-ID: <CAFEAcA-8cHk9Gv5j8XvK9dfkpZJeZ+hNfc4NekKCW_KBeHttKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 May 2013 01:38, Christoffer Dall <cdall@cs.columbia.edu> wrote:
> On Tue, May 07, 2013 at 05:36:52PM +0100, Marc Zyngier wrote:
>> Here's what the documentation says:
>> <quote>
>> 4.77 KVM_ARM_VCPU_INIT
>>
>> Capability: basic
>> Architectures: arm, arm64
>> Type: vcpu ioctl
>> Parameters: struct struct kvm_vcpu_init (in)
>> Returns: 0 on success; -1 on error
>> Errors:
>>   EINVAL:    the target is unknown, or the combination of features is invalid.
>>   ENOENT:    a features bit specified is unknown.
>> </quote>
>>
>> When this call fails, it is because you've requested a feature
>> that is invalid for this CPU. To me, that exactly fits the
>> EINVAL entry copied above.
>>
>> Or am I completely misunderstanding it?
>>
> I read the EINVAL to say that you supplied something which is invalid
> for the software interface and you should fix your user space code.

Well, more likely "tell the user they picked a bad feature combo";
I doubt userspace is going to bother specifically trying to track
which features don't go together when we can get a reliable answer
just by asking the kernel.

> The fact that you're requesting a feature that your hardware doesn't
> support is a different thing IMHO.

My reading of the docs above would be that "ENOENT" is "I have
no idea what feature you just asked me for" and "EINVAL" is
"I know those features but can't do them". That said, we don't
actually do anything with the error return yet so we should
feel free to clarify things so that it's clear what error is
returned for the cases we care about distinguishing. It seems
like it would be useful to have separate errors for:
 * the kernel doesn't support this CPU
 * the kernel doesn't support this feature bit
 * the combination of CPU and features doesn't make sense

and at the moment we've shoehorned two of those into one
errno, hence the confusion.

(do we need to distinguish "I know about but don't support X"
from "I have no idea what you mean when you say X" ?)

thanks
-- PMM
