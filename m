From: m.nazarewicz@samsung.com (=?utf-8?B?TWljaGHFgiBOYXphcmV3aWN6?=)
Date: Sun, 05 Sep 2010 03:53:55 +0200
Subject: [PATCH 1/6] ARM: Add inline function smp_cpu() for early init
	testing
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02CCFE75A8@dbde02.ent.ti.com>
References: <4C6CFBAF.6020407@canonical.com>
	<20100819095705.GU12184@atomide.com>
	<20100819102025.GA32151@n2100.arm.linux.org.uk>
	<20100820120622.GL25742@atomide.com>
	<20100830225527.GC11597@atomide.com>
	<20100902133637.GJ26319@n2100.arm.linux.org.uk>
	<20100902161659.GJ11597@atomide.com>
	<20100902161846.GK11597@atomide.com>
	<20100902170830.GW26319@n2100.arm.linux.org.uk>
	<20100902174244.GU11597@atomide.com>
	<20100902192659.GW11597@atomide.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02CCFE75A8@dbde02.ent.ti.com>
Message-ID: <op.vijd75a97p4s8u@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 03 Sep 2010 14:12:22 +0200, Shilimkar, Santosh <santosh.shilimkar@ti.com> wrote:
> diff --git a/arch/arm/include/asm/smp_plat.h b/arch/arm/include/asm/smp_plat.h
> index 8db3512..82bc488 100644
> --- a/arch/arm/include/asm/smp_plat.h
> +++ b/arch/arm/include/asm/smp_plat.h
> @@ -39,4 +39,11 @@ static inline int cache_ops_need_broadcast(void)
>  #define UP(instr...)	_str(instr)
>  #endif
> +static inline int smp_cpu(void)
> +{
> +        u32 mpidr;
> +        asm volatile("mrc p15, 0, %0, c0, c0, 5" : "=r" (mpidr));
> +        return (mpidr >> 31) ? !(mpidr >> 30) : 0;

This always returns 0.  If (mpdir >> 31) is true then (mpidr >> 30) is
either 2 or 3.  Did you mean:

+	return (mpidr >> 30) == 2;

> +}
> +

-- 
Best regards,                                        _     _
| Humble Liege of Serenely Enlightened Majesty of  o' \,=./ `o
| Computer Science,  Micha? "mina86" Nazarewicz       (o o)
+----[mina86*mina86.com]---[mina86*jabber.org]----ooO--(_)--Ooo--
