From: gengdongjiu@huawei.com (gengdongjiu)
Date: Thu, 14 Sep 2017 19:12:06 +0800
Subject: [PATCH v6 5/7] arm64: kvm: route synchronous external abort
 exceptions to el2
In-Reply-To: <59B17449.6010201@arm.com>
References: <1503916701-13516-1-git-send-email-gengdongjiu@huawei.com>
 <1503916701-13516-6-git-send-email-gengdongjiu@huawei.com>
 <59B17449.6010201@arm.com>
Message-ID: <fb7da3e3-d0f7-7ac6-b088-888a563d7ee7@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

James,

On 2017/9/8 0:31, James Morse wrote:
> KVM already handles external aborts from lower exception levels, no more work
> needs doing for TEA.
If it is firmware first solution, that is SCR_EL3.EA=1, all SError interrupt and synchronous External
Abort exceptions are taken to EL3, so EL3 firmware will handle it, KVM no needs to handle it.

HCR_EL3.TEA is only for EL3 to check its value to decide to jump to hypervisor or kernel.

> 
> What happens when a guest access the RAS-Error-Record registers?
> 
> Before we can set HCR_EL2.TERR I think we need to add some minimal emulation for
> the registers it traps. Most of them should be RAZ/WI, so it should be
> straightforward. (I think KVMs default is to emulate an undef for unknown traps).
Today I added the support to do some minimal emulation for RAS-Error-Record registers, thanks
for the good suggestion.

> 
> Eventually we will want to back this with a page of memory that lets
> Qemu/kvmtool configure what the guest can see. (i.e. the emulated machine's
> errors for kernel-first handling.)
