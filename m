From: will.deacon@arm.com (Will Deacon)
Date: Tue, 16 Aug 2011 10:59:36 +0100
Subject: PB1176 broken in -rc1
In-Reply-To: <CACRpkdbSG=Mnu7QrACn3y3GP-2H4_qT0kR_4C8umCmWc2YCqXQ@mail.gmail.com>
References: <20110810152400.GO10121@e102144-lin.cambridge.arm.com>
	<CACRpkdaoDJy-YKONaz2j07pPvTZuHZ7KgEm6XGxNXK-jNzB8_w@mail.gmail.com>
	<20110816092615.GC28656@e102144-lin.cambridge.arm.com>
	<CACRpkdbSG=Mnu7QrACn3y3GP-2H4_qT0kR_4C8umCmWc2YCqXQ@mail.gmail.com>
Message-ID: <20110816095936.GE28656@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2011 at 10:35:08AM +0100, Linus Walleij wrote:
> Basically that's the realview_defconfig with these
> changes done on top:
> 
> scripts/config --file $(realview_dir)/.config \
>         --enable BLK_DEV_INITRD \
>         --set-str INITRAMFS_SOURCE rootfs-u338.cpio \
>         --enable INITRAMFS_COMPRESSION_NONE \
>         --enable MISC_DEVICES \
>         --enable ARM_CHARLCD \
>         --enable DEBUG_LL \
>         --enable EARLY_PRINTK \
>         --enable ARM_TEST \
>         --enable ARM_TCM_TEST \
>         --set-str CMDLINE "root=/dev/ram0 console=ttyAMA0 earlyprintk mem=128M"
>         yes "" | make $(make_options) oldconfig

The problem is with earlyprintk because your picking up multiple definitions
of DEBUG_LL_UART_OFFSET as a result of basing your config on the defconfig.

Take a look at arch/arm/mach-realview/include/mach/debug-macro.S. I don't
think there's an easy way to fix this because it's used so early, even DT
can't save us.

> > How do you use the interface
> > with the TCMs once they've been mapped at the high address?
> 
> Here is my test code patch I'm cooking RFC:
> 
> ------------8<-----------------------------8<-----------------------------
> From ece57aeca9a03107432c6090733f89f483872163 Mon Sep 17 00:00:00 2001
> From: Linus Walleij <linus.walleij@linaro.org>
> Date: Thu, 30 Jun 2011 14:33:48 +0200
> Subject: [PATCH] ARM TCM sample code
> 
> This is a simple sample snippet of ARM TCM code use, we create
> arm/test to host the code.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

[...]

> -static void __init test_tcm(void)
> -{
> -	u32 *tcmem;
> -	int i;
> -
> -	hello_tcm();
> -	printk("Hello TCM executed from ITCM RAM\n");
> -
> -	printk("TCM variable from testrun: %u @ %p\n", tcmvar, &tcmvar);
> -	tcmvar = 0xDEADBEEFU;
> -	printk("TCM variable: 0x%x @ %p\n", tcmvar, &tcmvar);
> -
> -	printk("TCM assigned variable: 0x%x @ %p\n", tcmassigned, &tcmassigned);
> -
> -	printk("TCM constant: 0x%x @ %p\n", tcmconst, &tcmconst);
> -
> -	/* Allocate some TCM memory from the pool */
> -	tcmem = tcm_alloc(20);
> -	if (tcmem) {
> -		printk("TCM Allocated 20 bytes of TCM @ %p\n", tcmem);
> -		tcmem[0] = 0xDEADBEEFU;
> -		tcmem[1] = 0x2BADBABEU;
> -		tcmem[2] = 0xCAFEBABEU;
> -		tcmem[3] = 0xDEADBEEFU;
> -		tcmem[4] = 0x2BADBABEU;

Hmm, do you need a barrier here to (a) stop the compiler constant folding
the tcm array and (b) force a read back from the TCM? Also, where does the
TCM sit in relation to the L1 cache (yes, I should RTFM...).

> -		for (i = 0; i < 5; i++)
> -			printk("TCM tcmem[%d] = %08x\n", i, tcmem[i]);
> -		tcm_free(tcmem, 20);
> -	}
> -}

[...]

> +	if (tcmem) {
> +		pr_info("CPU: TCM Allocated 20 bytes of TCM @ %p\n", tcmem);
> +		tcmem[0] = CANARY1;
> +		tcmem[1] = CANARY2;
> +		tcmem[2] = CANARY3;
> +		tcmem[3] = CANARY1;
> +		tcmem[4] = CANARY2;

And again here?

> +		for (i = 0; i < 5; i++)
> +			pr_info("CPU: TCM tcmem[%d] = %08x\n", i, tcmem[i]);
> +		BUG_ON(tcmem[0] != CANARY1);
> +		BUG_ON(tcmem[1] != CANARY2);
> +		BUG_ON(tcmem[2] != CANARY3);
> +		BUG_ON(tcmem[3] != CANARY1);
> +		BUG_ON(tcmem[4] != CANARY2);
> +		tcm_free(tcmem, 20);
> +	}
> +	return 0;
> +}

Will
