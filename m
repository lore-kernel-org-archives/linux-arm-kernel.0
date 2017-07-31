From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 31 Jul 2017 18:35:32 +0200
Subject: Uncorrectable bitflips with Linux 4.12 on SAMA5D2
In-Reply-To: <20170717202008.6c798789@bbrezillon>
References: <CAMiSF3CtVY7G=ugt-bpsOOMqLcFrmx7hDstUag2_6H-KrN4yBg@mail.gmail.com>
 <20170717194809.4a080e0c@bbrezillon>
 <20170717202008.6c798789@bbrezillon>
Message-ID: <20170731183532.0c37aa41@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 17 Jul 2017 20:20:08 +0200
Boris Brezillon <boris.brezillon@free-electrons.com> wrote:

> Le Mon, 17 Jul 2017 19:48:09 +0200,
> Boris Brezillon <boris.brezillon@free-electrons.com> a ?crit :
> 
> > +Ludovic, Nicolas and Alexandre
> > 
> > Hi Romain,
> > 
> > Le Mon, 17 Jul 2017 18:11:26 +0200,
> > Romain Izard <romain.izard.pro@gmail.com> a ?crit :
> >   
> > > Hello,
> > > 
> > > On a custom board based on Microchip's SAMA5D2 SoC, I am encountering
> > > ECC problems with the NAND Flash controller. The board is currently
> > > working with Linux v4.9.x, but it does not with Linux 4.12.
> > > 
> > > Some pages on the NAND Flash memory chip of the device have bitflips.
> > > With Linux 4.9.x, the bitflips are fixed by the PMECC code, but with
> > > Linux 4.12, the errors are reported as uncorrectable.
> > > 
> > > From my end, I updated the board's device tree to include the
> > > sama5d2.dtsi as it exists in Linux 4.12, but the rest of the file is
> > > the same as for Linux 4.9. From my understanding, it should be
> > > sufficient as the legacy DTB binding for the NAND controller is
> > > supported.    
> > 
> > I know Ludovic add some problems with the NAND controller on sama5d2,
> > but it was with the new bindings (see the fixes here [1]).
> > 
> > Your problem seems a bit different since you're using the backward
> > compat code.  
> 
> Can you try with the following patch applied?
> 
> --->8---  
> From cb95a16cdd497137872c44d5dd4e251ec73c79c1 Mon Sep 17 00:00:00 2001
> From: Boris Brezillon <boris.brezillon@free-electrons.com>
> Date: Mon, 17 Jul 2017 20:09:59 +0200
> Subject: [PATCH] mtd: nand: atmel: Fix DT backward compatibility in pmecc.c
> 
> PMECC caps extraction from old DT bindings is broken, thus leading to
> erroneous EL registers offset, which in turn make HW ECC unusable on
> sama5d2 when old bindings are in use.
> 
> Passing the NAND dev node instead of the NFC node to of_match_node()
> solves the problem.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Fixes: f88fc122cc34 ("mtd: nand: Cleanup/rework the atmel_nand driver")
> Cc: <stable@vger.kernel.org>

Applied to nand/fixes.

> ---
>  drivers/mtd/nand/atmel/pmecc.c | 21 ++++++---------------
>  1 file changed, 6 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/mtd/nand/atmel/pmecc.c b/drivers/mtd/nand/atmel/pmecc.c
> index 55a8ee5306ea..8c210a5776bc 100644
> --- a/drivers/mtd/nand/atmel/pmecc.c
> +++ b/drivers/mtd/nand/atmel/pmecc.c
> @@ -945,6 +945,7 @@ struct atmel_pmecc *devm_atmel_pmecc_get(struct device *userdev)
>  		 */
>  		struct platform_device *pdev = to_platform_device(userdev);
>  		const struct atmel_pmecc_caps *caps;
> +		const struct of_device_id *match;
>  
>  		/* No PMECC engine available. */
>  		if (!of_property_read_bool(userdev->of_node,
> @@ -953,21 +954,11 @@ struct atmel_pmecc *devm_atmel_pmecc_get(struct device *userdev)
>  
>  		caps = &at91sam9g45_caps;
>  
> -		/*
> -		 * Try to find the NFC subnode and extract the associated caps
> -		 * from there.
> -		 */
> -		np = of_find_compatible_node(userdev->of_node, NULL,
> -					     "atmel,sama5d3-nfc");
> -		if (np) {
> -			const struct of_device_id *match;
> -
> -			match = of_match_node(atmel_pmecc_legacy_match, np);
> -			if (match && match->data)
> -				caps = match->data;
> -
> -			of_node_put(np);
> -		}
> +		/* Find the caps associated to the NAND dev node. */
> +		match = of_match_node(atmel_pmecc_legacy_match,
> +				      userdev->of_node);
> +		if (match && match->data)
> +			caps = match->data;
>  
>  		pmecc = atmel_pmecc_create(pdev, caps, 1, 2);
>  	}
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
