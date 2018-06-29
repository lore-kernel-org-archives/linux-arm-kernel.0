From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 29 Jun 2018 10:59:52 +0100
Subject: KVM guest sometimes failed to boot because of kernel stack
 overflow if KPTI is enabled on a hisilicon ARM64 platform.
References: <e701eaa8-dcb9-777c-2211-67ee27b43acb@arm.com>
 <5B2B6DEA.2090100@hisilicon.com> <5B3274FC.7000206@hisilicon.com>
 <20180626174746.GO23375@arm.com> <5B338F7B.9070500@hisilicon.com>
 <20180627132826.GB30631@arm.com> <5B34F5C0.9090001@hisilicon.com>
 <20180628153425.rm5fd6dxb53n226z@lakrids.cambridge.arm.com>
 <etPan.5b3507f7.914aa16.1d6b@localhost>
 <20180628162417.s4mcoaow3dgpodew@lakrids.cambridge.arm.com>
Message-ID: <20180629095952.eiyfz6a3vzw6te6u@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2018 at 07:24:30PM +0000, Zhangxiquan wrote:
> Do you think this order guarantee (between DC and ldst)is applicable for
> cacheable only , or it is also applicable for device ?

This also applies for device memory.

As I quoted previously, from ARM DDI 0487C.a page D3-2069:

  All data cache instructions, other than DC ZVA , that specify an
  address:

  * Can execute in any order relative to loads or stores that access any
    address with the Device memory attribute, or with Normal memory with
    Inner Non-cacheable attribute unless a DMB or DSB is executed
    between the instructions.

i.e. a DMB is sufficient to provide order between DC and loads/stores
which access device memory.

Thanks,
Mark.
