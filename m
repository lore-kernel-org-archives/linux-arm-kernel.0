From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Jul 2010 22:11:31 +0200
Subject: [RFC PATCH] Kconfig: Enable Kconfig fragments to be used for
	defconfig
In-Reply-To: <AANLkTikqHnyFVJF0Pzwy2xtKeNSXYAPFdPkAkLiXK8Ls@mail.gmail.com>
References: <20100713230352.6781.18644.stgit@angua>
	<alpine.LFD.2.00.1007161439240.10598@xanadu.home>
	<AANLkTikqHnyFVJF0Pzwy2xtKeNSXYAPFdPkAkLiXK8Ls@mail.gmail.com>
Message-ID: <201007162211.31973.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 16 July 2010 20:46:17 Linus Torvalds wrote:
> Maybe a full "solver" is unnecessary, for example, but just a simple
> "automatically enable the direct dependencies and scream when it's not
> simple any more" would take care of 99% of the common cases, and then
> warn when it needs some manual help.

I think the recursion should also be limited to cases where the
dependency is a valid selectable option, i.e. not for

# this architecture does not support MMIO
config HAS_IOMEM 
	def_bool 'n'

config PCI
	bool "PCI Device drivers"
	depends on HAS_IOMEM

config FOO
	tristate "Some device driver"
	depends on PCI

In this case, it would be straightforward for the solver to enable PCI
for when something selects CONFIG_FOO, but it should print a warning
if this is attempted while HAS_IOMEM is unconditionally disabled,
since that puts it into the "not simple" category.

	Arnd
