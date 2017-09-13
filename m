From: peter.maydell@linaro.org (Peter Maydell)
Date: Wed, 13 Sep 2017 11:52:34 +0100
Subject: [PATCH v11 6/6] target-arm: kvm64: Handle SError interrupt for
 the guest OS
In-Reply-To: <5552cf68-b998-686b-8e7e-710399c2b014@huawei.com>
References: <0184EA26B2509940AA629AE1405DD7F2015FE17F@DGGEMA503-MBX.china.huawei.com>
 <CAFEAcA8J5wZ23kQypzcbUScUResjWnN6rDG0b0idD1rv7F5Fsw@mail.gmail.com>
 <5552cf68-b998-686b-8e7e-710399c2b014@huawei.com>
Message-ID: <CAFEAcA_zO_-kDYb0MkW=p5oY6tQPk4PpCqZoG0_01pn=sa3upw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 September 2017 at 08:52, gengdongjiu <gengdongjiu@huawei.com> wrote:
>
>
> On 2017/9/12 0:39, Peter Maydell wrote:
>>>>> +    return  kvm_vcpu_ioctl(CPU(cpu), KVM_ARM_SEI, &syndrome);
>>>> This looks odd. If we don't have the RAS extension why do we need to do anything at all here ?
>>> This is because Qemu may need to support non-RAS extension as discussed with ARM James before.
>>> That is to say host hardware CPU does not support RAS, but guest supports.
>>> That is under discussion.
>>> When host hardware supports RAS, specify the syndrome to a valid value, otherwise, set it to 0.
>> If the guest CPU doesn't support the RAS extension then we have
>> no mechanism for delivering it a notification about the
>> memory problem at all, so setting the syndrome to anything
>> doesn't make sense.
>>
>> I'm not sure what you should do in the case of "host
>> supports telling us about a memory problem and has
>> done so, but guest does not support being told about it",
>> but I'm pretty sure it shouldn't be this.

>    in short, if the hardware CPU does not support RAS extension, do you think whether the Qemu or guest OS
> needs to support RAS(generate APEI table / record CPER / Error recovery).

This question seems to be not really related to the review
comment that it is responding to.

(1) If the host does not support notifying us about
errors, then there is clearly nothing to do in this
code, because we will never get a notification.

(2) If the host does support notifying us about errors,
but we choose not to expose RAS to the guest, then
there's not much to do either. We probably just want
to take whatever the default behaviour is for any
application when it touches memory that's bad.
We definitely don't want to tell the guest anything.

(3) If the host supports notification, and we choose
to expose RAS to the guest, then we need to do
whatever we have to do to notify the guest.

If we're in this signal handler and also
arm_feature(env, ARM_FEATURE_RAS) is false then that
is case (2), and my point is that doing anything with
the guest 'syndrome' value looks like the wrong thing.

thanks
-- PMM
