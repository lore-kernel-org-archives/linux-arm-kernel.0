From: T.Mehnert@eckelmann.de (Mehnert, Torsten)
Date: Tue, 13 Mar 2012 13:22:25 +0000
Subject: AW: [PATCH] iomux-mx25.h slew rate adjusted for LCD __LD pins
In-Reply-To: <efb4350f3d236ae7feb088b9a5072b8c@mail.fqingenieria.es>
References: <3F263ABB4EDE344D974E1983B56807739E868EAB@EX-DAG01.eckelmann.group>
 <efb4350f3d236ae7feb088b9a5072b8c@mail.fqingenieria.es>
Message-ID: <3F263ABB4EDE344D974E1983B56807739E868F97@EX-DAG01.eckelmann.group>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Hi

Hi again

> What a coincidence, we have been fighting with the LCD color issue on an i.MX258 about two weeks ago and came up with almost the same patch.
Sounds like we hit the problem in the right way. Super! :)

> > For some reason (sadly i don't identifying the patch right now) two 
> > LCD data lines configured PAD_CTL_SRE_SLOW (wrong slew rate) since 
> > Kernel 3.1. MX25_PAD_GPIO_E__LD16 and MX25_PAD_GPIO_F__LD17 This 
> > results in an fauly behaviour and strange color effects.
> >
> > To ensure that all LCD data pins configured with the proper slew rate, 
> > this patch changes to IOMUX define of all LCD __LDxx pins to 
> > PAD_CTL_SRE_FAST.

> For us it was enough to change the MX25_PAD_GPIO_E__LD16 and
> MX25_PAD_GPIO_F__LD17 pins to PAD_CTL_SRE_FAST. Why do you need to change the others too? Could this introduce undesired signal noise on the board? We actually experience a weird effect on the ADC lines. It's all 
> been discussed here:
For our display problem it's also enough to set MX25_PAD_GPIO_E__LD16 and MX25_PAD_GPIO_F__LD17 to fast slew rate. So far i can confirm that your patch solves the problem.

The reason I decided to change the other line muxings too is the tought, that when these two lines need to set to fast slew rate, all other line need to set to fast slew rate too.
For some reason (I actually don't know) the other lines seems to be set >implicit< correctly to fast slew rate. In order to avoid future problems I set them explicit to fast slew rate.

Seeing the aspect that all LD lines implicit set to fast slew rate, there would no electrical change if you set them explicit. For all the other lines (not LD16 and LD17)
The code effectivly changes nothing, but ensures the fast slew rate in future. 
That's the idea, but I can't confirm my assumption by measurement.
What's your opinion? 

I checked my ADC right now. We use it to read out touchscreen. I can't find any problems, all seems to be okay.
What's your use of it?

>  It's all been discussed here
shame on me, I missed the post.^^ But I will read it now.

> > This problem may affect other mx25 platforms like mx25pdk. Sadly i 
> > can't test it. Of course this problem shouldn't occur when you done 
> > your LCD muxing correctly in the bootloader.

> Would you care to explain how to perform the "LCD muxing correctly" in the bootloader and why it should influence what the kernel does?

We have moved our Kernel from 3.0 to 3.2 the LCD problem occurs.
When booting the 3.0 kernel and the reboot and "warm starting" the 3.2 kernel the display running fine.
When "cold starting" the 3.2 kernel the display problem occurs.

So that lead to the knowledge that there must be an initialization problem. What happened?
The 3.0 kernel starts and init the pins correctly. These pin settings kept by "warm starting" the 3.2
Kernel, so it can drive the display correctly. So the 3.2 seems not touching these settings.

So far I've come to the idea, that the problem shouldn't occur on boards where the muxing of the LCD
completely done by bootloader. Which is not in my case, but I think this theory could explain it
when some mx25 board dons't have the problem with the lcd.


> I will test your patch (adding PAD_CTL_SRE_FAST to all __LDxx pins instead of just LD16 and LD17) and report back. In any case, I can confirm that without this patch the LCD has weird colors. Juergen Beisert has more iomux
> mx25.h changes, especially with regard to PWM, so I reckon he'll send them upstream soon enough.
Thanks

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

> As mentioned above, this is the only part we needed from the patch to address the wrong slew rate for the LCD color wash-out. But I am curious as to hear your explanation with regard to changing the slew rate of the other > __LDxx pins.

I must admit that I'm not the most experienced kernel developer, so far it would be possible that the idea of setting all LDxx pins explicit fast is not the best idea.
So I hoping for a divine inspiration :)

Thanks for your answer
Torsten

Best regards
--
Joan C. Abelaira


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
