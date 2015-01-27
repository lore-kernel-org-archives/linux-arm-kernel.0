From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 27 Jan 2015 17:48:18 +0000
Subject: [PATCH] ARM: /proc/atags: Export also for DT
In-Reply-To: <201501271532.25540@pali>
References: <1403110464-29646-1-git-send-email-pali.rohar@gmail.com>
 <20150127132127.GA869@amd>
 <CAL_JsqKM+2PtX_EpWXyOQHVXwf=jqVj8SroUGPO1Y2=Zj8_kMg@mail.gmail.com>
 <201501271532.25540@pali>
Message-ID: <20150127174818.GM26493@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 27, 2015 at 03:32:25PM +0100, Pali Roh?r wrote:
> On Tuesday 27 January 2015 15:16:45 Rob Herring wrote:
> > What other devices? Where is bootreason in the list of ATAGS:
> > 
> > #define ATAG_MEM        0x54410002
> > #define ATAG_VIDEOTEXT  0x54410003
> > #define ATAG_RAMDISK    0x54410004
> > #define ATAG_INITRD     0x54410005
> > #define ATAG_INITRD2    0x54420005
> > #define ATAG_SERIAL     0x54410006
> > #define ATAG_REVISION   0x54410007
> > #define ATAG_VIDEOLFB   0x54410008
> > #define ATAG_CMDLINE    0x54410009
> > #define ATAG_ACORN      0x41000101
> > #define ATAG_MEMCLK     0x41000402
> > 
> > Rob
> 
> Each device is using own proprietary atag (or other information) 
> to pass bootreason from bootloader to kernel. No standard way :-(

The reason that happens is because people refuse to discuss their
requirements here - just like people refuse to report userspace API
regressions to kernel people.  This rather pisses me off, because
it creates all sorts of horrid per-platform yuck.

We _could_ (and have in the past) turned round and refused to support
these kinds of hacks - which IMHO is quite a reasonable stance to
take: the message we should be sending is "if you wish to design
new methods without discussing it with us, we reserve the right not
to support them in mainline kernels; please discuss with us your
requirements."

Each time that we accept one of these hacks, we're sending a message
that says "it's okay to work in this crappy way".

Yes, I realise that the N900 has little in the way of support, and we
can't exert that kind of back pressure (since there's no one to direct
that onto to effect any change) so I guess we just have to live with it.

> I think this kind of information (how was board/computer started) 
> can be useful also for other architectures. E.g. on laptop you 
> would like to know if if was started by RTC, power button, 
> WakeOnLan, another ACPI event, rebooted machine, watchdog, etc... 
> And scripts can act depending on this event (when by RTC, you 
> need to run some planned job, when by watchdog reset you should 
> check what caused that reason...).

There is a standard way to get the boot information already: look at
the watchdog API:

#define WDIOC_GETBOOTSTATUS     _IOR(WATCHDOG_IOCTL_BASE, 2, int)

which uses the WDIOF_* flags to indicate the last boot reason.  It
probably isn't as flexible as some may desire, but it should provide
at least the "watchdog rebooted us" vs "over temperature" vs some
other boot reason.

The other thing to consider is whether we have a way to know what
the boot reason was, and what we should do if we do not have a way
of supporting some of the boot reasons.  For example, if we have
support for RTC alarm based booting, but no way to actually tell
if the boot was caused by the RTC alarm triggering.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
