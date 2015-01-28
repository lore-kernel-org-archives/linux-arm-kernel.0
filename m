From: tony@atomide.com (Tony Lindgren)
Date: Tue, 27 Jan 2015 16:50:33 -0800
Subject: [PATCH] ARM: /proc/atags: Export also for DT
In-Reply-To: <20150127174818.GM26493@n2100.arm.linux.org.uk>
References: <1403110464-29646-1-git-send-email-pali.rohar@gmail.com>
 <20150127132127.GA869@amd>
 <CAL_JsqKM+2PtX_EpWXyOQHVXwf=jqVj8SroUGPO1Y2=Zj8_kMg@mail.gmail.com>
 <201501271532.25540@pali>
 <20150127174818.GM26493@n2100.arm.linux.org.uk>
Message-ID: <20150128005032.GK28663@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [150127 09:51]:
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

I believe after N900 Nokia dropped the custom ATAGs and used the
kernel cmdline instead. And most of the n900 custom ATAGs are not
even needed any longer.

The ATAG_REVISION is a standard feature that we should support
naturally. I don't think we should add any custom ATAGs, except
maybe for the bootreason.
 
> > I think this kind of information (how was board/computer started) 
> > can be useful also for other architectures. E.g. on laptop you 
> > would like to know if if was started by RTC, power button, 
> > WakeOnLan, another ACPI event, rebooted machine, watchdog, etc... 
> > And scripts can act depending on this event (when by RTC, you 
> > need to run some planned job, when by watchdog reset you should 
> > check what caused that reason...).
> 
> There is a standard way to get the boot information already: look at
> the watchdog API:
> 
> #define WDIOC_GETBOOTSTATUS     _IOR(WATCHDOG_IOCTL_BASE, 2, int)
> 
> which uses the WDIOF_* flags to indicate the last boot reason.  It
> probably isn't as flexible as some may desire, but it should provide
> at least the "watchdog rebooted us" vs "over temperature" vs some
> other boot reason.
> 
> The other thing to consider is whether we have a way to know what
> the boot reason was, and what we should do if we do not have a way
> of supporting some of the boot reasons.  For example, if we have
> support for RTC alarm based booting, but no way to actually tell
> if the boot was caused by the RTC alarm triggering.

On omaps, the bootrom passes the bootreason in r1 to the bootloader
that can do whatever it wants with it. We could maybe pass it
in the kernel cmdline to the watchdog driver for user space?

Of course the problem is that the signed bootloader on n900 cannot
be modified so the pass through u-boot would have to translate
the custom ATAG for bootreason into a kernel cmdline..

But it may actually make sense to add the bootreason ATAGs, it
seems quite generic to me.

AFAIK, the other n900 ATAGs can be just ignored.

Regards,

Tony
