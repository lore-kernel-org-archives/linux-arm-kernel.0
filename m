From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Fri, 4 Mar 2016 15:59:52 +0100
Subject: [PATCH v1] watchdog: sama5d4_wdt: Reset delay on start
In-Reply-To: <56D99404.60305@roeck-us.net>
References: <1457000979-15717-1-git-send-email-romain.izard.pro@gmail.com>
 <56D8E649.8030500@atmel.com> <56D91BDC.1030604@roeck-us.net>
 <CAGkQfmN9wDkrc=frsSdBYYtMPf4VaTpcmYjX6_wARs=a78-bPQ@mail.gmail.com>
 <56D988F0.8050803@roeck-us.net>
 <CAGkQfmOLVwpckKP+axdi1501ghqq_UAmCygJv_tfa=bCOLvCzA@mail.gmail.com>
 <56D99404.60305@roeck-us.net>
Message-ID: <20160304155952.2f433f3f@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, 4 Mar 2016 05:56:20 -0800 Guenter Roeck wrote:
> On 03/04/2016 05:26 AM, Romain Izard wrote:
> > 2016-03-04 14:09 GMT+01:00 Guenter Roeck <linux@roeck-us.net>:
> >> On 03/04/2016 01:06 AM, Romain Izard wrote:
> >>> 2016-03-04 6:23 GMT+01:00 Guenter Roeck <linux@roeck-us.net>:
> >>>> On 03/03/2016 05:35 PM, Yang, Wenyou wrote:
> >>>>> On 2016/3/3 18:29, Romain Izard wrote:
> >>>>>>
> >>>>>> If the internal counter is not refreshed when the watchdog is
> >>>>>> started for the first time, the watchdog will trigger very
> >>>>>> rapidly.  For example, opening /dev/watchdog without writing in it
> >>>>>> will immediately trigger a reboot, instead of waiting for the
> >>>>>> delay to expire.
> >>>>>>
> >>>>>> To avoid this problem, reload the timer on opening the watchdog
> >>>>>> device.
> >>>>>>
> >>>>>> Command: "while sleep 5; do echo 1; done > /dev/watchdog" Before:
> >>>>>> system reset After: the watchdog runs correctly
> >>>>>
> >>>>>
> >>>>> I didn't reproduce your issue on my side,
> >>>>>
> >>>>> run the your commands as follows, it works fine,  the system reset
> >>>>> doesn't happen.
> >>>
> >>>
> >>> I've just verified with the factory image provided on the SAMA5D2
> >>> Xplained board. It does not display this behaviour.
> >>>
> >>> But the difference is that in the case without the issue, I'm using
> >>> the AT91bootstrap SPL, U-Boot, and the kernel from the QSPI chip.
> >>> When I have the issue, I have a U-Boot based SPL, U-Boot itself and
> >>> the kernel that come from the FAT partition of an SD-Card.
> >>>
> >>> Userspace does not seem to be involved in the issue, as I can
> >>> reproduce it both with my buildroot environment, and the Yocto
> >>> environment from the factory image.
> >>>
> >>>> Different chip revision ? Different chip type ? Different chip
> >>>> initialization by ROMMON ?
> >>>>
> >>>> Can we get exact chip revisions and types for both cases (working
> >>>> and not working), and (if it might be relevant) a dump of all
> >>>> associated chip registers ?
> >>>
> >>>
> >>>
> >>>>> I also check the WDT_MR register before and after enabling
> >>>>> watchdog, the WDV and WDD fields are correct.
> >>>>>
> >>>>> Can you check it again? thank you.
> >>>
> >>>
> >>> Working case:
> >>> MR on kernel startup:   0x3fffafff
> >>> MR after watchdog init: 0x0fffafff
> >>> MR after start:         0x0fff2fff
> >>>
> >>> Problem case:
> >>> MR on kernel startup:   0x00008000
> >>> MR after watchdog init: 0x0fffafff
> >>> MR after start:         0x0fff2fff
> >>>
> >>> So this means that the counter reload does not seem to work very well
> >>> if WDD/WDV have been set to 0 in the past. The other question is why
> >>> does U-Boot (from the Atmel branch based on 2015.1) put this stange
> >>> value in this register.
> >>>
> >>
> >> Can you check the value of AT91_WDT_SR ? Maybe it tells us something.
> >>
> > I didn't report it because it contained 0 at all times. So no information.
> >
> >> Also, in the error case, can you check if the watchdog times out at all
> >> after you applied your patch ?
> >
> > It times out after 16s as expected, and reboot occurs correctly.
> >
> 
> Interesting. So it looks like AT91_WDT_WDRSTT has to be set if the timer
> values in MR are changed from 0 to another value, or maybe after each
> timer value change. Wonder if that should be done in the init function,
> after MR is set (with the watchdog disabled).
> 
> Thoughts, anyone ?
> 
Are you aware of the Notes in the SAMA5D4 Reference Manual (Chapter
19.5.2 Watchdog Timer Mode Register):
|Note: The first write access prevents any further modification of
|      the value of this register. Read accesses remain possible.
|Note: The WDD and WDV values must not be modified within three slow
|      clock periods following a restart of the watchdog performed by
|      a write access in WDT_CR. Any modification will cause the watchdog to trigger an end of period earlier than expected.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
