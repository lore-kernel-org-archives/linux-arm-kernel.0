From: will.deacon@arm.com (Will Deacon)
Date: Wed, 28 Mar 2018 12:58:04 +0100
Subject: [PATCH V2] arm64: tlbflush: avoid writing RES0 bits
In-Reply-To: <96f894bb-4855-a77f-3fd1-c8a2878faabb@codeaurora.org>
References: <1522120877-9136-1-git-send-email-pelcan@codeaurora.org>
 <985a0edd-e388-dade-8824-30cc58a236f3@arm.com>
 <56b560a5-6e57-8e01-32ca-9d3c95ccd2e5@codeaurora.org>
 <20180327173613.GI18435@arm.com>
 <96f894bb-4855-a77f-3fd1-c8a2878faabb@codeaurora.org>
Message-ID: <20180328115804.GD30850@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 27, 2018 at 08:03:07PM -0500, Shanker Donthineni wrote:
> On 03/27/2018 12:36 PM, Will Deacon wrote:
> > On Tue, Mar 27, 2018 at 09:53:16AM -0500, Shanker Donthineni wrote:
> >>>> @@ -154,8 +163,8 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
> >>>> ????????? return;
> >>>> ????? }
> >>>> ? -??? start = asid | (start >> 12);
> >>>> -??? end = asid | (end >> 12);
> >>>> +??? start = __TLBI_VADDR(start, asid);
> >>>> +??? end = __TLBI_VADDR(end, asid);
> > 
> > Can you test this bit too, please? ;)
> > 
> 
> I've verified the basic boot functionality on QDF2400 platform. But I can see now
> after your comments, it leads to TLB conflicts because of ASID is truncated to zero
> due to two times 48bit shift.     
> 
> Thanks for catching this one.

I just noticed it during review. In general, if you're making changes
relating to virtual memory stuff I'd *strongly* advise you to do more
than a basic boot test. It's amazing how much appears to run fine when
stuff like TLB invalidation is completely broken.

Anyway, thanks for turning around a new version so quickly.

Will
