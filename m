From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 26 Nov 2015 16:06:48 +0000
Subject: [PATCH] arm64: mm: Prevent the initial page table setup from
 creating larger blocks
In-Reply-To: <56563D2C.7050807@arm.com>
References: <1448387338-27851-1-git-send-email-catalin.marinas@arm.com>
 <56563D2C.7050807@arm.com>
Message-ID: <20151126160648.GL3109@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2015 at 04:58:52PM -0600, Jeremy Linton wrote:
> On 11/24/2015 11:48 AM, Catalin Marinas wrote:
> >This patch prevents the larger block mappings at all levels _if_ the
> >existing pud/pmd entry is present _and_ not already a block mapping.
> >Contiguous ptes are rejected if any of the entries in the range are
> >non-empty and non-contiguous.
> >
> >In addition, TLB flushing is added for the cases where an existing block
> >entry is changed.
> 
> Ok, it seems to boot fairly reliably on the m400/ACPI, over a few dozen
> reboots yesterday and today. So, for that:
> 
> Tested-by: Jeremy Linton <jeremy.linton@arm.com>
> 
> That said, it basically disables the CONT ranges for the main kernel text
> section.

Thanks for testing. However, I made the decision to revert commit
348a65cdcbbf ("arm64: Mark kernel page ranges contiguous") temporarily
until 4.5. While I see your point that other cases pte->pmd->pud could
be equally broken, we haven't had reports about them so far. Mark is
close to finishing a proper fix for the page table manipulation and
we'll re-apply your commit once that's done. I kept the other patches in
the original series, so it's only the last one that needs merging.

-- 
Catalin
