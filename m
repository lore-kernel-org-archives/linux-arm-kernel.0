From: joancarles@fqingenieria.es (joancarles)
Date: Tue, 13 Mar 2012 12:59:12 +0100
Subject: [PATCH] iomux-mx25.h slew rate adjusted for LCD __LD pins
In-Reply-To: <3F263ABB4EDE344D974E1983B56807739E868EAB@EX-DAG01.eckelmann.group>
References: <3F263ABB4EDE344D974E1983B56807739E868EAB@EX-DAG01.eckelmann.group>
Message-ID: <efb4350f3d236ae7feb088b9a5072b8c@mail.fqingenieria.es>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

What a coincidence, we have been fighting with the LCD color issue on 
an i.MX258 about two weeks ago and came up with almost the same patch.

> For some reason (sadly i don't identifying the patch right now)
> two LCD data lines configured PAD_CTL_SRE_SLOW (wrong slew rate)
> since Kernel 3.1. MX25_PAD_GPIO_E__LD16 and MX25_PAD_GPIO_F__LD17
> This results in an fauly behaviour and strange color effects.
>
> To ensure that all LCD data pins configured with the proper slew 
> rate,
> this patch changes to IOMUX define of all LCD __LDxx pins to
> PAD_CTL_SRE_FAST.

For us it was enough to change the MX25_PAD_GPIO_E__LD16 and 
MX25_PAD_GPIO_F__LD17 pins to PAD_CTL_SRE_FAST. Why do you need to 
change the others too? Could this introduce undesired signal noise on 
the board? We actually experience a weird effect on the ADC lines. It's 
all been discussed here:



> This problem may affect other mx25 platforms like mx25pdk. Sadly i 
> can't test
> it. Of course this problem shouldn't occur when you done your LCD 
> muxing
> correctly in the bootloader.

Would you care to explain how to perform the "LCD muxing correctly" in 
the bootloader and why it should influence what the kernel does?

I will test your patch (adding PAD_CTL_SRE_FAST to all __LDxx pins 
instead of just LD16 and LD17) and report back. In any case, I can 
confirm that without this patch the LCD has weird colors. Juergen 
Beisert has more iomux-mx25.h changes, especially with regard to PWM, so 
I reckon he'll send them upstream soon enough.

> @@ -468,11 +468,11 @@
>  #define MX25_PAD_GPIO_C__CAN2_TX	IOMUX_PAD(0x3f8, 0x1fc, 0x16, 0, 0,
> PAD_CTL_PUS_22K_UP)
>
>  #define MX25_PAD_GPIO_D__GPIO_D		IOMUX_PAD(0x3fc, 0x200, 0x10, 0, 0,
> NO_PAD_CTRL)
> -#define MX25_PAD_GPIO_E__LD16		IOMUX_PAD(0x400, 0x204, 0x02, 0, 0,
> NO_PAD_CTRL)
> +#define MX25_PAD_GPIO_E__LD16		IOMUX_PAD(0x400, 0x204, 0x02, 0, 0,
> PAD_CTL_SRE_FAST)
>  #define MX25_PAD_GPIO_D__CAN2_RX	IOMUX_PAD(0x3fc, 0x200, 0x16,
> 0x484, 1, PAD_CTL_PUS_22K_UP)
>
>  #define MX25_PAD_GPIO_E__GPIO_E		IOMUX_PAD(0x400, 0x204, 0x10, 0, 0,
> NO_PAD_CTRL)
> -#define MX25_PAD_GPIO_F__LD17		IOMUX_PAD(0x404, 0x208, 0x02, 0, 0,
> NO_PAD_CTRL)
> +#define MX25_PAD_GPIO_F__LD17		IOMUX_PAD(0x404, 0x208, 0x02, 0, 0,
> PAD_CTL_SRE_FAST)
>  #define MX25_PAD_GPIO_E__AUD7_TXD	IOMUX_PAD(0x400, 0x204, 0x14, 0,
> 0, NO_PAD_CTRL)
>
>  #define MX25_PAD_GPIO_F__GPIO_F		IOMUX_PAD(0x404, 0x208, 0x10, 0, 0,
> NO_PAD_CTRL)

As mentioned above, this is the only part we needed from the patch to 
address the wrong slew rate for the LCD color wash-out. But I am curious 
as to hear your explanation with regard to changing the slew rate of the 
other __LDxx pins.

Best regards
-- 
Joan C. Abelaira
