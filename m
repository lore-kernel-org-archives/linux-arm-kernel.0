From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Dec 2017 16:26:13 +0000
Subject: [VDSO]: vdso_test failing on arm 32 bit
In-Reply-To: <CAOuPNLiiV=8xy+Fr3fqtsGWrJmCYPzzTDZSySntXZwHtonDobw@mail.gmail.com>
References: <CAOuPNLiiV=8xy+Fr3fqtsGWrJmCYPzzTDZSySntXZwHtonDobw@mail.gmail.com>
Message-ID: <20171212162612.GB10595@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 12, 2017 at 09:49:42PM +0530, Pintu Kumar wrote:
> Hi All,
> 
> Did anybody tried running vdso_test (under Documentation/vDSO in
> kernel 4.1) on an ARM 32 bit system?
> 
> When I test it on iMX.7 board (kernel 4.1, ARM 32 bit), I get this:
> # ./vdso_test
> Could not find __vdso_gettimeofday
> 
> When I check more in parse_vdso.c, I found that under vdso_sym
> function, sym->st_name is returning 0 for the first time, and next it
> returns value 54, then exit and finally vdso_sym returning 0.
> So, its not able to parse the gettimeofday symbol from the ELF header.
> When I check arch/arm/kernel/vdso.so, the symbol is present.
> 
> I even tried for clock_gettime, and even this is also failing.
> 
> Note: the same test is working fine on Ubuntu 16.04 (64 bit), when
> compiled with both 32 bit and 64 bit version.
> Even, the test is working on ARM 64 bit.
> 
> If anybody is aware, please let me know if vdso_test is supported on
> ARM 32 bit system or not?

The vdso time functions are only useful if you have an architected timer.
If you don't have one, the time functions are useless and there's little
point in making them available via the vdso.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
