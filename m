From: rabin@rab.in (Rabin Vincent)
Date: Mon, 2 Jun 2014 18:53:43 +0200
Subject: [PATCH] ARM: fix string functions on !MMU
In-Reply-To: <20140428075149.GB28564@pengutronix.de>
References: <1398103808-24380-1-git-send-email-rabin@rab.in>
 <20140428075149.GB28564@pengutronix.de>
Message-ID: <20140602165343.GA20915@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 09:51:49AM +0200, Uwe Kleine-K?nig wrote:
> On Mon, Apr 21, 2014 at 08:10:08PM +0200, Rabin Vincent wrote:
> > 8c56cc8be5b38e ("ARM: 7449/1: use generic strnlen_user and
> > strncpy_from_user functions") apparently broken those string operations
> > for !MMU.  USER_DS == KERNEL_DS on !MMU, so user_addr_max() always
> > restricts the addresses to TASK_SIZE.
> > 
> > TASK_SIZE has anyway no meaning on !MMU, so make user_addr_max() not
> > restrict anything.
> > 
> > Signed-off-by: Rabin Vincent <rabin@rab.in>
> I tested this on my efm32 machine and it booted just fine. Before I used
> a patch that did:
> 
> diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
> index 02fa2558f662..f25c7f4c5a44 100644
> --- a/arch/arm/include/asm/memory.h
> +++ b/arch/arm/include/asm/memory.h
> @@ -92,9 +92,12 @@
>   * It is difficult to define and perhaps will never meet the original meaning
>   * of this define that was meant to.
>   * Fortunately, there is no reference for this in noMMU mode, for now.
> + *
> + * HACK: copy_from_user must even handle copying from flash. So don't impose a
> + * limit at all. Not sure this is correct ...
>   */
>  #ifndef TASK_SIZE
> -#define TASK_SIZE              (CONFIG_DRAM_SIZE)
> +#define TASK_SIZE              (~0UL)
>  #endif

The current code for user_addr_max() for !MMU is essentialy:

	#define user_addr_max() TASK_SIZE

which is obviously wrong for the KERNEL_DS case, since it should be
~0UL.  And user space can access all that the kernel does, so there
should be no restriction for USER_DS either (which is anyway equivalent
to KERNEL_DS).  Hence, I think my patch, which removes the usage of
TASK_SIZE in user_addr_max() for !MMU, is correct regardless of what the
correct definition or meaning of TASK_SIZE for !MMU is.

If you make TASK_SIZE to ~0UL (which is probably what it should be on
!MMU), then the result is equivalent to my patch but it is not
semantically correct since you are restricting user_addr_max() to
TASK_SIZE even for the KERNEL_DS.

What do you say?
