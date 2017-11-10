From: tony@atomide.com (Tony Lindgren)
Date: Fri, 10 Nov 2017 07:36:20 -0800
Subject: n900 in next-20170901
In-Reply-To: <20171110063727.GA32073@js1304-P5Q-DELUXE>
References: <20171108074645.GA18747@js1304-P5Q-DELUXE>
 <20171108163413.GU28152@atomide.com>
 <20171109000801.GA23982@js1304-P5Q-DELUXE>
 <20171109001113.GZ28152@atomide.com>
 <20171109003639.GB23982@js1304-P5Q-DELUXE>
 <20171109035031.GA24383@js1304-P5Q-DELUXE>
 <20171109150854.GC28152@atomide.com>
 <20171110001315.GA29669@js1304-P5Q-DELUXE>
 <20171110032610.GJ28152@atomide.com>
 <20171110063727.GA32073@js1304-P5Q-DELUXE>
Message-ID: <20171110153620.GO28152@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Joonsoo Kim <iamjoonsoo.kim@lge.com> [171110 06:34]:
> On Thu, Nov 09, 2017 at 07:26:10PM -0800, Tony Lindgren wrote:
> > +#define OMAP34XX_SRAM_PHYS	0x40200000
> > +#define OMAP34XX_SRAM_VIRT	0xd0010000
> > +#define OMAP34XX_SRAM_SIZE	0x10000
> 
> For my testing environment, vmalloc address space is started at
> roughly 0xe0000000 so 0xd0010000 would not be valid.

Well we can map it anywhere we want, got any preferences?

Just that the current save_secure_ram_context uses "high_mask"
of 0xffff to translate the address. To make this more flexible,
we need the save_secure_ram_context changes too. So we might
want to do the static mapping and save_secure_ram_context changes
as a single patch.

> And, PHYS can be different according to the system type. Maybe either
> OMAP3_SRAM_PUB_PA or OMAP3_SRAM_PA. It seems that SIZE and TYPE should
> be considered, too. My understanding is correct?

We can have a static map for the whole SRAM area, see function
__arm_ioremap_pfn_caller() for the comment "Try to reuse one of the
static mapping whenever possible". So the different public SRAM start
addresses and sizes don't matter there.

Regards,

Tony
