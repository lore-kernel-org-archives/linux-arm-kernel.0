From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 27 Apr 2011 12:16:19 +0900
Subject: [PATCH] ARM: S3C64XX: Remove gpio-bank-X header files
In-Reply-To: <4DB782BD.9020205@samsung.com>
References: <1303465894-16870-1-git-send-email-jy0922.shim@samsung.com>
	<052c01cc047a$5cb8d500$162a7f00$%kim@samsung.com>
	<4DB782BD.9020205@samsung.com>
Message-ID: <054301cc0489$82a27fa0$87e77ee0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Joonyoung Shim wrote:
> 
> On 2011-04-27 ?? 10:27, Kukjin Kim wrote:
> > Joonyoung Shim wrote:
> >>
> >> The gpio-bank-X header files of S3C64XX have defines which can be
> >> substituted by more common API, so they can be removed. This is compile
> >> tested only.
> >>
> >> Signed-off-by: Joonyoung Shim<jy0922.shim@samsung.com>
> >> ---
> > Hi,
> >
> > Oh, great.
> >
> > I also tried to remove useless gpio header files :) and it is in my
> dev/gpio
> > branch. But I think, this is better.
> > Anyway there are small comments.
> >
> > (snip)
> >
> >>   void s3c_pm_debug_smdkled(u32 set, u32 clear)
> >>   {
> >> -	unsigned long flags;
> >> -	u32 reg;
> >> -
> >> -	local_irq_save(flags);
> >> -	reg = __raw_readl(S3C64XX_GPNCON);
> >> -	reg&= ~(S3C64XX_GPN_CONMASK(12) | S3C64XX_GPN_CONMASK(13) |
> >> -		 S3C64XX_GPN_CONMASK(14) | S3C64XX_GPN_CONMASK(15));
> >> -	reg |= S3C64XX_GPN_OUTPUT(12) | S3C64XX_GPN_OUTPUT(13) |
> >> -	       S3C64XX_GPN_OUTPUT(14) | S3C64XX_GPN_OUTPUT(15);
> >> -	__raw_writel(reg, S3C64XX_GPNCON);
> >> -
> >> -	reg = __raw_readl(S3C64XX_GPNDAT);
> >> -	reg&= ~(clear<<  12);
> >> -	reg |= set<<  12;
> >> -	__raw_writel(reg, S3C64XX_GPNDAT);
> >> -
> >> -	local_irq_restore(flags);
> >> +	int i;
> >> +
> >> +	for (i = 0; i<  4; i++) {
> >> +		if (clear&  (1<<  i))
> >> +			gpio_direction_output(S3C64XX_GPN(12 + i), 0);
> >> +		if (set&  (1<<  i))
> >> +			gpio_direction_output(S3C64XX_GPN(12 + i), 1);
> >> +	}
> >
> > Hmm...
> >
> > According to comments in gpio_direction_{input,output}, it isn't called
> more
> > than once...but it can be called twice in your code. And need
> > local_irq_{save,restore} around them.
> >
> 
> OK, gpio_set_value will need here instead of gpio_diretion_output.
> 
> > So how about keeping old codes here? In addtion, as you know, need to keep
> > definitions of S3C64XX_GPNxxx now :(
> >
> 
> I won't keep old codes, it can replace fully.
> 
Ok, I agree with you :)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
