From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Tue, 17 Jan 2012 23:23:12 +0100
Subject: [PATCH 4/8] S3C2416: move io-init to SoC specific files
In-Reply-To: <20120117214336.GX1068@n2100.arm.linux.org.uk>
References: <201201172210.51953.heiko@sntech.de>
 <201201172213.26769.heiko@sntech.de>
 <20120117214336.GX1068@n2100.arm.linux.org.uk>
Message-ID: <201201172323.12958.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag 17 Januar 2012, 22:43:36 schrieb Russell King - ARM Linux:
> On Tue, Jan 17, 2012 at 10:13:26PM +0100, Heiko St?bner wrote:
> > +/* minimal IO mapping */
> > +
> > +static struct map_desc s3c_iodesc[] __initdata = {
> > +	IODESC_ENT(GPIO),
> > +	IODESC_ENT(IRQ),
> > +	IODESC_ENT(MEMCTRL),
> > +	IODESC_ENT(UART)
> > +};
> > +
> > +void __init s3c2416_init_io(struct map_desc *mach_desc, int size)
> > +{
> > +	/* initialise the io descriptors we need for initialisation */
> > +	iotable_init(mach_desc, size);
> > +	iotable_init(s3c_iodesc, ARRAY_SIZE(s3c_iodesc));
> > +
> > +	samsung_cpu_id = __raw_readl(S3C24XX_GSTATUS1);
> > +	s3c24xx_init_cpu();
> > +
> > +	s3c_init_cpu(samsung_cpu_id, cpu_ids, ARRAY_SIZE(cpu_ids));
> > +}
> 
> Why do we need this implemented in every Samsung mach directory?
> Why not provide a new function in arch/arm/plat-s3c24xx/cpu.c:
> 
> void __init s3c24xx_common_init_io(void __iomem *id_reg, struct cpu_table
> *ids, size_t nr_ids)
> {
> 	iotable_init(s3c_iodesc, ARRAY_SIZE(s3c_iodesc));
> 
> 	samsung_cpu_id = __raw_readl(id_reg);
> 	s3c24xx_init_cpu();
> 	s3c_init_cpu(samsung_cpu_id, ids, nr_ids);
> }
> 
> and then this becomes:
> 
> void __init s3c2416_init_io(struct map_desc *mach_desc, int size)
> {
> 	/* initialise the io descriptors we need for initialisation */
> 	iotable_init(mach_desc, size);
> 	s3c24xx_common_init_io(S3C24XX_GSTATUS1, cpu_ids, ARRAY_SIZE(cpu_ids));
> }

this looks nice, and you're right of course, this is much saner.
