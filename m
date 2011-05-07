From: m@bues.ch (Michael =?ISO-8859-1?Q?B=FCsch?=)
Date: Sat, 07 May 2011 15:55:55 +0200
Subject: [PATCH][WAS:bcmai,axi] bcma: add Broadcom specific AMBA bus driver
In-Reply-To: <BANLkTimGBNT4FkS4mO9ToLWft0bCEYcEgg@mail.gmail.com>
References: <1304632783-8781-1-git-send-email-zajec5@gmail.com>
	<201105061605.31625.arnd@arndb.de>
	<BANLkTikjr0ZTNOu69F+iKhwufE9KKMg4Tg@mail.gmail.com>
	<BANLkTimGBNT4FkS4mO9ToLWft0bCEYcEgg@mail.gmail.com>
Message-ID: <1304776555.16344.2.camel@maggie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2011-05-07 at 15:34 +0200, Rafa? Mi?ecki wrote: 
> 2011/5/6 Rafa? Mi?ecki <zajec5@gmail.com>:
> > 2011/5/6 Arnd Bergmann <arnd@arndb.de>:
> >>> +const char *bcma_device_name(u16 coreid)
> >>> +{
> >>> +     switch (coreid) {
> >>> +     case BCMA_CORE_OOB_ROUTER:
> >>> +             return "OOB Router";
> >>> +     case BCMA_CORE_INVALID:
> >>> +             return "Invalid";
> >>> +     case BCMA_CORE_CHIPCOMMON:
> >>> +             return "ChipCommon";
> >>> +     case BCMA_CORE_ILINE20:
> >>> +             return "ILine 20";
> >>
> >> It's better to make that a data structure than a switch() statement,
> >> both from readability and efficiency aspects.
> >
> > Well, maybe. We call it only once, at init time. In any case we're
> > still waiting for Broadcom to clarify which cores are really used for
> > BCMA.
> 
> Arnd: did you have a look at defines at all?
> 
> Most of the defines have values in range 0x800 ? 0x837. Converting
> this to array means loosing 0x800 u16 entries. We can not use 0x800
> offset, because there are also some defined between 0x000 and 0x800:
> #define BCMA_CORE_OOB_ROUTER           0x367   /* Out of band */
> #define BCMA_CORE_INVALID              0x700
> 
> Oh and there is still:
> #define BCMA_CORE_DEFAULT              0xFFF
> we could want to include. Then we would loose additional (0xFFF -
> 0x837) u16 entries in array.
> 
> I'll just leave this huge "case". As I said, it's called only once on
> initialization time. For standard PCI cards there are usually 3-5
> cores, for embedded systems this number can be bigger, but still is
> limited with 16 for 1 bus:
> #define BCMA_MAX_NR_CORES              16

The compiler does a better job than we do. I'm pretty sure that the
compiler will implement this switch statement as a series of small
lookup tables combined with some branches, if it thinks it's worth
it (also depends on flags and arch).

-- 
Greetings Michael.
