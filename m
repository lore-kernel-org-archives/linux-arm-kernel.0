From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 14 Oct 2016 01:34:29 +0100
Subject: [PATCH v2] perf: xgene: Remove bogus IS_ERR() check
In-Reply-To: <20161013181837.GQ19539@ZenIV.linux.org.uk>
References: <1476382156-11641-1-git-send-email-ttnguyen@apm.com>
 <20161013181837.GQ19539@ZenIV.linux.org.uk>
Message-ID: <20161014003429.GD24167@remoulade>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 13, 2016 at 07:18:37PM +0100, Al Viro wrote:
> On Thu, Oct 13, 2016 at 11:09:16AM -0700, Tai Nguyen wrote:
> > In acpi_get_pmu_hw_inf we pass the address of a local variable to IS_ERR(),
> > which doesn't make sense, as the pointer must be a real, valid pointer.
> > This doesn't cause a functional problem, as IS_ERR() will evaluate as
> > false, but the check is bogus and causes static checkers to complain.
> 
> ... unless the test is actually a misspelled IS_ERR(res) and the current
> code is broken by effectively skipping it.

Sure.

In this case, res is a struct resource, so IS_ERR(res) is also bogus.

None of the pointer fields in struct resource are ever set to an ERR_PTR value,
so nothing in res is worth checking. Nothing else in the function prior to this
would be an ERR_PTR value either.

I believe this case was copy-paste and a thinko. There's some other error
handling in the file that does validly have to handle an ERR_PTR value.

Thanks,
Mark.
