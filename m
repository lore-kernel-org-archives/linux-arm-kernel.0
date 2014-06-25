From: steve.capper@linaro.org (Steve Capper)
Date: Wed, 25 Jun 2014 11:34:33 +0100
Subject: [PATCH] arm64: mm: Fix horrendous config typo
In-Reply-To: <20140625091226.GE6153@arm.com>
References: <1403682105-7919-1-git-send-email-steve.capper@linaro.org>
 <20140625091226.GE6153@arm.com>
Message-ID: <20140625103433.GA12113@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 25, 2014 at 10:12:26AM +0100, Will Deacon wrote:
> On Wed, Jun 25, 2014 at 08:41:45AM +0100, Steve Capper wrote:
> > The define ARM64_64K_PAGES is tested for rather than
> > CONFIG_ARM64_64K_PAGES. Correct that typo here.
> 
> Whilst I agree that this is a bad typo, the existing behaviour would
> still return false all the time for 64K-page configs, right?

Yes. The net effect of this typo is that pud_sect returns spuriously
for 64K granule when it should always return zero instead.
pud_sect has one user:  kern_addr_valid. 

For a 64K granule we have the following arrangement:
	PMD folded into PUD folded into PGD.

Thus kern_addr_valid returns slightly earlier from the walker, but
returns the correct result. The tests ran against kern_addr_valid got
the correct expected result, and the correct behaviour was observed.

> 
> The bigger problem here is testing the hugepage support with all the
> wonderful page sizes we've grown. Are there any targetted tests to know
> that we're actually exercising 1GB mappings with 4k granules? Certainly,
> our stress tests don't appear to be catching this at the moment.

Yes. libhugeltbfs is used to test 1GB mappings, 512MB mappings and 2MB
mappings. LTP exercises 512MB and 2MB THP mappings depending on granule.

Testing in general can always be improved. I have contributed test code
to libhugetlbfs, and will contribute more tests as and when I think of
them.

There are benchmarks being run on workloads backed by 1GB mappings too.

As mentioned above, the only code path affected by this typo exercised
the correct behaviour due to the folding of pgd, pud, pmd. It was
tested and the test passed as the correct behaviour was observed.

Cheers,
-- 
Steve
