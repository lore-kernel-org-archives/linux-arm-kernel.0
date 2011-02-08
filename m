From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 08 Feb 2011 14:25:15 +0000
Subject: [PATCH v3 2/5] ARM: pm: add generic CPU suspend/resume support
In-Reply-To: <20110208123322.GB22592@n2100.arm.linux.org.uk>
References: <AANLkTintBD2Gfb3pkPZPe2mreU5EatUnNwUqR-id7q+M@mail.gmail.com>
	<20110207133457.GE31929@n2100.arm.linux.org.uk>
	<AANLkTi=B45PuOErxR49Gfhfq6-=y_NugbWBLBo0MEoCt@mail.gmail.com>
	<20110207141734.GG31929@n2100.arm.linux.org.uk>
	<AANLkTi=JCQBH4sjJzWajYJx6VuUTgdB76nxXbvKTrcwc@mail.gmail.com>
	<20110207143351.GH31929@n2100.arm.linux.org.uk>
	<AANLkTikVQG1ngkT7VwvjiSJjSfNsSMw=msfhc44emx6B@mail.gmail.com>
	<20110207150233.GI31929@n2100.arm.linux.org.uk>
	<1297160512.31587.17.camel@e102568-lin.cambridge.arm.com>
	<20110208112323.GA22592@n2100.arm.linux.org.uk>
	<20110208123322.GB22592@n2100.arm.linux.org.uk>
Message-ID: <1297175115.31587.94.camel@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-02-08 at 12:33 +0000, Russell King - ARM Linux wrote:

<snip>

> > Yes, but this is what is currently done, so at the present time I'm
> > just sorting out what's already in the kernel.  If we need further
> > changes, then that needs to be built on top of this.
> 
> Like this:
> 
>  arch/arm/kernel/sleep.S |   26 +++++++++++++++++++++++++-
>  1 files changed, 25 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
> index 9f106fa..e10618f 100644
> --- a/arch/arm/kernel/sleep.S
> +++ b/arch/arm/kernel/sleep.S
> @@ -25,7 +25,14 @@ ENTRY(cpu_suspend)
>  	stmfd	sp!, {r1, r2, r3, ip}	@ save v:p, virt SP, retfn, phys resume fn
>  	ldr	r3, =sleep_save_sp
>  	add	r2, sp, r1		@ convert SP to phys
> +#ifdef CONFIG_SMP
> +	ALT_SMP(mrc p15, 0, lr, c0, c0, 5)
> +	ALT_UP(mov lr, #0)
> +	and	lr, lr, #15
> +	str	r2, [r3, lr, lsl #2]	@ save phys SP
> +#else
>  	str	r2, [r3]		@ save phys SP
> +#endif

<snip>
	
>  sleep_save_sp:
> -	.word	0				@ preserve stack phys ptr here
> +	.rept	CONFIG_NR_CPUS
> +	.long	0				@ preserve stack phys ptr here
> +	.endr
> 

Yes Russell, thanks that's what we are currently doing for MP, it looks 
ok. As for the page tables, I know you already replied and I took your
point. It is on the cpuidle path so page tables should be created in C,
beforehand as you pointed out (with the 1:1 map required), once for all.
I just wanted to say, maybe we can save the pgd pointer (with the
required 1:1 for MMU on) in a pc-relative addressable location that you
can retrieve on resume, eliminating the code changing the original page
table and replacing it with pgd switching.
But again it is just a suggestion, I understand your point, no need to
comment further.

Many thanks,
Lorenzo
