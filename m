From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Wed, 28 Jan 2015 14:58:22 +0100
Subject: [PATCH] ARM: /proc/atags: Export also for DT
In-Reply-To: <20150128005032.GK28663@atomide.com>
References: <1403110464-29646-1-git-send-email-pali.rohar@gmail.com>
 <20150127174818.GM26493@n2100.arm.linux.org.uk>
 <20150128005032.GK28663@atomide.com>
Message-ID: <201501281458.22088@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 28 January 2015 01:50:33 Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [150127 
09:51]:
> > We _could_ (and have in the past) turned round and refused
> > to support these kinds of hacks - which IMHO is quite a
> > reasonable stance to take: the message we should be sending
> > is "if you wish to design new methods without discussing it
> > with us, we reserve the right not to support them in
> > mainline kernels; please discuss with us your
> > requirements."
> > 
> > Each time that we accept one of these hacks, we're sending a
> > message that says "it's okay to work in this crappy way".
> > 
> > Yes, I realise that the N900 has little in the way of
> > support, and we can't exert that kind of back pressure
> > (since there's no one to direct that onto to effect any
> > change) so I guess we just have to live with it.
> 
> I believe after N900 Nokia dropped the custom ATAGs and used
> the kernel cmdline instead. And most of the n900 custom ATAGs
> are not even needed any longer.
> 

Yes, almost all N900 ATAGs are static and are already hardcoded 
into kernel or DT file.

Basically there are 4 non static values which are used:

1. ATAG_REVISION

2. ATAG_OMAP
2.1 OMAP_TAG_BOOT_REASON --> boot reason
2.2 OMAP_TAG_VERSION ("nolo") --> for bootloader version
2.3 OMAP_TAG_VERSION ("boot-mode") --> "normal" or "update"

ATAG_OMAP is non standard and contains sub-atags.

bootloader version is static now (as Nokia does not develop it 
anymore), but boot reason and boot mode are set by bootloader and 
are needed for userspace. boot mode tells init system/userspace 
if to start normal OS or only small subset for flashing.

> The ATAG_REVISION is a standard feature that we should support
> naturally. I don't think we should add any custom ATAGs,
> except maybe for the bootreason.
> 
> > > I think this kind of information (how was board/computer
> > > started) can be useful also for other architectures. E.g.
> > > on laptop you would like to know if if was started by
> > > RTC, power button, WakeOnLan, another ACPI event,
> > > rebooted machine, watchdog, etc... And scripts can act
> > > depending on this event (when by RTC, you need to run
> > > some planned job, when by watchdog reset you should check
> > > what caused that reason...).
> > 
> > There is a standard way to get the boot information already:
> > look at the watchdog API:
> > 
> > #define WDIOC_GETBOOTSTATUS     _IOR(WATCHDOG_IOCTL_BASE, 2,
> > int)
> > 
> > which uses the WDIOF_* flags to indicate the last boot
> > reason.  It probably isn't as flexible as some may desire,
> > but it should provide at least the "watchdog rebooted us"
> > vs "over temperature" vs some other boot reason.
> > 
> > The other thing to consider is whether we have a way to know
> > what the boot reason was, and what we should do if we do
> > not have a way of supporting some of the boot reasons.  For
> > example, if we have support for RTC alarm based booting,
> > but no way to actually tell if the boot was caused by the
> > RTC alarm triggering.
> 
> On omaps, the bootrom passes the bootreason in r1 to the
> bootloader that can do whatever it wants with it. We could
> maybe pass it in the kernel cmdline to the watchdog driver
> for user space?
> 

Not truth for N900. Bootreason depends on PRM_RSTST omap 
register, state of vbat charger pins, time how long was power key 
pressed, R&D data stored in CAL partition and other undocumented 
registers for omap HS devices. I already tried to implement at 
least some subset of it in userspace (or kernel), but it is 
impossible because NOLO bootloader clear status of PRM_RSTST 
register.

There is also copy of PRM_RSTST register stored at address 
0x4020FFB8 (tracing data) but that address is rewritten (probably 
by kernel), so we really cannot implement reading bootreason in 
kernel.

But in early stage in uboot it is possible to read 0x4020FFB8 
address and get some part of bootreason. But still PRM_RSTST is 
not enough!

I would be happy if DT kernel can export /proc/atags file with 
ATAGs passed by bootloader. It would be enough for me. In 
userspace I can parse content and do what is needed.

In non DT kernel file /proc/atags is always exported.

> Of course the problem is that the signed bootloader on n900
> cannot be modified so the pass through u-boot would have to
> translate the custom ATAG for bootreason into a kernel
> cmdline..
> 
> But it may actually make sense to add the bootreason ATAGs, it
> seems quite generic to me.
> 

Which bootreason atag? Invent new? Or use above big ATAG_OMAP 
structure? Inventing new does not solve anything because all 
developers does not boot kernel for debugging from uboot -- but 
directly.

> AFAIK, the other n900 ATAGs can be just ignored.
> 
> Regards,
> 
> Tony

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150128/0c252bff/attachment.sig>
