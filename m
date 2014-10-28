From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 28 Oct 2014 15:37:52 +0100
Subject: [PATCH v2 3/5] ARM: restrict CPU_BIG_ENDIAN configuration option
In-Reply-To: <20141028140021.GD27405@n2100.arm.linux.org.uk>
References: <1414503095-25986-1-git-send-email-kaixu.xia@linaro.org>
 <1414503095-25986-4-git-send-email-kaixu.xia@linaro.org>
 <20141028140021.GD27405@n2100.arm.linux.org.uk>
Message-ID: <3137318.QMDnWOWDgo@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 28 October 2014 14:00:22 Russell King - ARM Linux wrote:
> On Tue, Oct 28, 2014 at 09:31:33PM +0800, Xia Kaixu wrote:
> > Some platforms don't work when CPU_BIG_ENDIAN is enabled.
> > So It can get a dependency on !ARCH_MULTIPLATFORM_STRICT.
> 
> What if big endian wants to build a multiplatform kernel?

They can turn off ARCH_MULTIPLATFORM_STRICT easily.
 
> This doesn't look right to me.  Instead, we should be arranging for
> those which do not work in BE mode to depend on !CPU_BIG_ENDIAN.
> Yes, it's a larger patch but IMHO is a much more correct solution.

I've also asked Kaixu to put this one in, mostly for the side-effect
of getting an allmodconfig kernel to be little-endian, but also
because we don't really know which platforms are ok to run on
big-endian. I would assume that most platforms have at least some
platform-specific drivers that are not endian-clean, and even if
the platform works big-endian in principle, it's unclear if
everything works.

The most important aspect is probably user space though: If you
build a multiplatform kernel (or one for ARMv4/5 and one for ARMv6/7)
that runs on all sorts of machines, you can have a common user space
that is built for ARMv4 little-endian and that will run everywhere.
As soon as you enable big-endian, you have a fundamental ABI change
and nothing works unless you replace the entire user space side.

	Arnd
