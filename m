From: will.deacon@arm.com (Will Deacon)
Date: Tue, 29 Oct 2013 19:49:56 +0000
Subject: [RFC PATCH 0/2] Implement get_user_pages_fast for ARM
In-Reply-To: <1382101634-4723-1-git-send-email-steve.capper@linaro.org>
References: <1382101634-4723-1-git-send-email-steve.capper@linaro.org>
Message-ID: <20131029194956.GC24556@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 18, 2013 at 02:07:11PM +0100, Steve Capper wrote:
> This patch series implements get_user_pages_fast on ARM. Unlike other
> architectures, we do not use IPIs/disabled IRQs as a blocking
> mechanism to protect the page table walker. Instead an atomic counter
> is used to indicate how many fast gup walkers are active on an address
> space, and any code that would cause them problems (THP splitting or
> code that could free a page table page) spins on positive values of
> this counter.

Curious: did you try benchmarking the two schemes? Whilst I expect this
algorithm to be better on ARM, exclusive memory accesses aren't free and
we're adding code to the fast path.

Will
