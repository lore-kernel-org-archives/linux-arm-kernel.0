From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 28 Sep 2015 10:48:36 +0100
Subject: Build regressions/improvements in v4.3-rc3
In-Reply-To: <20150928093006.GT21513@n2100.arm.linux.org.uk>
References: <1443382476-12171-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdWrBYnQ0CRYmBgO3xNZMqCY42OtNwhryqzi+Tv+KGj6Lg@mail.gmail.com>
 <20150928093006.GT21513@n2100.arm.linux.org.uk>
Message-ID: <20150928094836.GU21513@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 28, 2015 at 10:30:06AM +0100, Russell King - ARM Linux wrote:
> On Mon, Sep 28, 2015 at 08:57:44AM +0200, Geert Uytterhoeven wrote:
> > On Sun, Sep 27, 2015 at 9:34 PM, Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> > > JFYI, when comparing v4.3-rc3[1] to v4.3-rc2[3], the summaries are:
> > >   - build errors: +8/-12
> > 
> >   + error: No rule to make target include/config/auto.conf:  => N/A
> > 
> > arm-randconfig
> 
> Not every randconfig failure is a kernel problem.  Here's an example:
> 
> Physical address of main memory (PHYS_OFFSET) [] (NEW) aborted!
> 
> Console input/output is redirected. Run 'make oldconfig' to update configuration.
> 
> This needs someone to provide a value, which means these failures are
> not in fact failures of the kernel, but a failure of the build system
> to anticipate that there may be Kconfig questions that need input.
> 
> So, these ones should be ignored.

Also, a great many of the failures are due to the build toolchain not
supporting -fstack-protector-strong.  I think it's absolutely right
for the build to error out if you enable a kernel feature which requires
toolchain support, but the toolchain does not support that feature.

What this means is that the build results from kissb are less than
useful - without spending ages looking at every single build, it's
hard to find the real failures we care about.

I'd suggest that either the randconfig is seeded to ensure that
CONFIG_CC_STACKPROTECTOR_STRONG is always disabled in ARM randconfigs,
or that the ARM toolchain is updated to support this feature.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
