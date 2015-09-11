From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Sep 2015 13:58:30 +0100
Subject: master build: 1 failures 73 warnings (v4.2-11142-gb0a1ea5)
In-Reply-To: <20150911120150.GN12027@sirena.org.uk>
References: <E1ZaL9B-0006QE-Kh@optimist> <20150911120150.GN12027@sirena.org.uk>
Message-ID: <20150911125830.GA11833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 11, 2015 at 01:01:51PM +0100, Mark Brown wrote:
> On Fri, Sep 11, 2015 at 11:01:35AM +0100, Build bot for Mark Brown wrote:
> 
> > 	arm64-allmodconfig
> > ../drivers/firmware/qcom_scm-32.c:196:4: error: expected string literal before '__asmeq'
> > ../drivers/firmware/qcom_scm-32.c:221:2: error: implicit declaration of function 'secure_flush_area' [-Werror=implicit-function-declaration]
> > ../drivers/firmware/qcom_scm-32.c:239:2: error: implicit declaration of function 'outer_inv_range' [-Werror=implicit-function-declaration]
> > ../drivers/firmware/qcom_scm-32.c:331:4: error: expected string literal before '__asmeq'
> > ../drivers/firmware/qcom_scm-32.c:361:4: error: expected string literal before '__asmeq'
> 
> Today's mainline fails to build on arm64 due to the above, introduced by
> efaa6e266ba (firmware: qcom_scm-32: replace open-coded call to
> __cpuc_flush_dcache_area()) which introduces a call to
> secure_flush_area() which isn't defined on arm64.

That commit has been in mainline for over a week now, so it shouldn't
be "today's mainline" but mainline from a week ago.

Olof's builder didn't find this error, even when building just my for-next
branch.  I don't remember whether it builds arm64-allmodconfig though, but
I do, and the error hasn't cropped up there.

However, I've educated myself to hardly ever look at arm64-allmodconfig
because it's always broken for one reason or another, and the amount of
warnings it spits out is rediculous, many of them not the fault of ARM64
code, but of crappy driver code.

In my arm64-allmodconfig builds, qcom_scm-32.c never gets built:

  LD [M]  drivers/firewire/firewire-net.o
  CC      drivers/firmware/psci.o
  CC      drivers/firmware/memmap.o
  LD      drivers/firmware/broadcom/built-in.o
  LD      drivers/firmware/built-in.o

That's because QCOM_SCM has to be selected by something:

+config QCOM_SCM
+       bool
+       depends on ARM || ARM64
+

and currently the only place that's selected is:

arch/arm/mach-qcom/Kconfig:     select QCOM_SCM if SMP

Changing the "depends" on QCOM_SCM won't fix it - I think something's
been recently merged which has added another select QCOM_SCM which has
the effect of enabling this on ARM64.  _That_ is the cause of this
breakage.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
