From: eric.y.miao@gmail.com (Eric Miao)
Date: Sat, 29 Jan 2011 13:47:16 +0800
Subject: kexec on kirkwood kernels?
In-Reply-To: <20110128032454.GG22555@localhost>
References: <20110127030024.GF19307@localhost>
	<20110127072433.GI1147@pengutronix.de>
	<20110128032454.GG22555@localhost>
Message-ID: <AANLkTintXocCNKz+XkbnJB9EPxqRvWpVQFBWVHcrxmQK@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This worked ok on dove processor with several fixes. What is the
output of the failed bootup? If kirkwood comes with L2, please check
L2 is flushed and cache disabled before booting into the 2nd kernel.

- Eric

On Friday, January 28, 2011, Eric Cooper <ecc@cmu.edu> wrote:
> On Thu, Jan 27, 2011 at 08:24:33AM +0100, Uwe Kleine-K?nig wrote:
>> Try enabling DEBUG_LL and EARLY_PRINTK in the kernel to boot and pass
>> ? ? ? earlyprintk
>> as kernel parameter.
>
> Thanks, that helped quite a bit. ?After inserting various print
> statements, I found that the system is hanging in the readl call in
> orion_pcie_dev_id. ?The call chain is:
>
>  ? ?start_kernel
>  ? ?time_init
>  ? ?kirkwood_timer_init
>  ? ?kirkwood_find_tclk
>  ? ?kirkwood_pcie_id
>  ? ?orion_pcie_dev_id
>  ? ?readl
>
> The readl is attempting to access the address
> KIRKWOOD_REGS_VIRT_BASE + 0x40000.
>
> This same code gets executed successfully when the kernel is started
> from u-boot; I'm not sure what's different in the post-kexec
> environment. ?Any suggestions on what to try next would be
> appreciated.
>
> --
> Eric Cooper ? ? ? ? ? ? e c c @ c m u . e d u
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
