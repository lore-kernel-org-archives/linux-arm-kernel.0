From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 24 Oct 2016 12:31:31 +0100
Subject: [PATCH] arm64: Neaten show_regs, remove KERN_CONT
In-Reply-To: <4cbf196b83cd9d175634e7056744dc649ae87f63.1477253239.git.joe@perches.com>
References: <4cbf196b83cd9d175634e7056744dc649ae87f63.1477253239.git.joe@perches.com>
Message-ID: <20161024113131.GH15620@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 23, 2016 at 01:40:49PM -0700, Joe Perches wrote:
> commit db4b0710fae9 ("arm64: fix show_regs fallout from KERN_CONT changes")
> corrected the KERN_CONT fallout from commit 4bcc595ccd80
> ("printk: reinstate KERN_CONT for printing continuation lines"), but
> the code still has unnecessary KERN_CONT uses.  Remove them.

Why are these unnecessary KERN_CONTs a larger problem than duplicating
the format string for a third time? Having to duplicate it at all was
annoying enough.

Overall, to avoid messing with the KERN_CONT mess it'd be nicer to
format this all into a buffer (with the format string only existing the
once) and subsequently print it with one printk call.

> Miscellanea:
> 
> o Remove unnecessary trailing blank from the output too.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  arch/arm64/kernel/process.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 01753cd7d3f0..2278e7197a8e 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -190,18 +190,16 @@ void __show_regs(struct pt_regs *regs)
>  
>  	i = top_reg;
>  
> -	while (i >= 0) {
> -		printk("x%-2d: %016llx ", i, regs->regs[i]);
> +	if (i >= 0 && !(i % 2)) {

This is difficult to read. Given we know that in either case i >= 0, and
to retain the style of existing code, this would be better as:

	if (i % 2 == 0) {

> +		printk("x%-2d: %016llx\n", i, regs->regs[i]);
>  		i--;
> -
> -		if (i % 2 == 0) {
> -			pr_cont("x%-2d: %016llx ", i, regs->regs[i]);
> -			i--;
> -		}
> -
> -		pr_cont("\n");
>  	}
> -	printk("\n");

This should be retained. It's meant to be there *in addition* to the
newline on the final reg line.

> +	while (i > 0) {
> +		printk("x%-2d: %016llx x%-2d: %016llx\n",
> +		       i, regs->regs[i],
> +		       i - 1, regs->regs[i - 1]);
> +		i -= 2;
> +	}
>  }

Thanks,
Mark.
