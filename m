From: will.deacon@arm.com (Will Deacon)
Date: Tue, 10 Jan 2017 12:38:29 +0000
Subject: [PATCH] arm64: Remove useless UAO IPI and describe how this gets
 enabled
In-Reply-To: <20170109181402.12883-1-james.morse@arm.com>
References: <20170109181402.12883-1-james.morse@arm.com>
Message-ID: <20170110123828.GG21598@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2017 at 06:14:02PM +0000, James Morse wrote:
> Since its introduction, the UAO enable call was broken, and useless.
> commit 2a6dcb2b5f3e ("arm64: cpufeature: Schedule enable() calls instead
> of calling them via IPI"), fixed the framework so that these calls
> are scheduled, so that they can modify PSTATE.
> 
> Now it is just useless. Remove it. UAO is enabled by the code patching
> which causes get_user() and friends to use the 'ldtr' family of
> instructions. This relies on the PSTATE.UAO bit being set to match
> addr_limit, which we do in uao_thread_switch() called via __switch_to().
> 
> All that is needed to enable UAO is patch the code, and call schedule().
> __apply_alternatives_multi_stop() calls stop_machine() when it modifies
> the kernel text to enable the alternatives, (including the UAO code in
> uao_thread_switch()). Once stop_machine() has finished __switch_to() is
> called to reschedule the original task, this causes PSTATE.UAO to be set
> appropriately. An explicit enable() call is not needed.
> 
> Reported-by: Vladimir Murzin <vladimir.murzin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> 
> ==
> Sorry, I forgot about this cleanup after the last round of PAN fixes.
> ---
>  arch/arm64/include/asm/processor.h |  1 -
>  arch/arm64/kernel/cpufeature.c     |  5 ++++-
>  arch/arm64/mm/fault.c              | 14 --------------
>  3 files changed, 4 insertions(+), 16 deletions(-)

Applied for 4.11.

Will
