From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 18 Dec 2011 20:39:53 +0000
Subject: [PATCH 3/7] s3c-hsudc: add a remove function
In-Reply-To: <201112182124.13313.heiko@sntech.de>
References: <201112172023.05519.heiko@sntech.de>
 <201112182033.33640.heiko@sntech.de>
 <20111218194518.GX14542@n2100.arm.linux.org.uk>
 <201112182124.13313.heiko@sntech.de>
Message-ID: <20111218203953.GY14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 18, 2011 at 09:24:12PM +0100, Heiko St?bner wrote:
> Am Sonntag 18 Dezember 2011, 20:45:18 schrieb Russell King - ARM Linux:
> > On Sun, Dec 18, 2011 at 08:33:32PM +0100, Heiko St?bner wrote:
> > > Am Sonntag 18 Dezember 2011, 20:01:02 schrieben Sie:
> > > > On Sun, Dec 18, 2011 at 07:50:37PM +0100, Heiko St?bner wrote:
> > > > > I didn't get this far. With your patch the Oopses already happen
> > > > > during the startup of the system / the loading of the modules.
> > > > 
> > > > > A bit of the message spew I got during testing with linux-
> next-20111216:
> > > > In some way, this is a good thing because it's showing that there's
> > > > problems with kobject lifetime rules.
> > > > 
> > > > The #2 and further oops dumps are a result of corrupting the work
> > > > queues as a result of #1, so #2 onwards should be ignored.
> > > > 
> > > > I suspect if you avoid loading the s3c_hsudc module these will go away.
> > > 
> > > nope :-), same faults happen even if s3c-hsudc is not present at all.
> > > So it seems, this delayed cleanup poses problems for other drivers as
> > > well.
> > 
> > Okay, let's try to find out which one it is.  Please use the attached
> > patch - it'll be a little more noisy, reporting which kobjects are
> > being released at the point when they're added to the workqueue.
> The cuplrit seems to be a kobject named "holders" and from what I
> gathered is from kernel/module.c and handling module sysfs entries.
> 
> 
> Partial log below:
> 
> kobject: 'bq24022' (c78a9a80): kobject_release
> [...]
> kobject: 'gpio-vbus' (c78a9cc0): kobject_release
> [...]
> kobject: 'bq24022' (c78a9a80): kobject_cleanup
> kobject: 'gpio-vbus' (c78a9cc0): kobject_cleanup
> [...]
> Found /sbin/init, booting ...
> 
> INIT: version 2.88 booting
> 
> Starting the hotplug events dispatcher: udevdudevd[367]: starting version 172
> .
> Synthesizing the initial hotplug events...done.
> Waiting for /dev to be fully populated...
> [...]
> Cleaning up ifupdown....
> Loading kernel modules...
> kobject: 'holders' (c7addc80): kobject_release
> kobject: 'notes' (c7add080): kobject_release
> done.
> Activating lvm and md swap...done.
> Checking file systems...fsck from util-linux 2.19.1
> done.
> [...]
> kobject: 'holders' (c7addc80): kobject_cleanup
> Unable to handle kernel paging request at virtual address bf055504
> pgd = c0004000
> [bf055504] *pgd=371f9811, *pte=00000000, *ppte=00000000
> Internal error: Oops: 7 [#1]

Please post the entire first oops dump for the above run - it may contain
useful information to properly track this down.

Thanks.
