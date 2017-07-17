From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 17 Jul 2017 19:48:09 +0200
Subject: Uncorrectable bitflips with Linux 4.12 on SAMA5D2
In-Reply-To: <CAMiSF3CtVY7G=ugt-bpsOOMqLcFrmx7hDstUag2_6H-KrN4yBg@mail.gmail.com>
References: <CAMiSF3CtVY7G=ugt-bpsOOMqLcFrmx7hDstUag2_6H-KrN4yBg@mail.gmail.com>
Message-ID: <20170717194809.4a080e0c@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Ludovic, Nicolas and Alexandre

Hi Romain,

Le Mon, 17 Jul 2017 18:11:26 +0200,
Romain Izard <romain.izard.pro@gmail.com> a ?crit :

> Hello,
> 
> On a custom board based on Microchip's SAMA5D2 SoC, I am encountering
> ECC problems with the NAND Flash controller. The board is currently
> working with Linux v4.9.x, but it does not with Linux 4.12.
> 
> Some pages on the NAND Flash memory chip of the device have bitflips.
> With Linux 4.9.x, the bitflips are fixed by the PMECC code, but with
> Linux 4.12, the errors are reported as uncorrectable.
> 
> From my end, I updated the board's device tree to include the
> sama5d2.dtsi as it exists in Linux 4.12, but the rest of the file is
> the same as for Linux 4.9. From my understanding, it should be
> sufficient as the legacy DTB binding for the NAND controller is
> supported.

I know Ludovic add some problems with the NAND controller on sama5d2,
but it was with the new bindings (see the fixes here [1]).

Your problem seems a bit different since you're using the backward
compat code.

Could you dump PMECC/NFC regs when booting 4.9 and 4.12, and see if
there's a difference?

> 
> The relevant extract is:
> 
>         nand0: nand at 80000000 {
>             pinctrl-names = "default";
>             pinctrl-0 = <&pinctrl_nand_default>;
>             status = "okay";
>             nand-ecc-mode = "hw";
>             atmel,pmecc-cap = <8>;
>             atmel,pmecc-sector-size = <512>;
>             /delete-property/ atmel,nand-has-dma;
>         };
> 
> The attached files show the same block read through nanddump, with
> Linux 4.9 and Linux 4.12

Yep, the dumps show 2 identical pages except for the bitflip in ECC
block 2, but I can't tell from this dump why PMECC fails to correct
bitflips.

Really sorry that you have to debug this problem, but I don't have a
sama5d2 platform with a NAND on it and couldn't test my
modification on this platform :-/.

Thanks,

Boris

[1]https://lkml.org/lkml/2017/7/11/95
