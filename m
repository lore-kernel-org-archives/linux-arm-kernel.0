From: adharmap@codeaurora.org (Abhijeet Dharmapurikar)
Date: Fri, 14 May 2010 09:32:00 -0700
Subject: [PATCH] gic: implement set_type
In-Reply-To: <1273574921-25714-1-git-send-email-rabin.vincent@stericsson.com>
References: <1273574921-25714-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <4BED7B00.5080405@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +static int gic_set_type(unsigned int irq, unsigned int type)
> +{
> +	void __iomem *base = gic_dist_base(irq);
> +	unsigned int gicirq = gic_irq(irq);
> +	u32 enablemask = 1 << (gicirq % 32);
> +	u32 enableoff = (gicirq / 32) * 4;
> +	u32 confmask = 0x2 << ((gicirq % 16) * 2);
> +	u32 confoff = (gicirq / 16) * 4;
> +	bool enabled = false;
> +	u32 val;
> +
> +	/* Only SPIs' interrupt configuration can be changed */
> +	if (gicirq < 32)
> +		return -EINVAL;


This causes drivers who are requesting PPI's with IRQF_TRIGGER_* flags 
to fail.


Note that it is "Implementation Defined" whether PPI's are programmable 
.http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ihi0048a/index.html

I would request to change gicirq < 32 to gicirq < 16 , the writes will 
be ignored if PPI's are not programmable.

Abhijeet
