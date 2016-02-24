From: borntraeger@de.ibm.com (Christian Borntraeger)
Date: Wed, 24 Feb 2016 11:16:34 +0100
Subject: [BUG] random kernel crashes after THP rework on s390 (maybe also
 on PowerPC and ARM)
In-Reply-To: <20160223202233.GE27281@arm.com>
References: <20160211192223.4b517057@thinkpad>
 <20160211190942.GA10244@node.shutemov.name>
 <20160211205702.24f0d17a@thinkpad>
 <20160212154116.GA15142@node.shutemov.name> <56BE00E7.1010303@de.ibm.com>
 <20160212181640.4eabb85f@thinkpad> <20160223103221.GA1418@node.shutemov.name>
 <20160223191907.25719a4d@thinkpad>
 <20160223193345.GC21820@node.shutemov.name> <20160223202233.GE27281@arm.com>
Message-ID: <56CD8302.9080202@de.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/23/2016 09:22 PM, Will Deacon wrote:
> On Tue, Feb 23, 2016 at 10:33:45PM +0300, Kirill A. Shutemov wrote:
>> On Tue, Feb 23, 2016 at 07:19:07PM +0100, Gerald Schaefer wrote:
>>> I'll check with Martin, maybe it is actually trivial, then we can
>>> do a quick test it to rule that one out.
>>
>> Oh. I found a bug in __split_huge_pmd_locked(). Although, not sure if it's
>> _the_ bug.
>>
>> pmdp_invalidate() is called for the wrong address :-/
>> I guess that can be destructive on the architecture, right?
> 
> FWIW, arm64 ignores the address parameter for set_pmd_at, so this would
> only result in the TLBI nuking the wrong entries, which is going to be
> tricky to observe in practice given that we install a table entry
> immediately afterwards that maps the same pages. If s390 does more here
> (I see some magic asm using the address), that could be the answer...

This patch does not change the address for set_pmd_at, it does that for the 
pmdp_invalidate here (by keeping haddr at the start of the pmd)

--->    pmdp_invalidate(vma, haddr, pmd);
        pmd_populate(mm, pmd, pgtable);
 



Without that fix we would clearly have stale tlb entries, no?
