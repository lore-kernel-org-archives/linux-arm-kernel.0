From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 5 Jun 2013 20:08:53 +0100
Subject: Cache issues in vexpress cpu shutdown (regression in 3.10)
In-Reply-To: <20130605120539.GC32505@e102568-lin.cambridge.arm.com>
References: <1370430551.3387.11.camel@linaro1.home>
 <20130605113912.GE18614@n2100.arm.linux.org.uk>
 <20130605120539.GC32505@e102568-lin.cambridge.arm.com>
Message-ID: <20130605190853.GF18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 05, 2013 at 01:05:39PM +0100, Lorenzo Pieralisi wrote:
> There is an A9 errata (fixed in r1p0) whereby CLIDR[23:21] reads as 0
> where it should read as 3'b001, so basically flush_cache_louis is not
> flushing anything. If that's the problem, either we add a generic fix
> in v7 cache assembly or we just fix it in platform code (by calling
> flush_cache_all()), since there should not be many pre-r1p0 around.
> 
> Please let me know what you think.

If we're providing a flush_cache_louis() function, then it better do
what it says or be removed.  So the right solution is to fix the
function rather than working around it, because over time we'll only
add more calls to flush_cache_louis() and it'll become a stumbling
block.
