From: viresh.kumar@st.com (Viresh KUMAR)
Date: Mon, 19 Apr 2010 16:42:07 +0530
Subject: [PATCH] ST SPEAr: Adding support for shared irq layer
In-Reply-To: <20100419110243.GC6684@trinity.fluff.org>
References: <1271149610-2440-1-git-send-email-viresh.kumar@st.com>
	<20100419110243.GC6684@trinity.fluff.org>
Message-ID: <4BCC3A87.2010505@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/19/2010 4:32 PM, Ben Dooks wrote:
>> > diff --git a/arch/arm/mach-spear3xx/spear300.c b/arch/arm/mach-spear3xx/spear300.c
>> > index 66e7fcd..3560f8c 100644
>> > --- a/arch/arm/mach-spear3xx/spear300.c
>> > +++ b/arch/arm/mach-spear3xx/spear300.c
>> > @@ -17,6 +17,7 @@
>> >  #include <asm/irq.h>
>> >  #include <mach/generic.h>
>> >  #include <mach/spear.h>
>> > +#include <plat/shirq.h>
>> >  
>> >  /* pad multiplexing support */
>> >  /* muxing registers */
>> > @@ -386,14 +387,78 @@ struct amba_device gpio1_device = {
>> >  		.end = SPEAR300_GPIO_BASE + SPEAR300_GPIO_SIZE - 1,
>> >  		.flags = IORESOURCE_MEM,
>> >  	},
>> > -	.irq = {IRQ_GEN_RAS_1, NO_IRQ},
>> > +	.irq = {VIRQ_GPIO1, NO_IRQ},
>> > +};
>> > +
>> > +/* spear3xx shared irq */
>> > +struct shirq_dev_config shirq_ras1_config[] = {
>> > +	{
>> > +		.virq = VIRQ_IT_PERS_S,
>> > +		.enb_mask = IT_PERS_S_IRQ_MASK,
>> > +		.status_mask = IT_PERS_S_IRQ_MASK,
>> > +	}, {
>> > +		.virq = VIRQ_IT_CHANGE_S,
>> > +		.enb_mask = IT_CHANGE_S_IRQ_MASK,
>> > +		.status_mask = IT_CHANGE_S_IRQ_MASK,
>> > +	}, {
>> > +		.virq = VIRQ_I2S,
>> > +		.enb_mask = I2S_IRQ_MASK,
>> > +		.status_mask = I2S_IRQ_MASK,
>> > +	}, {
>> > +		.virq = VIRQ_TDM,
>> > +		.enb_mask = TDM_IRQ_MASK,
>> > +		.status_mask = TDM_IRQ_MASK,
>> > +	}, {
>> > +		.virq = VIRQ_CAMERA_L,
>> > +		.enb_mask = CAMERA_L_IRQ_MASK,
>> > +		.status_mask = CAMERA_L_IRQ_MASK,
>> > +	}, {
>> > +		.virq = VIRQ_CAMERA_F,
>> > +		.enb_mask = CAMERA_F_IRQ_MASK,
>> > +		.status_mask = CAMERA_F_IRQ_MASK,
>> > +	}, {
>> > +		.virq = VIRQ_CAMERA_V,
>> > +		.enb_mask = CAMERA_V_IRQ_MASK,
>> > +		.status_mask = CAMERA_V_IRQ_MASK,
>> > +	}, {
>> > +		.virq = VIRQ_KEYBOARD,
>> > +		.enb_mask = KEYBOARD_IRQ_MASK,
>> > +		.status_mask = KEYBOARD_IRQ_MASK,
>> > +	}, {
>> > +		.virq = VIRQ_GPIO1,
>> > +		.enb_mask = GPIO1_IRQ_MASK,
>> > +		.status_mask = GPIO1_IRQ_MASK,
>> > +	},
>> > +};
> Hmm, this seems to be an awful lot of data required. Why not just ensure
> that the each interrupt chip has a 1:1 mapping of bit to interrupt number?
> 

I wanted to, but due to hardware design i was unable to do it the way you
suggested. In SPEAr all virqs have status register bits but may not have
enable/disable or clear bits. And they can be in arbitrary order too.

Due to this design, i was forced to have this much of data.
