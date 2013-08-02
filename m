From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Fri, 2 Aug 2013 18:47:37 +0200
Subject: [PATCH] clk: clk-divider: Export clk_register_divider()
In-Reply-To: <1375460047-27160-1-git-send-email-festevam@gmail.com>
References: <1375460047-27160-1-git-send-email-festevam@gmail.com>
Message-ID: <20987.58025.296592.412693@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Fabio Estevam writes:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> clk_register_divider() needs to be exported so that it could be used
> in a module driver, otherwise we get the following error:
> 
> ERROR: "clk_register_divider" [sound/soc/mxs/snd-soc-mxs.ko] undefined!
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  drivers/clk/clk-divider.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> index 6d55eb2..98ee97f 100644
> --- a/drivers/clk/clk-divider.c
> +++ b/drivers/clk/clk-divider.c
> @@ -317,6 +317,7 @@ struct clk *clk_register_divider(struct device *dev, const char *name,
>  	return _register_divider(dev, name, parent_name, flags, reg, shift,
>  			width, clk_divider_flags, NULL, lock);
>  }
> +EXPORT_SYMBOL_GPL(clk_register_divider);
>  
>  /**
>   * clk_register_divider_table - register a table based divider clock with
> -- 
Did you try unloading and reloading the module with this patch?

The registered clock divider will not be deregistered, but will be
reused upon reload, still using the old (now unmapped) address to
access the clk registers. Thus the whole approach used in snd-soc-mxs
is broken by design (at least for modules).

You would need to keep the mapping of the base registers established
upon the first module load to let the clock divider registered from
the first module load stay operational across module unload/load.

I already considered creating a patch for this, but the whole approach
seemed me too crappy to submit it to mainline.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
