From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Feb 2013 18:00:48 +0000
Subject: [PATCH 05/32] lib: devres: don't enclose pcim_*() functions in
 CONFIG_HAS_IOPORT
In-Reply-To: <1360686546-24277-6-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1360686546-24277-6-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <201302121800.48723.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 February 2013, Thomas Petazzoni wrote:
> The pcim_*() functions are used by the libata-sff subsystem, and this
> subsystem is used for many SATA drivers on ARM platforms that do not
> necessarily have I/O ports.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
> Cc: Jesse Barnes <jbarnes@virtuousgeek.org>
> Cc: Yinghai Lu <yinghai@kernel.org>
> Cc: linux-kernel at vger.kernel.org

Sorry, but this patch is still incorrect. Any driver that requires a linear
mapping of I/O ports to __iomem pointers must depend CONFIG_HAS_IOPORT
with the current definition of that symbol (as mentioned before, we
should really rename that to CONFIG_HAS_IOPORT_MAP). Having these
functions not defined is a compile time check that is necessary to
ensure that all drivers have the correct annotation.

If a platform has no support for I/O ports at all, it should
probably not set CONFIG_NO_IOPORT at this point.

	Arnd
