From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Thu, 24 Mar 2011 08:34:11 +0100
Subject: [PATCH 5/7] add GPMI support for imx28
In-Reply-To: <4D8AB490.30408@freescale.com>
References: <1300239773-4222-1-git-send-email-b32955@freescale.com>
	<1300239773-4222-6-git-send-email-b32955@freescale.com>
	<19848.39439.380861.195051@ipc1.ka-ro>
	<4D8964F4.3070104@freescale.com>
	<19850.2584.566366.251874@ipc1.ka-ro>
	<4D8AB490.30408@freescale.com>
Message-ID: <19850.62451.678409.328798@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Huang Shijie writes:
> Hi Lothar:
> >
> >>> some general comments:
> >>> - Why are you not using the existing nand_ids but inventing your own
> >>>     database?
> >>>
> >> The nand_ids{} contains poor information for me.
> >> Such as :
> >> [1]The nand_ids does not have the enough information for the page
> >> size,oob size for some new NANDs.
> >>      And you can not get the information from parsing the NAND ids, such
> >> as some Micron NANDs.
> >>
> > You could use it for the standard chips where you do not need
> > additional information. That way most NAND chips could be supported
> > out of the box without having to modify the driver.
> >
> What the meaning of "standard chips"?
> 
Those chips that are supported by other drivers for long time.

> There are many nands in the world. Every vendor has its own rules, some 
> even does has :)
> 
> Unluckily, the imx23/imx28 supports many nands that the nand_ids{} does 
> not support.
>
That's no reason to scrap support for all chips that every other
driver supports.

> I have many nands by my hand. I will add it gradually.
> 
So why not add them to the generic database?

> I want to get the page size/oob size from my own database which can not 
> get from the nand_ids.
> 
If there are parameters needed that cannot be obtained from the
generic database, it might be worth upgrading that database instead of
creating your own local database.

> >> [2]I need the timing information of the NAND. The nand_ids DOES not have
> >> it. I have to
> >>      read the datasheet of the NAND, and add it to my database.
> >>
> > Do we really need exact timing data for each individual chip?
> > Or couldn't we live with some sane timing that works for most chips
> > and provide some means to specify a different timing via
> > platform_data?
> >
> Most of the time, the timing is really based on a safe timing setting.
> But in the original GPMI driver in the FREESCALE BSP, there exits some
> nands need to be set with their own timing setting.
> 
> So I do not use the safe timing for _ALL_ the nand, and i'd better get 
> it from the
> database.
>
It should be sufficient to provide timing info from platform_data in
special cases instead of bloating the nand id database with that
stuff. Platforms might need to adjust the timing because of
peculiarities in the HW. Thus the timing info should be provided from
there, not from the chip database.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
