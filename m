From: gengdongjiu@huawei.com (gengdongjiu)
Date: Wed, 13 Sep 2017 15:52:14 +0800
Subject: [PATCH v11 6/6] target-arm: kvm64: Handle SError interrupt for
 the guest OS
In-Reply-To: <CAFEAcA8J5wZ23kQypzcbUScUResjWnN6rDG0b0idD1rv7F5Fsw@mail.gmail.com>
References: <0184EA26B2509940AA629AE1405DD7F2015FE17F@DGGEMA503-MBX.china.huawei.com>
 <CAFEAcA8J5wZ23kQypzcbUScUResjWnN6rDG0b0idD1rv7F5Fsw@mail.gmail.com>
Message-ID: <5552cf68-b998-686b-8e7e-710399c2b014@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2017/9/12 0:39, Peter Maydell wrote:
>>>> +    return  kvm_vcpu_ioctl(CPU(cpu), KVM_ARM_SEI, &syndrome);
>>> This looks odd. If we don't have the RAS extension why do we need to do anything at all here ?
>> This is because Qemu may need to support non-RAS extension as discussed with ARM James before.
>> That is to say host hardware CPU does not support RAS, but guest supports.
>> That is under discussion.
>> When host hardware supports RAS, specify the syndrome to a valid value, otherwise, set it to 0.
> If the guest CPU doesn't support the RAS extension then we have
> no mechanism for delivering it a notification about the
> memory problem at all, so setting the syndrome to anything
> doesn't make sense.
> 
> I'm not sure what you should do in the case of "host
> supports telling us about a memory problem and has
> done so, but guest does not support being told about it",
> but I'm pretty sure it shouldn't be this.
Hi peter,
   thanks for the comments.

   in short, if the hardware CPU does not support RAS extension, do you think whether the Qemu or guest OS
needs to support RAS(generate APEI table / record CPER / Error recovery).

CC James,

Hi James,
  you ever have below comments:

-----------------------------------------------------------------------
But you can use APEI in a guest on CPUs without the RAS extensions: the host may
signal memory errors to Qemu for any number of reasons.
------------------------------------------------------------------

in fact, I have a concern about it. If CPU without the RAS extension, the host should not deliver the sigbus.
in which case in your test that host still deliver sigbus without RAS?
