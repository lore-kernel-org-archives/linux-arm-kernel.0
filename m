From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 28 Jun 2018 16:34:25 +0100
Subject: KVM guest sometimes failed to boot because of kernel stack
 overflow if KPTI is enabled on a hisilicon ARM64 platform.
In-Reply-To: <5B34F5C0.9090001@hisilicon.com>
References: <5B2A7832.4010502@hisilicon.com>
 <ebfabb8f-dcd9-3fb4-3655-368a882d8f09@arm.com>
 <5B2A7FE1.5040607@hisilicon.com>
 <e701eaa8-dcb9-777c-2211-67ee27b43acb@arm.com>
 <5B2B6DEA.2090100@hisilicon.com> <5B3274FC.7000206@hisilicon.com>
 <20180626174746.GO23375@arm.com> <5B338F7B.9070500@hisilicon.com>
 <20180627132826.GB30631@arm.com> <5B34F5C0.9090001@hisilicon.com>
Message-ID: <20180628153425.rm5fd6dxb53n226z@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2018 at 03:50:40PM +0100, Wei Xu wrote:
> Hi Will,
> 
> On 2018/6/27 14:28, Will Deacon wrote:
> > On Wed, Jun 27, 2018 at 02:22:03PM +0100, Wei Xu wrote:
> >> On 2018/6/26 18:47, Will Deacon wrote:
> >>> If you look at the __idmap_kpti_put_pgtable_ent_ng asm macro, can you try
> >>> replacing:
> >>>
> >>> 	dc      civac, cur_\()\type\()p
> >>>
> >>> with:
> >>>
> >>> 	dc      ivac, cur_\()\type\()p
> >>>
> >>> please? Only do this for the guest kernel, not the host. KVM will upgrade
> >>> the clean to a clean+invalidate, so it's interesting to see if this has
> >>> an effect on the behaviour.
> >>
> >> Only changed the guest kernel, the guest still failed to boot and the log
> >> is same with the last mail.
> >>
> >> But if I changed to cvac as below for the guest, it is kind of stable.
> >> 	dc      cvac, cur_\()\type\()p
> >>
> >> I have synced with our SoC guys about this and hope we can find the reason.
> >> Do you have any more suggestion?
> > 
> > Unfortunately, not. It looks like somehow clean+invalidate is behaving
> > just as an invalidate, and we're corrupting the page table as a result.
> > 
> > Hopefully the SoC guys will figure it out.
> 
> After replaced the dmb with dsb in both __idmap_kpti_get_pgtable_ent and
> __idmap_kpti_put_pgtable_ent_ng, we tested 20 times and we can not reproduce
> the issue.
> Today we will continue to do the stress testing and will update the result tomorrow.
> 
> The dsb in __idmap_kpti_get_pgtable_ent is to make sure the dc has been done and
> the following ldr can get the latest data.
> 
> The dsb in __idmap_kpti_put_pgtable_ent_ng is to make sure the str will be done
> before dc. Although dmb can guarantee the order of the str and dc on the L2 cache,
> dmb can not guarantee the order on the bus.

The architecture mandates that a DMB must provide this ordering, so that
would be an erratum.

Per ARM DDI 0487C.a, page D3-2069, "Ordering and completion of data and instruction
cache instructions":

  All data cache instructions, other than DC ZVA, that specify an
  address:

  * Can execute in any order relative to loads or stores that access any
    address with the Device memory attribute,or with Normal memory with
    Inner Non-cacheable attribute unless a DMB or DSB is executed
    between the instructions.

Note that we rely on this ordering in head.S when creating the page
tables and setting up the boot mode. We also rely on this for the pmem
API.

Thanks,
Mark.
