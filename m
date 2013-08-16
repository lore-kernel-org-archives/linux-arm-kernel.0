From: bevenson@melinkcorp.com (Bryan Evenson)
Date: Fri, 16 Aug 2013 16:37:21 -0400
Subject: at91: watchdog: Can't get watchdog to trigger
In-Reply-To: <B256D81BAE5131468A838E5D7A24364172E2A205@penmbx02>
References: <91586D499ADFD74FBCFB8425266A5DE40153ADC7E586@pluto.melinkcorp.local>
 <B256D81BAE5131468A838E5D7A24364172E2A205@penmbx02>
Message-ID: <91586D499ADFD74FBCFB8425266A5DE40153ADD143B6@pluto.melinkcorp.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Yang, Wenyou [mailto:Wenyou.Yang at atmel.com]
> Sent: Thursday, August 15, 2013 10:23 PM
> To: Bryan Evenson; linux-arm-kernel at lists.infradead.org
> Cc: Ferre, Nicolas
> Subject: RE: at91: watchdog: Can't get watchdog to trigger
> 
> 
> 
> > -----Original Message-----
> > From: Bryan Evenson [mailto:bevenson at melinkcorp.com]
> > Sent: 2013?8?15? 9:42
> > To: linux-arm-kernel at lists.infradead.org
> > Cc: Ferre, Nicolas; Yang, Wenyou
> > Subject: at91: watchdog: Can't get watchdog to trigger
> >
> > All,
> >
> > I am using Atmel's stable branch of the Linux kernel
> > (https://github.com/linux4sam/linux-at91.git, branch linux-3.6.9-
> at91,
> > back at commit 5fe012d4aee98ef82df66e6763882c735902ed0f) on a
> > AT91SAM9G25 based board.  I am having issues getting the watchdog to
> > trigger with this version of the kernel.
> >
> > First, I've verified that the watchdog is enabled in the bootstrap
> and
> > U-Boot.  I see the line:
> >
> > at91sam9_wdt: enabled (heartbeat=15 sec, nowayout=0)
> >
> > during boot showing that the watchdog is enabled.  I've tried
> > triggering the watchdog by writing a single character to it from the
> > command line (echo "0" >
> > /dev/watchdog) and by using the two watchdog sample applications
> under
> > Documentation/watchdog.  In every case I see the line:
> >
> > watchdog watchdog0: watchdog did not stop!
> >
> > But the board does not reset.  Just to make sure, I also set
> > CONFIG_WATCHDOG_NOWAYOUT in the kernel configuration and I still have
> > the same results.
> >
> > I have my kernel configuration and the device tree files for my build
> > over at https://github.com/evensonbryan/at91sam9g25-dt.git.  Other
> > than the device tree files and the configuration, I have not made any
> > kernel modifications.  What do I have setup wrong?
> 
> This is the at91_wdt controller inherent property, once the watchdog is
> started, it can't be stopped.
> Because the Watchdog Mode Register (WDT_MR) can be written only once.
> Only a processor reset resets it, as said in the datasheet.
> 
> So the driver is implemented as following, 1./ If the \dev\watchdog
> device is opened by the user space application, then it is the
> application's responsibility to feed the watchdog. If the application
> does not feed the watchdog, it will trigger RESET.
> 2./ If the device isn't opened or close by the application, The
> responsibility to feed the watchdog is turned to the driver.
> 
> For your case,
> echo "0" > /dev/watchdog, it will arise the following actions 1./ open
> \dev\watchdog device, -->The responsibility to feed the watchdog is
> turned to the user space application 2./ start the watchdog controller
> 3./ ping the watchdog controller 4./ stop the watchdog controller -->
> Since the watchdog can't be stopped, so output: watchdog watchdog0:
> watchdog did not stop!
> 5./ close \dev\watchdog device --> The responsibility to feed the
> watchdog is turned to the Kernel Space
> 
> So, the watchdog doesn't trigger the RESET.
> 
> Documentation/watchdog/src/ watchdog-simple.c: after opening
> \dev\watchdog device, it is always feed the watchdog with the 10
> seconds interval.
> Documentation/watchdog/src/ watchdog-test.c: after opening
> \dev\watchdog device, it is always ping the watchdog with the 1 seconds
> interval.

This is different than what I've seen with other versions of the kernel.  In the past, if my application didn't write the magic character to the watchdog before closing /dev/watchdog (or if it didn't close /dev/watchdog), the watchdog would reset the system.  For example, if I run the watchdog-simple.c test under my 2.6.39 kernel and ctrl-c to kill it, the watchdog resets my board.  But, with this 3.6.9 kernel that action does not reset my board.  I did just run a test where I opened /dev/watchdog, wrote one character to it, and started and infinite loop.  In that case, my board reset as it should.

Is this a intentional change in how the watchdog interacts with userspace, or was it always supposed to work the way it does in the 3.6.9 kernel?

Thanks,
Bryan

> 
> Bye
> 
> Wenyou Yang
> 
> >
> > Thanks,
> > Bryan
