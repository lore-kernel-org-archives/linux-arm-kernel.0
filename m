From: lukma@denx.de (Lukasz Majewski)
Date: Mon, 11 Dec 2017 23:46:57 +0100
Subject: [PATCH v4 5/5] ARM: ep93xx: ts72xx: Add support for BK3 board -
 ts72xx derivative
In-Reply-To: <SN1PR0101MB156535B0FBBAF51FE274F0A7D0370@SN1PR0101MB1565.prod.exchangelabs.com>
References: <20171116232239.16823-1-lukma@denx.de>
 <20171130235140.12243-1-lukma@denx.de>
 <20171130235140.12243-6-lukma@denx.de>
 <SN1PR0101MB156532C13ABBAE280B3754CED0370@SN1PR0101MB1565.prod.exchangelabs.com>
 <20171211223941.744be82f@jawa>
 <SN1PR0101MB156535B0FBBAF51FE274F0A7D0370@SN1PR0101MB1565.prod.exchangelabs.com>
Message-ID: <20171211234657.5482b40f@jawa>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hartley,

> On Monday, December 11, 2017 2:40 PM, Lukasz Majewski wrote:
> > Hi Hartley,
> >  
> >> On Thursday, November 30, 2017 4:52 PM, Lukasz Majewski wrote:  
> >>>
> >>> The BK3 board is a derivative of the ts72xx reference design.    
> >> 
> >> Lukasz,
> >> 
> >> I was just reviewing the other TS-72xx boards and noticed this:
> >> 
> >> <snip>
> >>   
> >>> +/* BK3 specific defines */
> >>> +#define BK3_CPLDVER_PHYS_BASE		0x23400000
> >>> +#define BK3_CPLDVER_VIRT_BASE		0xfebfd000
> >>> +#define BK3_CPLDVER_SIZE		0x00001000
> >>> +    
> >> 
> >> <snip>
> >>   
> >>> +static struct map_desc bk3_io_desc[] __initdata = {
> >>> +	{
> >>> +		.virtual	= BK3_CPLDVER_VIRT_BASE,
> >>> +		.pfn		=
> >>> __phys_to_pfn(BK3_CPLDVER_PHYS_BASE),
> >>> +		.length	= BK3_CPLDVER_SIZE,
> >>> +		.type		= MT_DEVICE,
> >>> +	}
> >>> +};
> >>> +    
> >> 
> >> This register appears to be common to all the TS-72xx boards.  
> >
> > The CPLD was used on the reference ts-72xx boards, but support for
> > it seems to not be present in the mainline kernel.  
> 
> The CPLD is not directly called out but some parts of it are
> supported in the mainline kernel.
> 
> The RTC index and data registers are chip selected by the CPLD and
> Watchdog is in the CPLD. Also, the model number, options, and
> options2 registers are in the CPLD.
> 
> There are a couple other registers in the CPLD that are not currently
> present in mainline. Some aren't because I haven't figured a good way
> to utilize them (the COM2 RS485 registers and the PC/104 memory/IO
> spaces) or they simply have not been necessary yet (the two status
> registers). There are a couple listed in the manuals that are
> specific to the TS-7260 that also have not been added.
> 
> Basically, anything in the EP93xx CS1 or CS2 memory region is in or
> controlled by the CPLD.
> 
> > Do you have a ts72xx board with CPLD embedded? Is any of your
> > design using it?  
> 
> I have a stock TS-7300 board.
> 
> > My another concern - is it safe to perform IO mapping on memory
> > regions which are not used / specified?  
> 
> The mapping is safe. If there is nothing at the address you just read
> back the static state (noise) of the bus and writing doesn't do
> anything.

Ok.

> 
> >  When I do a single ts72xx mapping - for all boards - then we may
> > end up with some mappings which are not needed.  
> 
> True, but it's harmless and it keeps the platform init code cleaner.

I will add all the mappings.

> 
> > With the code as it is - I only map regions which are already used
> > on relevant boards.  
> 
> Yes, but this register in particular exists in the CPLD on all the
> TS-72xx boards.
> 
> >> I don't think Arnd has pulled the series yet. Would you mind
> >> renaming the defines and rebasing this patch?  
> >
> > If needed I can resend the patch series, or prepare a single fix
> > patch. No problem.  
> 
> Fixing it after Arnd merges your series is fine. I just wanted to
> make sure it was pointed out.

I've checked a few minutes ago and it seems like arm-soc hasn't been
pulled to for-next.

I may resend the whole series.

> 
> BTW, is there a reason the BK3 board needs this register mapped? It
> was mapped in the Technologic Systems 2.4, 2.6, and 3.x kernels but I
> never found anything that used it.

It is used to check the version. BK3 has some CPLD modifications and
it is important to know which version we do have as the board is
already deployed for some time in the field.

> Of course the stock boards
> probably always had the same revision in the CPLD, the BK3 board
> might have multiple revisions...

Yes, correct.

> 
> Hartley



Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd at denx.de
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171211/4003dd39/attachment-0001.sig>
