From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Jul 2016 14:01:17 +0200
Subject: running "make dtbs" for test builds
Message-ID: <8924490.SntxSU2FOC@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fengguang,

I've recently run into a number of cases in which I pulled a branch that
was building fine with "make vmlinux", but that failed for "make dtbs",
and I wonder if this is something that could be checked by the kbuild
test robot so we catch it earlier.

There are parts of this:

- running "make" without a target will build the default image file
  and also do the "dtbs" target on ARM and other architectures. I
  don't know if this is what you do, or if you always build
  "make vmlinux ; make modules", which doesn't include it.
  The dtbs makefile target is available on arc, arm, arm64, h8300,
  metag, mips, nios2, and xtensa but not the others, so if you
  call it explicitly, that has to be in an architecture specific
  way.

- setting CONFIG_OF_ALL_DTBS will catch all files, not just the
  ones that are built by default for the set of configurations you
  have. It's possible to simply override this on the command line,
  using "make CONFIG_OF_ALL_DTBS=y", it doesn't actually have to
  be part of the configuration. The result is independent of the
  actual configuration, so it should be enough to do this once
  per architecture and source revision.

Is this something you can add?

	Arnd
