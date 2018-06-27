From: will.deacon@arm.com (Will Deacon)
Date: Wed, 27 Jun 2018 14:28:27 +0100
Subject: KVM guest sometimes failed to boot because of kernel stack
 overflow if KPTI is enabled on a hisilicon ARM64 platform.
In-Reply-To: <5B338F7B.9070500@hisilicon.com>
References: <5B2A6218.3030201@hisilicon.com> <20180620144257.GB27776@arm.com>
 <5B2A7832.4010502@hisilicon.com>
 <ebfabb8f-dcd9-3fb4-3655-368a882d8f09@arm.com>
 <5B2A7FE1.5040607@hisilicon.com>
 <e701eaa8-dcb9-777c-2211-67ee27b43acb@arm.com>
 <5B2B6DEA.2090100@hisilicon.com> <5B3274FC.7000206@hisilicon.com>
 <20180626174746.GO23375@arm.com> <5B338F7B.9070500@hisilicon.com>
Message-ID: <20180627132826.GB30631@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 27, 2018 at 02:22:03PM +0100, Wei Xu wrote:
> On 2018/6/26 18:47, Will Deacon wrote:
> > If you look at the __idmap_kpti_put_pgtable_ent_ng asm macro, can you try
> > replacing:
> > 
> > 	dc      civac, cur_\()\type\()p
> > 
> > with:
> > 
> > 	dc      ivac, cur_\()\type\()p
> > 
> > please? Only do this for the guest kernel, not the host. KVM will upgrade
> > the clean to a clean+invalidate, so it's interesting to see if this has
> > an effect on the behaviour.
> 
> Only changed the guest kernel, the guest still failed to boot and the log
> is same with the last mail.
> 
> But if I changed to cvac as below for the guest, it is kind of stable.
> 	dc      cvac, cur_\()\type\()p
> 
> I have synced with our SoC guys about this and hope we can find the reason.
> Do you have any more suggestion?

Unfortunately, not. It looks like somehow clean+invalidate is behaving
just as an invalidate, and we're corrupting the page table as a result.

Hopefully the SoC guys will figure it out.

Will
