From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 27 Jan 2015 15:03:23 -0500 (EST)
Subject: [PATCH] ARM: /proc/atags: Export also for DT
In-Reply-To: <20150127174818.GM26493@n2100.arm.linux.org.uk>
References: <1403110464-29646-1-git-send-email-pali.rohar@gmail.com>
 <20150127132127.GA869@amd>
 <CAL_JsqKM+2PtX_EpWXyOQHVXwf=jqVj8SroUGPO1Y2=Zj8_kMg@mail.gmail.com>
 <201501271532.25540@pali> <20150127174818.GM26493@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.11.1501271446330.1322@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 27 Jan 2015, Russell King - ARM Linux wrote:

> On Tue, Jan 27, 2015 at 03:32:25PM +0100, Pali Roh?r wrote:
> > On Tuesday 27 January 2015 15:16:45 Rob Herring wrote:
> > > What other devices? Where is bootreason in the list of ATAGS:
> > > 
> > > #define ATAG_MEM        0x54410002
> > > #define ATAG_VIDEOTEXT  0x54410003
> > > #define ATAG_RAMDISK    0x54410004
> > > #define ATAG_INITRD     0x54410005
> > > #define ATAG_INITRD2    0x54420005
> > > #define ATAG_SERIAL     0x54410006
> > > #define ATAG_REVISION   0x54410007
> > > #define ATAG_VIDEOLFB   0x54410008
> > > #define ATAG_CMDLINE    0x54410009
> > > #define ATAG_ACORN      0x41000101
> > > #define ATAG_MEMCLK     0x41000402
> > > 
> > > Rob
> > 
> > Each device is using own proprietary atag (or other information) 
> > to pass bootreason from bootloader to kernel. No standard way :-(

So that's what Pavel was alluding to.

> The reason that happens is because people refuse to discuss their
> requirements here - just like people refuse to report userspace API
> regressions to kernel people.  This rather pisses me off, because
> it creates all sorts of horrid per-platform yuck.
> 
> We _could_ (and have in the past) turned round and refused to support
> these kinds of hacks - which IMHO is quite a reasonable stance to
> take: the message we should be sending is "if you wish to design
> new methods without discussing it with us, we reserve the right not
> to support them in mainline kernels; please discuss with us your
> requirements."
> 
> Each time that we accept one of these hacks, we're sending a message
> that says "it's okay to work in this crappy way".
> 
> Yes, I realise that the N900 has little in the way of support, and we
> can't exert that kind of back pressure (since there's no one to direct
> that onto to effect any change) so I guess we just have to live with it.

If the method is: "let's pass non-standard ATAGs around and have ad-hoc 
user space code interpret it in some arbitrary way" then it's a complete 
abomination.

> > I think this kind of information (how was board/computer started) 
> > can be useful also for other architectures. E.g. on laptop you 
> > would like to know if if was started by RTC, power button, 
> > WakeOnLan, another ACPI event, rebooted machine, watchdog, etc... 
> > And scripts can act depending on this event (when by RTC, you 
> > need to run some planned job, when by watchdog reset you should 
> > check what caused that reason...).

Useful when properly designed and generic enough to be shared.

I'd suggest a DT property be proposed for that purpose if it doesn't 
already exist.  That at least has a chance to be generically useful.


Nicolas
