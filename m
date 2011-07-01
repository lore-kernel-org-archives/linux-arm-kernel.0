From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 1 Jul 2011 19:25:14 +0200
Subject: [PATCH 1/8] at91: introduce commom AT91_BASE_SYS
In-Reply-To: <201107011746.57026.arnd@arndb.de>
References: <1309502682-16897-1-git-send-email-plagnioj@jcrosoft.com>
	<201107011746.57026.arnd@arndb.de>
Message-ID: <20110701172514.GG14408@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:46 Fri 01 Jul     , Arnd Bergmann wrote:
> On Friday 01 July 2011, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > On all at91 except rm9200 and x40 have the System Controller starts
> > at address 0xffffc000 and has a size of 16KiB.
> > 
> > On rm9200 it's start at 0xfffe4000 of 111KiB with non reserved data starting
> > at 0xfffff000
> > 
> > This patch removes the individual definitions of AT91_BASE_SYS and
> > replaces them with a common version at base 0xfffffc000 and size 16KiB
> > and map the same memory space
> 
> Hi Jean-Christophe,
> 
> I have mixed feelings about this series. A lot of the work you do here
> looks like great cleanups and simplifications, some other IMHO parts
> are just moving code from one place to another or look like they
> are instead going in the wrong direction.
> 
> As a general comment, please start with a cover-letter (the PATCH 0/8)
> email that describes the overall intention of the series and holds
> the combined diffstat.
no this detect dynamicly the soc and factorize the init of AT91 in one place
as all the soc have the same init

this patch series is just a first step as switch to the CLKDEV
> 
> > +void __init at91_map_io(void)
> > +{
> > +	/* Map peripherals */
> > +	iotable_init(&at91_io_desc, 1);
> > +
> > +	if (cpu_is_at91cap9())
> > +		at91_boot_soc = at91cap9_soc;
> > +	else if (cpu_is_at91rm9200())
> > +		at91_boot_soc = at91rm9200_soc;
> > +	else if (cpu_is_at91sam9260())
> > +		at91_boot_soc = at91sam9260_soc;
> > +	else if (cpu_is_at91sam9261())
> > +		at91_boot_soc = at91sam9261_soc;
> > +	else if (cpu_is_at91sam9263())
> > +		at91_boot_soc = at91sam9263_soc;
> > +	else if (cpu_is_at91sam9g10())
> > +		at91_boot_soc = at91sam9261_soc;
> > +	else if (cpu_is_at91sam9g20())
> > +		at91_boot_soc = at91sam9260_soc;
> > +	else if (cpu_is_at91sam9g45())
> > +		at91_boot_soc = at91sam9g45_soc;
> > +	else if (cpu_is_at91sam9rl())
> > +		at91_boot_soc = at91sam9rl_soc;
> > +	else if (cpu_is_at91sam9x5())
> > +		at91_boot_soc = at91sam9x5_soc;
> > +	else
> > +		panic("Impossible to detect the SOC type");
> > +
> > +	if (at91_boot_soc.map_io)
> > +		at91_boot_soc.map_io();
> > +}
> 
> I think it would be easier to turn this around and have a very short
> function here:
> 
> void __init at91_map_io(void)
> {
> 	/* Map peripherals */
> 	iotable_init(&at91_io_desc, 1);
> }
> 
> and then change each of the soc specific functions into
> 
> 
> -void __init at91cap9_map_io(void)
> +static void __init at91cap9_map_io(void)
>  {
> -       /* Map peripherals */
> -       iotable_init(at91cap9_io_desc, ARRAY_SIZE(at91cap9_io_desc));
> +	at91_boot_soc = at91cap9_soc;
> +	at91_map_io();
> +       iotable_init(at91cap9_sram_desc, ARRAY_SIZE(at91cap9_sram_desc));
>  }
> 
> This would keep the per-soc code local and still consolidate the
> common code without introducing (IMHO ugly) cpu_is_at91...() checks.
we detect it this is the whole idea

so not this way is the oposit of the whole idea

Best Regards,
J.
