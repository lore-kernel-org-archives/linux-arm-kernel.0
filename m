From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 15 Oct 2012 23:02:25 +0900
Subject: [PATCH] ARM: s3c: mark s3c2440_clk_add as __init_refok
In-Reply-To: <201210121114.52348.arnd@arndb.de>
References: <201210121114.52348.arnd@arndb.de>
Message-ID: <10dc01cdaadd$b4a32ee0$1de98ca0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann wrote:
> 
> s3c2440_clk_add is a subsys_interface method and calls clkdev_add_table,
> which is marked as __init. The modpost script complains about this
> because we must not call an __init function from a function in the .text
> section, and we cannot reference an __init function from a
> subsys_interface
> pointer.
> 
> I have verified that the only code path into s3c2440_clk_add() is
> from "int __init s3c2440_init(void)", so s3c2440_clk_add can be marked
> __init_refok instead.
> 
> Without this patch, building mini2440_defconfig results in:
> 
> WARNING: vmlinux.o(.text+0x9848): Section mismatch in reference from the
> function s3c2440_clk_add() to the function .init.text:clkdev_add_table()
> The function s3c2440_clk_add() references
> the function __init clkdev_add_table().
> This is often because s3c2440_clk_add lacks a __init
> annotation or the annotation of clkdev_add_table is wrong.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

> Cc: Ben Dooks <ben-linux@fluff.org>
> ---
> 
> I'll put this into arm-soc/fixes unless I hear objections. This replaces
> the
> earlier "clk: don't mark clkdev_add_table as init" as suggested by
Russell.
> 
Yeah, I read it just now and I agree with this patch.

Thanks for your fix.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
