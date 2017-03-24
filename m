From: heiko.carstens@de.ibm.com (Heiko Carstens)
Date: Fri, 24 Mar 2017 09:14:50 +0100
Subject: [PATCH] lkdtm: add bad USER_DS test
In-Reply-To: <20170323203419.GA62859@beast>
References: <20170323203419.GA62859@beast>
Message-ID: <20170324081450.GA5891@osiris>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 23, 2017 at 01:34:19PM -0700, Kees Cook wrote:
> This adds CORRUPT_USER_DS to check that the get_fs() test on syscall return
> still sees USER_DS during the new VERIFY_PRE_USERMODE_STATE checks.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

...

> +void lkdtm_CORRUPT_USER_DS(void)
> +{
> +	/*
> +	 * Test that USER_DS has been set correctly on exiting a syscall.
> +	 * Since setting this higher than USER_DS (TASK_SIZE) would introduce
> +	 * an exploitable condition, we lower it instead, since that should
> +	 * not create as large a problem on an unprotected system.
> +	 */
> +	mm_segment_t lowfs;
> +#ifdef MAKE_MM_SEG
> +	lowfs = MAKE_MM_SEG(TASK_SIZE - PAGE_SIZE);
> +#else
> +	lowfs = TASK_SIZE - PAGE_SIZE;
> +#endif
> +
> +	pr_info("setting bad task size limit\n");
> +	set_fs(lowfs);
> +}

This won't work on architectures where the set_fs() argument does not
contain an address but an address space identifier. This is true e.g. for
s390 and as far as I know also for sparc.
On s390 we have complete distinct address spaces for kernel and user space
that each start at address zero.
