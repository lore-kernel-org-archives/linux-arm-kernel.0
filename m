From: james.morse@arm.com (James Morse)
Date: Thu, 14 Sep 2017 13:36:41 +0100
Subject: [PATCH v6 5/7] arm64: kvm: route synchronous external abort
 exceptions to el2
In-Reply-To: <fb7da3e3-d0f7-7ac6-b088-888a563d7ee7@huawei.com>
References: <1503916701-13516-1-git-send-email-gengdongjiu@huawei.com>
 <1503916701-13516-6-git-send-email-gengdongjiu@huawei.com>
 <59B17449.6010201@arm.com> <fb7da3e3-d0f7-7ac6-b088-888a563d7ee7@huawei.com>
Message-ID: <59BA77D9.4080201@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi gengdongjiu,

On 14/09/17 12:12, gengdongjiu wrote:
> On 2017/9/8 0:31, James Morse wrote:
>> KVM already handles external aborts from lower exception levels, no more work
>> needs doing for TEA.

> If it is firmware first solution, that is SCR_EL3.EA=1, all SError interrupt and synchronous External
> Abort exceptions are taken to EL3, so EL3 firmware will handle it, KVM no needs to handle it.

... and presumably your firmware generates a fake-Synchronous-external-abort to
hand to EL2 as an APEI SEA notification? My point: this is fine, KVM already
handles synchronous-external aborts, no more work needed for this trap, (in
contrast to the TERR, which you've fixed)


> HCR_EL3.TEA is only for EL3 to check its value to decide to jump to hypervisor or kernel.

HCR_EL3!?!


>> What happens when a guest access the RAS-Error-Record registers?
>>
>> Before we can set HCR_EL2.TERR I think we need to add some minimal emulation for
>> the registers it traps. Most of them should be RAZ/WI, so it should be
>> straightforward. (I think KVMs default is to emulate an undef for unknown traps).

> Today I added the support to do some minimal emulation for RAS-Error-Record registers, thanks
> for the good suggestion.

Thanks. Software has the bad habit of living much longer than we think, if KVM
traps part of the architecture then we have to emulate it... Some bright spark
might boot a future Linux-v4.42 guest on a Linux-v4.16 host.

I had a run through the RAS spec: if we make ERRIDR_EL1 RAZ/WI then we can do
the same with ERRSELR_EL1. Then following the rules for 'If ERRSELR_EL1.SEL is
[>=]  ERRIDR_EL1.NUM' that makes the ERX* registers RAZ/WI too.


>> Eventually we will want to back this with a page of memory that lets
>> Qemu/kvmtool configure what the guest can see. (i.e. the emulated machine's
>> errors for kernel-first handling.)


Thanks,

James
