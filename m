From: jeremy.linton@arm.com (Jeremy Linton)
Date: Wed, 25 Nov 2015 10:31:48 -0600
Subject: [PATCH] arm64: mm: Prevent the initial page table setup from
 creating larger blocks
In-Reply-To: <1448387338-27851-1-git-send-email-catalin.marinas@arm.com>
References: <1448387338-27851-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <5655E274.80103@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/24/2015 11:48 AM, Catalin Marinas wrote:
> While the ARM ARM is not entirely clear, over the years we have assumed
> that we can split a large block entry (pmd/pud) into smaller blocks
> pointing to the same physical address with little risk of a TLB
> conflict. However, remapping a smaller blocks range as a large one (e.g.
> from page to sections or to contiguous pages) implies a high risk of TLB
> conflict. Excessive TLB flushing would make the window smaller but it
> would not remove the issue.

	Is a requirement of this assumption, that the kernel isn't running on a 
VM'ed host with small page mappings? AKA the hypervisor is providing 
smaller page sizes than guest linear mapping?

	Because I can understand the idea that the CPU won't walk PTEs for 
entries it has a larger translation for, but my understanding of how the 
TLB's are fragmented when the host has a smaller page size means that 
its potentially possible to have multiple TLB entries for different 
parts of a single cont/block range....
