From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 22 Mar 2017 14:38:10 +0000
Subject: [PATCH 7/7] arm64: hugetlb: Add break-before-make logic for
 contiguous entries
In-Reply-To: <20170321180421.18332-8-punit.agrawal@arm.com>
References: <20170321180421.18332-1-punit.agrawal@arm.com>
 <20170321180421.18332-8-punit.agrawal@arm.com>
Message-ID: <20170322143810.GH2977@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 21, 2017 at 06:04:21PM +0000, Punit Agrawal wrote:
> From: Steve Capper <steve.capper@arm.com>
> 
> It has become apparent that one has to take special care when modifying
> attributes of memory mappings that employ the contiguous bit.
> 
> Both the requirement and the architecturally correct "Break-Before-Make"
> technique of updating contiguous entries can be found described in:
> ARM DDI 0487A.k_iss10775, "Misprogramming of the Contiguous bit",
> page D4-1762.
> 
> The huge pte accessors currently replace the attributes of contiguous
> pte entries in place thus can, on certain platforms, lead to TLB
> conflict aborts or even erroneous results returned from TLB lookups.
> 
> This patch adds a helper function get_clear_flush(.) that clears a
> contiguous entry and returns the head pte (whilst taking care to
> retain dirty bit information that could have been modified by DBM).
> A tlb invalidate is performed to then ensure that there is no
> possibility of multiple tlb entries being present for the same
> region.

Since its evidently easy to miss, can we please add a comment above
get_clear_flush() regarding the BBM requirement, e.g.

/*
 * Changing some bits of contiguous entries requires us to follow a
 * Break-Before-Make approach, breaking the whole contiguous set before
 * we can change any entries. See ARM DDI 0487A.k_iss10775,
 * "Misprogramming of the Contiguous bit", page D4-1762.
 *
 * This helper performs the break step.
 */

Otherwise, this looks good to me, and to the best of my knowledge avoids
the issue described above.

FWIW:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Mark.
