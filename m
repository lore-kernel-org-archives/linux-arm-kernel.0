From: will.deacon@arm.com (Will Deacon)
Date: Wed, 12 Apr 2017 10:14:45 +0100
Subject: [GIT PULL] arm64: fixes for -rc6
In-Reply-To: <3b32cfd3-7675-005b-a737-58a8677f65ac@redhat.com>
References: <20170407160239.GS19342@arm.com>
 <3b32cfd3-7675-005b-a737-58a8677f65ac@redhat.com>
Message-ID: <20170412091445.GB27097@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On Tue, Apr 11, 2017 at 03:12:57PM -0400, Jon Masters wrote:
> On 04/07/2017 12:02 PM, Will Deacon wrote:
> 
> > Please pull these two arm64 fixes for -rc6. We've got a regression fix for
> > the signal raised when userspace makes an unsupported unaligned access and a
> > revert of the contiguous (hugepte) support for hugetlb, which has once again
> > been found to be broken. One day, maybe, we'll get it right.
> 
> <snip>
> 
> > - Revert broken support for the contiguous bit in hugetlb (again...)
> 
> Quick aside: is this being worked on for 4.12? If not, should we ping
> Linaro and look to get some focus on this? It's right to disable this,
> but also painful to those wanting to work on various NFV use cases.

I think Punit and Steve (CC'd) are working on this, but the issues run
beyond the lack of break-before-make. The core GUP code, for example,
doesn't even support hugeptes. There are also dormant issues with hugeptes
and swap/migration entries, which would hit if somebody flipped
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION. Hell, even the pte_huge macro is
bogus if you're using contiguous ptes (granted, it's seldom used, but if
the above are fixed maybe it will be).

Will
