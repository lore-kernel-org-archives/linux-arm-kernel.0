From: giometti@enneenne.com (Rodolfo Giometti)
Date: Tue, 31 Dec 2013 11:45:13 +0100
Subject: Can't boot newer kernel on Armada 370 dev board
In-Reply-To: <20131231103503.3bba7c08@skate>
References: <20131230174738.GA4172@enneenne.com>
 <20131230181205.GA32362@lunn.ch>
 <20131230183908.GB4172@enneenne.com>
 <20131230185240.GA32537@lunn.ch> <20131231103503.3bba7c08@skate>
Message-ID: <20131231104513.GE4172@enneenne.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 31, 2013 at 10:35:03AM +0100, Thomas Petazzoni wrote:
> 
> No, that's the opposite.
> 
> The mainline kernel uses 0xD0000000 for this board, because originally
> the Marvell Armada 370 DB was shipped with an old U-Boot, which was
> mapping registers at 0xD0000000.
> 
> Apparently, they are now shipping these boards with a more recent
> version of U-Boot that uses 0xF1000000. Therefore, Rodolfo should
> change the kernel from 0xD0000000 to 0xF1000000.

Yes, looking at u-boot code I found that my u-boot uses 0xF1000000
addresses.

> The change to be applied is:
> 
> diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
> index 08a56bc..9aa76b4 100644
> --- a/arch/arm/boot/dts/armada-370-db.dts
> +++ b/arch/arm/boot/dts/armada-370-db.dts
> @@ -30,7 +30,7 @@
>         };
>  
>         soc {
> -               ranges = <MBUS_ID(0xf0, 0x01) 0 0xd0000000 0x100000
> +               ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
>                           MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000>;
>  
>                 internal-regs {

Done.

> Also, if you have earlyprintk enabled, make sure you have
> CONFIG_DEBUG_MVEBU_UART_ALTERNATE enabled and CONFIG_DEBUG_MVEBU_UART
> disabled.

Done.

> Let me know if that works for you.

It works! :-)

   Starting kernel ...

   Uncompressing Linux... done, booting the kernel.
   Booting Linux on physical CPU 0x0
   Linux version 3.13.0-rc6-dirty (giometti at hulk) (gcc version 4.7.3 (Ubuntu/Linaro
    4.7.3-1ubuntu1) ) #20 SMP Tue Dec 31 11:32:33 CET 2013
   CPU: ARMv7 Processor [561f5811] revision 1 (ARMv7), cr=10c53c7d
   CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
   Machine model: Marvell Armada 370 Evaluation Board
   bootconsole [earlycon0] enabled
   Memory policy: Data cache writeback
   On node 0 totalpages: 262144

Thanks a lot!

Rodolfo

-- 

GNU/Linux Solutions                  e-mail: giometti at enneenne.com
Linux Device Driver                          giometti at linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it
