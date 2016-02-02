From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 02 Feb 2016 13:49:56 +0100
Subject: [PATCH] clk: vt8500: don't return possibly uninitialized data
In-Reply-To: <20160202011545.GG4848@codeaurora.org>
References: <4790407.6zgSQCdsSB@wuerfel> <20160202011545.GG4848@codeaurora.org>
Message-ID: <2210116.QsPesySkh0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 01 February 2016 17:15:45 Stephen Boyd wrote:
> My compiler still gets warnings even after this patch is applied.
> 
> drivers/clk/clk-vt8500.c: In function ?wm8750_find_pll_bits?:
> drivers/clk/clk-vt8500.c:509:12: warning: ?best_div2? may be used uninitialized in this function [-Wmaybe-uninitialized]
> drivers/clk/clk-vt8500.c:508:12: warning: ?best_div1? may be used uninitialized in this function [-Wmaybe-uninitialized]
> drivers/clk/clk-vt8500.c:507:14: warning: ?best_mul? may be used uninitialized in this function [-Wmaybe-uninitialized]
> drivers/clk/clk-vt8500.c: In function ?wm8650_find_pll_bits?:
> drivers/clk/clk-vt8500.c:430:12: warning: ?best_div2? may be used uninitialized in this function [-Wmaybe-uninitialized]
> drivers/clk/clk-vt8500.c:429:12: warning: ?best_div1? may be used uninitialized in this function [-Wmaybe-uninitialized]
> drivers/clk/clk-vt8500.c:428:14: warning: ?best_mul? may be used uninitialized in this function [-Wmaybe-uninitialized]
> drivers/clk/clk-vt8500.c: In function ?wm8850_find_pll_bits?:
> drivers/clk/clk-vt8500.c:560:12: warning: ?best_div2? may be used uninitialized in this function [-Wmaybe-uninitialized]
> drivers/clk/clk-vt8500.c:559:12: warning: ?best_div1? may be used uninitialized in this function [-Wmaybe-uninitialized]
> drivers/clk/clk-vt8500.c:558:14: warning: ?best_mul? may be used uninitialized in this function [-Wmaybe-uninitialized]
> 

I see what you mean now. I checked different gcc versions, and with my patch I get
the warnings for 4.6 through 4.9, but not for 5.x.

In general, I tried to only address warnings I still see with newer gcc version,
as they are better about false positives. Do you think it's ok to take the
patch as is then? Otherwise we probably have to add fake initializations which
would shut up the warnings but not help with the code quality.

	Arnd
