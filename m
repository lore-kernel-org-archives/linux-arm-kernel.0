From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Aug 2015 23:47:54 +0100
Subject: [PATCH] ARM: keystone: add a work around to handle asynchronous
 external abort
In-Reply-To: <55D25C64.3090107@ti.com>
References: <1439320409-20084-1-git-send-email-m-karicheri2@ti.com>
 <55CDF579.4050408@ti.com>
 <20150814140934.GX7557@n2100.arm.linux.org.uk>
 <55CE05EC.4040909@oracle.com> <55CE633C.10402@ti.com>
 <20150814215617.GA7557@n2100.arm.linux.org.uk>
 <55D25C64.3090107@ti.com>
Message-ID: <20150817224754.GI7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 17, 2015 at 06:12:52PM -0400, Murali Karicheri wrote:
> Unfortunately, this patch causes boot to stop very early just after
> local_abt_enable() is called in early_trap_init(). Before and After applying
> the patch, here is what the boot log looks like. Do you see any issue with
> the patch diff shown below? Patch is applied on top of v4.2-rc7. I have some
> additional base port patches applied to boot kernel on my EVM based on a new
> SoC.

Try moving the call to local_abt_enable() below forward to the end of
devicemaps_init().  I suspect this is too early for the abort handlers
to reliably run.

> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
> index d358226..381c4e4 100644
> --- a/arch/arm/kernel/traps.c
> +++ b/arch/arm/kernel/traps.c
> @@ -871,6 +871,11 @@ void __init early_trap_init(void *vectors_base)
> 
>         flush_icache_range(vectors, vectors + PAGE_SIZE * 2);
>         modify_domain(DOMAIN_USER, DOMAIN_CLIENT);
> +
> +       /* Enable imprecise aborts */
> +       local_abt_enable();
> +

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
