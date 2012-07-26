From: florian@openwrt.org (Florian Fainelli)
Date: Thu, 26 Jul 2012 11:44:17 +0200
Subject: [patch 1/1] kirkwood: set tx_csum_limit
In-Reply-To: <87r4ry98i0.fsf@lebrac.rtp-net.org>
References: <20120726071240.690145078@rtp-net.org> <1719571.FAPWHj9hMz@flexo>
 <87r4ry98i0.fsf@lebrac.rtp-net.org>
Message-ID: <5008497.jOUdmnU6xu@flexo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 26 July 2012 11:28:23 Arnaud Patard wrote:
> Florian Fainelli <florian@openwrt.org> writes:
> 
> > Hi Arnaud,
> >
> > On Thursday 26 July 2012 09:12:00 Arnaud Patard wrote:
> >> kirkwood and dove have a smaller FIFO than other "orion" SoCs. This
> >> needs to be taken into account otherwise people using things like jumbo 
> > frames
> >> will get into some troubles.
> >> 
> >> As a side note, this patch is an updated version of a patch sent some 
years
> >> ago: http://lists.infradead.org/pipermail/linux-arm-kernel/2010-
> > June/017320.html
> >> which seems to have been lost.
> >> 
> >> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> >> 
> >> Index: alunn/arch/arm/mach-dove/common.c
> >> ===================================================================
> >> --- alunn.orig/arch/arm/mach-dove/common.c	2012-07-20 
09:14:45.000000000 
> > +0200
> >> +++ alunn/arch/arm/mach-dove/common.c	2012-07-20 17:51:38.872925518 
> > +0200
> >> @@ -102,7 +102,7 @@ void __init dove_ehci1_init(void)
> >>  void __init dove_ge00_init(struct mv643xx_eth_platform_data *eth_data)
> >>  {
> >>  	orion_ge00_init(eth_data, DOVE_GE00_PHYS_BASE,
> >> -			IRQ_DOVE_GE00_SUM, IRQ_DOVE_GE00_ERR);
> >> +			IRQ_DOVE_GE00_SUM, IRQ_DOVE_GE00_ERR, 0);
> >>  }
> >
> > You might want to add a constant for TX_CSUM_NO_LIMIT or something like 
that, 
> > rather than a plain 0 which might be a little misleading.
> >
> 
> It's not to set an unlimited value but to tell the driver it has to
> use its default value. This limit is only valid for kirkwood but given
> that orion_ge*_init functions are used on all platforms, I have to set 

Ok, then I guess that even more justifies a proper constant for this to make it 
less ambiguous for lazy readers like me.

