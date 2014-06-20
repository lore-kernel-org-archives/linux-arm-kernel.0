From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jun 2014 11:04:58 +0100
Subject: [PATCH V4 1/2] arm: mm: Introduce {pte,pmd}_isset and
 {pte,pmd}_isclear
In-Reply-To: <20140620091226.GJ25104@arm.com>
References: <1402929159-11028-1-git-send-email-steve.capper@linaro.org>
 <1402929159-11028-2-git-send-email-steve.capper@linaro.org>
 <20140620091226.GJ25104@arm.com>
Message-ID: <20140620100458.GQ32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 20, 2014 at 10:12:26AM +0100, Will Deacon wrote:
> On Mon, Jun 16, 2014 at 03:32:38PM +0100, Steve Capper wrote:
> > -#define pmd_young(pmd)		(pmd_val(pmd) & PMD_SECT_AF)
> > +#define pmd_isset(pmd, val)	((u32)(val) == (val) ? pmd_val(pmd) & (val) \
> > +						: !!(pmd_val(pmd) & (val)))
> 
> What does GCC generate for this as opposed to an unconditional !!?

For any constant "val", the result of (u32)(val) == (val) is also a
constant, so GCC should evaluate it at build time and not run time.

An unconditional !! would result in GCC doing the test and then
constructing code to turn it into a zero-or-one condition, and with
complicated tests, it can really add a lot of additional complexity,
even if it can properly optimise the simple case.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
