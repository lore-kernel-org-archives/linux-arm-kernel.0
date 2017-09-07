From: james.morse@arm.com (James Morse)
Date: Thu, 07 Sep 2017 17:31:05 +0100
Subject: [PATCH v6 5/7] arm64: kvm: route synchronous external abort
 exceptions to el2
In-Reply-To: <1503916701-13516-6-git-send-email-gengdongjiu@huawei.com>
References: <1503916701-13516-1-git-send-email-gengdongjiu@huawei.com>
 <1503916701-13516-6-git-send-email-gengdongjiu@huawei.com>
Message-ID: <59B17449.6010201@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dongjiu Geng,

On 28/08/17 11:38, Dongjiu Geng wrote:
> ARMv8.2 adds a new bit HCR_EL2.TEA which controls to
> route synchronous external aborts to EL2, and adds a
> trap control bit HCR_EL2.TERR which controls to
> trap all Non-secure EL1&0 error record accesses to EL2.
>
> This patch enables the two bits for the guest OS.
> when an synchronous abort is generated in the guest OS,

> it will trap to EL3 firmware, EL3 firmware will check the
> HCR_EL2.TEA value to decide to jump to hypervisor or host
> OS.

(This is what you are using this for, the patch has nothing to do with EL3.)


> Enabling HCR_EL2.TERR makes error record access
> from guest trap to EL2.


KVM already handles external aborts from lower exception levels, no more work
needs doing for TEA.

What happens when a guest access the RAS-Error-Record registers?

Before we can set HCR_EL2.TERR I think we need to add some minimal emulation for
the registers it traps. Most of them should be RAZ/WI, so it should be
straightforward. (I think KVMs default is to emulate an undef for unknown traps).

Eventually we will want to back this with a page of memory that lets
Qemu/kvmtool configure what the guest can see. (i.e. the emulated machine's
errors for kernel-first handling.)


Thanks,

James
