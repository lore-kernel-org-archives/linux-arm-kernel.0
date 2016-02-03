From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 3 Feb 2016 19:59:06 +0000
Subject: [PATCH 1/2] ARM: make virt_to_idmap() return unsigned long
In-Reply-To: <56B2201B.7020205@ti.com>
References: <E1aO8F2-00074N-E8@rmk-PC.arm.linux.org.uk>
 <56A84748.3040108@oracle.com>
 <20160201152015.GU10826@n2100.arm.linux.org.uk>
 <56AF8F54.7030805@ti.com> <56AF917F.9030505@oracle.com>
 <56B14546.4070808@oracle.com> <56B20B2E.7060408@ti.com>
 <56B2201B.7020205@ti.com>
Message-ID: <20160203195905.GC10826@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 03, 2016 at 10:43:23AM -0500, Vitaly Andrianov wrote:
> >100%. I came up with absolutely similar fix.
> >
> >
> >Regarding, kexec:
> >- it seems can't be tested on ks2 out of the box, because there is unmet dependency in kconfig
> >  config KEXEC
> >         bool "Kexec system call (EXPERIMENTAL)"
> >-       depends on (!SMP || PM_SLEEP_SMP)
> >         depends on !CPU_V7M
> >         select KEXEC_CORE
> >         help
> >
> >- any way, i've hacked kernel as above;
> >- downloaded and built kexec-tools
> >git://git.kernel.org/pub/scm/linux/kernel/git/geoff/kexec-tools.git
> >- tried to run it using different combination of parameters, but always
> >with below result:
> ># kexec -l /boot/zImage
> >kexec version: 15.12.22.16.38-g6503cb3
> >Could not find a free area of memory of 0x3b2ca0 bytes...
> >Cannot load /boot/zImage
> >
> >I'm doing something wrong, but don't know what yet :(
> >- these patches were not applied, I'd like to see kexec not working first
> >
> >
> I'm not sure about that particular issue, but when I worked on KS2 kexec I
> had to patch kexec-tools to support KS2 LPAE memory.

This was specifically for Vitaly to test, as he has patches to work
around most of the KS2 issues with kexec (although I have a KS2, I
don't have everything that's necessary to get a working kexec in
place.)

What I do want to know is whether this patch makes Vitaly's kexec
patch smaller, and most importantly, what's left to deal with - in
other words, I'd like to see the kernel patch for what's remaining.

Alternatively, if I can have both the kernel and userland patches
so I can get a working kexec setup here, that may be a better way
forward.

Either way, I think I'm going to push these patches out into
linux-next very soon, because I believe that they're the correct
approach to solving some of the issues found in Vitaly's original
patch, unless someone discovers that they're broken in some manner.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