> 
> >>  
> >>  
> > 
/*****************************************************************************
> >> Index: alunn/arch/arm/mach-kirkwood/common.c
> >> ===================================================================
> >> --- alunn.orig/arch/arm/mach-kirkwood/common.c	2012-07-20 
> > 09:14:46.000000000 +0200
> >> +++ alunn/arch/arm/mach-kirkwood/common.c	2012-07-20 17:51:03.104927094 
> > +0200
> >> @@ -301,7 +301,7 @@ void __init kirkwood_ge00_init(struct mv
> >>  {
> >>  	orion_ge00_init(eth_data,
> >>  			GE00_PHYS_BASE, IRQ_KIRKWOOD_GE00_SUM,
> >> -			IRQ_KIRKWOOD_GE00_ERR);
> >> +			IRQ_KIRKWOOD_GE00_ERR, 1600);
> >>  	/* The interface forgets the MAC address assigned by u-boot if
> >>  	the clock is turned off, so claim the clk now. */
> >>  	clk_prepare_enable(ge0);
> >> @@ -315,7 +315,7 @@ void __init kirkwood_ge01_init(struct mv
> >>  {
> >>  	orion_ge01_init(eth_data,
> >>  			GE01_PHYS_BASE, IRQ_KIRKWOOD_GE01_SUM,
> >> -			IRQ_KIRKWOOD_GE01_ERR);
> >> +			IRQ_KIRKWOOD_GE01_ERR, 1600);
> >>  	clk_prepare_enable(ge1);
> >>  }
> >>  
> >> Index: alunn/arch/arm/mach-mv78xx0/common.c
> >> ===================================================================
> >> --- alunn.orig/arch/arm/mach-mv78xx0/common.c	2012-07-20 
> > 09:14:46.000000000 +0200
> >> +++ alunn/arch/arm/mach-mv78xx0/common.c	2012-07-20 17:50:26.712928695 
+0200
> >> @@ -213,7 +213,7 @@ void __init mv78xx0_ge00_init(struct mv6
> >>  {
> >>  	orion_ge00_init(eth_data,
> >>  			GE00_PHYS_BASE, IRQ_MV78XX0_GE00_SUM,
> >> -			IRQ_MV78XX0_GE_ERR);
> >> +			IRQ_MV78XX0_GE_ERR, 0);
> >>  }
> >>  
> >>  
> >> @@ -224,7 +224,7 @@ void __init mv78xx0_ge01_init(struct mv6
> >>  {
> >>  	orion_ge01_init(eth_data,
> >>  			GE01_PHYS_BASE, IRQ_MV78XX0_GE01_SUM,
> >> -			NO_IRQ);
> >> +			NO_IRQ, 0);
> >>  }
> >>  
> >>  
> >> Index: alunn/arch/arm/mach-orion5x/common.c
> >> ===================================================================
> >> --- alunn.orig/arch/arm/mach-orion5x/common.c	2012-07-20 
09:14:46.000000000 
> > +0200
> >> +++ alunn/arch/arm/mach-orion5x/common.c	2012-07-20 17:50:26.744928692 
> > +0200
> >> @@ -109,7 +109,7 @@ void __init orion5x_eth_init(struct mv64
> >>  {
> >>  	orion_ge00_init(eth_data,
> >>  			ORION5X_ETH_PHYS_BASE, IRQ_ORION5X_ETH_SUM,
> >> -			IRQ_ORION5X_ETH_ERR);
> >> +			IRQ_ORION5X_ETH_ERR, 0);
> >>  }
> >>  
> >>  
> >> Index: alunn/arch/arm/plat-orion/common.c
> >> ===================================================================
> >> --- alunn.orig/arch/arm/plat-orion/common.c	2012-07-20 
> > 09:14:46.000000000 +0200
> >> +++ alunn/arch/arm/plat-orion/common.c	2012-07-20 17:50:26.756928690 
+0200
> >> @@ -291,10 +291,12 @@ static struct platform_device orion_ge00
> >>  void __init orion_ge00_init(struct mv643xx_eth_platform_data *eth_data,
> >>  			    unsigned long mapbase,
> >>  			    unsigned long irq,
> >> -			    unsigned long irq_err)
> >> +			    unsigned long irq_err,
> >> +			    unsigned int tx_csum_limit)
> >>  {
> >>  	fill_resources(&orion_ge00_shared, orion_ge00_shared_resources,
> >>  		       mapbase + 0x2000, SZ_16K - 1, irq_err);
> >> +	orion_ge00_shared_data.tx_csum_limit = tx_csum_limit;
> >>  	ge_complete(&orion_ge00_shared_data,
> >>  		    orion_ge00_resources, irq, &orion_ge00_shared,
> >>  		    eth_data, &orion_ge00);
> >> @@ -343,10 +345,12 @@ static struct platform_device orion_ge01
> >>  void __init orion_ge01_init(struct mv643xx_eth_platform_data *eth_data,
> >>  			    unsigned long mapbase,
> >>  			    unsigned long irq,
> >> -			    unsigned long irq_err)
> >> +			    unsigned long irq_err,
> >> +			    unsigned int tx_csum_limit)
> >>  {
> >>  	fill_resources(&orion_ge01_shared, orion_ge01_shared_resources,
> >>  		       mapbase + 0x2000, SZ_16K - 1, irq_err);
> >> +	orion_ge01_shared_data.tx_csum_limit = tx_csum_limit;
> >>  	ge_complete(&orion_ge01_shared_data,
> >>  		    orion_ge01_resources, irq, &orion_ge01_shared,
> >>  		    eth_data, &orion_ge01);
> >> Index: alunn/arch/arm/plat-orion/include/plat/common.h
> >> ===================================================================
> >> --- alunn.orig/arch/arm/plat-orion/include/plat/common.h	2012-07-20 
> > 09:14:46.000000000 +0200
> >> +++ alunn/arch/arm/plat-orion/include/plat/common.h	2012-07-20 
> > 17:50:26.772928691 +0200
> >> @@ -39,12 +39,14 @@ void __init orion_rtc_init(unsigned long
> >>  void __init orion_ge00_init(struct mv643xx_eth_platform_data *eth_data,
> >>  			    unsigned long mapbase,
> >>  			    unsigned long irq,
> >> -			    unsigned long irq_err);
> >> +			    unsigned long irq_err,
> >> +			    unsigned int tx_csum_limit);
> >>  
> >>  void __init orion_ge01_init(struct mv643xx_eth_platform_data *eth_data,
> >>  			    unsigned long mapbase,
> >>  			    unsigned long irq,
> >> -			    unsigned long irq_err);
> >> +			    unsigned long irq_err,
> >> +			    unsigned int tx_csum_limit);
> >>  
> >>  void __init orion_ge10_init(struct mv643xx_eth_platform_data *eth_data,
> >>  			    unsigned long mapbase,
> >> 
> >> 
> >> 
> >> _______________________________________________
> >> linux-arm-kernel mailing list
> >> linux-arm-kernel at lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
