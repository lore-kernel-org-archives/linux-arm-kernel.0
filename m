From: romain.izard.pro@gmail.com (Romain Izard)
Date: Mon, 17 Jul 2017 18:11:26 +0200
Subject: Uncorrectable bitflips with Linux 4.12 on SAMA5D2
Message-ID: <CAMiSF3CtVY7G=ugt-bpsOOMqLcFrmx7hDstUag2_6H-KrN4yBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On a custom board based on Microchip's SAMA5D2 SoC, I am encountering
ECC problems with the NAND Flash controller. The board is currently
working with Linux v4.9.x, but it does not with Linux 4.12.

Some pages on the NAND Flash memory chip of the device have bitflips.
With Linux 4.9.x, the bitflips are fixed by the PMECC code, but with
Linux 4.12, the errors are reported as uncorrectable.

>From my end, I updated the board's device tree to include the
sama5d2.dtsi as it exists in Linux 4.12, but the rest of the file is
the same as for Linux 4.9. From my understanding, it should be
sufficient as the legacy DTB binding for the NAND controller is
supported.

The relevant extract is:

        nand0: nand at 80000000 {
            pinctrl-names = "default";
            pinctrl-0 = <&pinctrl_nand_default>;
            status = "okay";
            nand-ecc-mode = "hw";
            atmel,pmecc-cap = <8>;
            atmel,pmecc-sector-size = <512>;
            /delete-property/ atmel,nand-has-dma;
        };

The attached files show the same block read through nanddump, with
Linux 4.9 and Linux 4.12

Best regards,
-- 
Romain Izard
-------------- next part --------------
A non-text attachment was scrubbed...
Name: ad97000_nofix.dump
Type: application/octet-stream
Size: 10880 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170717/da725c62/attachment-0002.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: ad97000_fix.dump
Type: application/octet-stream
Size: 10880 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170717/da725c62/attachment-0003.obj>
