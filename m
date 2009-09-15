From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 15 Sep 2009 15:41:08 +0200
Subject: [PATCH] arm: remove unused code in delay.S
In-Reply-To: <1253017761.3273.117.camel@linux-1lbu>
References: <1252875960-21512-1-git-send-email-felipe.contreras@gmail.com>
	<20090915103739.GA19519@elf.ucw.cz>
	<1253017761.3273.117.camel@linux-1lbu>
Message-ID: <200909151541.08852.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?t 15. z??? 2009 14:29:21 Steve Chen napsal(a):
> On Tue, 2009-09-15 at 12:37 +0200, Pavel Machek wrote:
> > > >> > Because then you get it whenever you configure for V4 as the
> > > >> > lowest denominator CPU, which leads to the buggy behaviour on
> > > >> > better CPUs. It's far better to leave it as is and just accept
> > > >> > that the old CPUs will have longer than necessary delays.  If
> > > >> > people really really care (and there's likely to only be a small
> > > >> > minority of them now) changing the '0' to a '1' is a very simple
> > > >> > change for them to carry in their local tree.  Unlike getting the
> > > >> > right unrolling etc.
> > > >>
> > > >> Well, they can also 'git revert' this patch. If somebody really
> > > >> cares I think they should shout now and provide a better patch,
> > > >> otherwise this one should be merged.
> > > >
> > > > On the other hand, having the code there as it currently stands is
> > > > not harmful in any way, so leaving it there is just as easy.
> > >
> > > It makes the code less understandable. I'm not sure about linux's
> > > practices, but an #if 0 generally means somebody is being lazy.
> >
> > Not in this case, as you was explained to you. You may want to add
> > explaining comment above #if 0....
> > 								Pavel
> 
> Perhaps we can document with something like..
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index aef63c8..ca8d535 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -813,6 +813,14 @@ config ARM_ERRATA_460075
>  	  ACTLR register. Note that setting specific bits in the ACTLR
> register
>  	  may not be available in non-secure mode.
> 
> +config OLD_CPU_DELAY
> +	depends on CPU_32v3 || CPU_32v4 || CPU_32v4T
> +	bool "Accurate delays for older CPU"
> +	def_bool n
> +	help
> +	  Enable if observing longer than expected delays and need more
> +	  accurate delays on older CPUs.
> +
>  endmenu
> 
>  source "arch/arm/common/Kconfig"
> diff --git a/arch/arm/lib/delay.S b/arch/arm/lib/delay.S
> index 8d6a876..8b3fa63 100644
> --- a/arch/arm/lib/delay.S
> +++ b/arch/arm/lib/delay.S
> @@ -42,7 +42,7 @@ ENTRY(__const_udelay)				@ 0 <= r0 <= 0x7fffff06
>  @ Delay routine
>  ENTRY(__delay)
>  		subs	r0, r0, #1
> -#if 0
> +#if CONFIG_OLD_CPU_DELAY

ifdef please

>  		movls	pc, lr
>  		subs	r0, r0, #1
>  		movls	pc, lr
> 
