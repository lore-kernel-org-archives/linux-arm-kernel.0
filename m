From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Mon, 11 Oct 2010 13:39:13 +0300
Subject: [PATCH] ARM: allow, but warn, when issuing ioremap() on RAM
In-Reply-To: <1286791544.19739.31.camel@e102109-lin.cambridge.arm.com>
References: <1286444662-16843-1-git-send-email-felipe.contreras@gmail.com>
	<20101007192245.GC26435@n2100.arm.linux.org.uk>
	<AANLkTikQKY7pOobD+==uT5Cy0poT=O5wDMKtbVyJVNbO@mail.gmail.com>
	<20101008175308.GA10975@n2100.arm.linux.org.uk>
	<AANLkTi=ERZjVDS=Q7aw1zA23KF68irUP3vvKLZw5meBU@mail.gmail.com>
	<20101008230451.GB10975@n2100.arm.linux.org.uk>
	<20101008232539.GA28697@kroah.com>
	<20101008234448.GD10975@n2100.arm.linux.org.uk>
	<20101009000046.GA30616@kroah.com>
	<20101009002546.GB14675@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1010082210150.3107@xanadu.home>
	<1286791544.19739.31.camel@e102109-lin.cambridge.arm.com>
Message-ID: <AANLkTinMuKDpbL9ka61QhUFJfze_HWWHxjUbAqbz2_vi@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 11, 2010 at 1:05 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> We could be a bit more flexible as a temporary solution. But that's a
> hack and doesn't guarantee the attributes that the driver requested. If
> the driver would use writel/readl, that's not too bad since we pushed
> explicit barriers in these macros.
>
> It would need to be improved to invalidate the corresponding cache lines
> (using the DMA API?) but it would look even worse.
>
>
> diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
> index 6bdf42c..082bbd0 100644
> --- a/arch/arm/mm/ioremap.c
> +++ b/arch/arm/mm/ioremap.c
> @@ -204,10 +204,13 @@ void __iomem * __arm_ioremap_pfn_caller(unsigned long pfn,
> ?#endif
>
> ? ? ? ?/*
> - ? ? ? ?* Don't allow RAM to be mapped - this causes problems with ARMv6+
> + ? ? ? ?* Don't allow RAM to be mapped as Device memory - this causes
> + ? ? ? ?* problems with ARMv6+
> ? ? ? ? */
> ? ? ? ?if (WARN_ON(pfn_valid(pfn)))
> - ? ? ? ? ? ? ? return NULL;
> + ? ? ? ? ? ? ? if (__LINUX_ARM_ARCH__ >= 6 &&
> + ? ? ? ? ? ? ? ? ? (mtype != MT_DEVICE_CACHED || mtype != MT_DEVICE_WC))
> + ? ? ? ? ? ? ? ? ? ? ? mtype = MT_DEVICE_WC;
>
> ? ? ? ?type = get_mem_type(mtype);
> ? ? ? ?if (!type)

I will try that, but from what I can see this might still break some
drivers, right? I still think just having the warning for now should
be enough.

Anyway, I'm reading the TRM and I can't find any mention of this.
Catalin, can you point out where is this mentioned, and also, can you
confirm if this would affect only the memory that has the double
mapping, or it can corrupt other memory as well?

Cheers.

-- 
Felipe Contreras
