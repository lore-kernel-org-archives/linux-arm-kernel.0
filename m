From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Fri, 07 Feb 2014 10:06:08 -0300
Subject: [PATCH] clk: respect the clock dependencies in of_clk_init
In-Reply-To: <1391554766-11285-1-git-send-email-gregory.clement@free-electrons.com>
References: <1391554766-11285-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <52F4DA40.4090804@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

El 04/02/14 19:59, Gregory CLEMENT escribi?:
> Until now the clock providers were initialized in the order found in
> the device tree. This led to have the dependencies between the clocks
> not respected: children clocks could be initialized before their
> parent clocks.
>
> Instead of forcing each platform to manage its own initialization order,
> this patch adds this work inside the framework itself.
>
> Using the data of the device tree the of_clk_init function now delayed
> the initialization of a clock provider if its parent provider was not
> ready yet.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

After discussing this on IRC with Ezequiel, I must say I'm not really 
fond of this solution, as it adds unnecessary complexity to the 
framework and slows down clock registration to solve one particular 
problem that can be resolved in a simpler, less intrusive way.

The triggering issue which has resulted on this patch is really a simple 
dependency on the name of the parent clock - something that should not 
be an issue if DT is used to provide them (see of_clk_get_parent_name), 
and even when this is not the case, it should not require poking the 
clock tree to find out. It wouldn't be hard to fix however, even if you 
cannot modify your device trees to provide proper naming; a tiny patch 
like the one below should suffice (Ezequiel has kindly tested it today 
on a a370-rd and found it working correctly).

In other words, I feel this patch is a pretty good demonstration of 
over-engineering and bloating of an otherwise good framework to cover up 
for bugs/bad design on other parts of the kernel. Think about it; why 
does the framework require char *parent instead of struct clk *parent to 
link a child with their parent? Randomly-ordered registration is a 
pretty core principle of it; whether by design or not.

So, until someone has a real reason to enforce dependencies on clock 
registration time, I would like this to stay uncommited. And, if the 
time comes and something like this is ever needed, *please* make it 
optional (ie, have a special macro and separate table to register clocks 
which are dependency-sensitive, and do so after registering all the 
non-dependency-sensitive clocks).

Cheers,

Emilio

-----8<------

 From ffdb49506e3ce92090c15e1f9b37f4d465097ac1 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Emilio=20L=C3=B3pez?= <emilio@elopez.com.ar>
Date: Thu, 6 Feb 2014 18:07:07 -0300
Subject: [PATCH] clk: mvebu: fix name dependency during registration time

Currently, mvebu_clk_gating_setup has a silly dependency on clock
registration order just to gather the parent clock name. This is
completely unnecesary, as it supports using an already provided name
via the clk_gating_soc_desc structs, and we can therefore solve this
issue with a 69+/- line patch. But, given that the parent name is
always "tclk" as default-hardcoded on mvebu_coreclk_setup(), we can
just default-hardcode it here too and get away with solving this
problem with a one-liner.
---
  drivers/clk/mvebu/common.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/mvebu/common.c b/drivers/clk/mvebu/common.c
index 25ceccf..6c63b43 100644
--- a/drivers/clk/mvebu/common.c
+++ b/drivers/clk/mvebu/common.c
@@ -121,7 +121,7 @@ void __init mvebu_clk_gating_setup(struct 
device_node *np,
  	struct clk_gating_ctrl *ctrl;
  	struct clk *clk;
  	void __iomem *base;
-	const char *default_parent = NULL;
+	const char *default_parent = "tclk";
  	int n;

  	base = of_iomap(np, 0);
-- 
1.8.5.3
