From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 01 Jan 2016 18:06:30 +0100
Subject: [PATCH] [BUG] clk: rockchip: don't mark clock names as initconst
In-Reply-To: <2791943.MBZ53mI7Gp@wuerfel>
References: <2791943.MBZ53mI7Gp@wuerfel>
Message-ID: <1799610.nrn5HMCSxL@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Am Freitag, 1. Januar 2016, 14:42:52 schrieb Arnd Bergmann:
> The latest changes to the rockchip clk implementation cause
> tons of warnings and/or errors (depending on the configuration):
> 
> WARNING: vmlinux.o(.data+0x125394): Section mismatch in reference from the
> variable __compound_literal.125 to the (unknown reference)
> .init.rodata:(unknown)
> 
> The reason is a compount literal in a macro that refers to an
> object in the .init.rodata section:
> 
>  #define COMPOSITE_FRACMUX(_id, cname, pname, f, mo, df, go, gs, gf, ch) \
>         {                                                       \
> 		...
>                 .child          = &(struct rockchip_clk_branch)ch, \
>         }
> 
> 'ch' here is placed in .data, and I could find no way to override that
> using an attribute or pragma because there is no identifier associated
> with it.

"[PATCH] clk: rockchip: fix section mismatches with new child-clocks" [0]

should be in Mike's + Stephen's inbox since last week as well, which moves the 
offending new elements into separate entities, which can have __initdata 
attributes again.


Heiko

[0] http://www.spinics.net/lists/arm-kernel/msg471295.html
