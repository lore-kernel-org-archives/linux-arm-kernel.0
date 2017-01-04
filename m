From: will.deacon@arm.com (Will Deacon)
Date: Wed, 4 Jan 2017 15:23:06 +0000
Subject: [PATCH] arm64: restore get_current() optimisation
In-Reply-To: <1483468021-8237-1-git-send-email-mark.rutland@arm.com>
References: <1483468021-8237-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20170104152305.GL18193@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 03, 2017 at 06:27:01PM +0000, Mark Rutland wrote:
> Hi Catalin,
> 
> My THREAD_INFO_IN_TASK series had an unintended performance regression in
> get_current() / current_thread_info(). Could you please take the below as a
> fix for the next rc?
> 
> Thanks,
> Mark.
> 
> ---->8----
> Commit c02433dd6de32f04 ("arm64: split thread_info from task stack")
> inverted the relationship between get_current() and
> current_thread_info(), with sp_el0 now holding the current task_struct
> rather than the current thead_info. The new implementation of
> get_current() prevents the compiler from being able to optimize repeated
> calls to either, resulting in a noticeable penalty in some
> microbenchmarks.
> 
> This patch restores the previous optimisation by implementing
> get_current() in the same way as our old current_thread_info(), using a
> non-volatile asm statement.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Reported-by: Davidlohr Bueso <dbueso@suse.de>
> ---
>  arch/arm64/include/asm/current.h | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Thanks for putting this back like it was!

Will
