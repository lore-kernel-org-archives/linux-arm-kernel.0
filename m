From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Nov 2014 23:20:19 +0100
Subject: [GIT PULL v2 1/4] ARM: tegra: IOMMU support for v3.19
In-Reply-To: <1416993053-3630-1-git-send-email-thierry.reding@gmail.com>
References: <1416570832-6220-1-git-send-email-thierry.reding@gmail.com>
 <1416993053-3630-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <201411282320.19546.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 26 November 2014, Thierry Reding wrote:
> Hi ARM SoC maintainers,
> 
> The following changes since commit 0690cbd2e55a72a8eae557c389d1a136ed9fa142:
> 
>   powerpc/iommu: Rename iommu_[un]map_sg functions (2014-11-18 11:30:01 +0100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-3.19-iommu-rebased
> 
> for you to fetch changes up to 37d21f8918f2aa2289036cc778ee188951e53288:
> 
>   memory: Add NVIDIA Tegra memory controller support (2014-11-26 09:45:02 +0100)
> 
> Here's a version of the pull request rebased on top of Joerg's core
> branch from the IOMMU tree. It has the advantage of having resolved
> the merge conflicts and the disadvantage of pulling in v3.18-rc3.
> 

Hi Thierry,

sorry for taking my time on this, I had some concerns when I first
looked at the memory controller driver and binding (after I got your
pull request), and wanted to be sure everything is fine before I merge
it.

Pulling in v3.18-rc3 is not a problem, since the next/soc branch is
already based on -rc3 (you can see that yourself if you check out the
branch from the arm-soc tree), and I'm absolutely fine with merging
either v1 or v2 of this, the conflict seems harmless, and so does 
pulling in the dependency.

The extra attention for the binding is because the base iommu binding
is still very new and gives some options to driver authors, and I want
to make sure we are setting a good example for others to look at.
My problem is mainly lack of understanding for your hardware requirements,
so hopefully you can clarify this all and I can just merge it, or we
find an easy way to change the code if I have stumbled on a problem.

My main question is about the relation between 'swgroup' and 'id'
settings. What do the two things mean respectively, does your driver
define how they get combined, or is each master hardcoded to both?

I generally dislike having SoC-specific lookup tables in drivers for
things that could be fully described in DT, so I really want to understand
why you added those tables.

The .smmu.reg and .smmu.bit settings seem to directly correlate to the
.id value in the table, so I'm assuming you could derive one from the
other if it was advantagous. The name is only used for debugging purposes
and we could also leave it out if we had a way to kill off the other fields
of the table.

In the comment you mention that the latency allowance is set up to the
hardware defaults, so I guess in the current version this is not required,
but the .la.reg/shift/mask fields can't be determined from the other
fields. This means in order to implement the extension for changing the
setting in the future, you'd have to add some other way of communicating
it without the table, right?

Back to the swgroup/id fields: if you need both, would it make sense
to have #iommu-cells = <2> and pass both from the dma master device?

	Arnd
