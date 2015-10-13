From: khilman@kernel.org (Kevin Hilman)
Date: Tue, 13 Oct 2015 14:21:35 -0700
Subject: [PATCH] PCI: iproc: fix 32-bit build error
In-Reply-To: <11199595.GgDE2yo8AA@wuerfel> (Arnd Bergmann's message of "Tue,
 13 Oct 2015 22:02:48 +0200")
References: <1442363962-29805-1-git-send-email-rjui@broadcom.com>
 <1442363962-29805-8-git-send-email-rjui@broadcom.com>
 <CAMAWPa_Hsuv+skzt3S6e9X_kWY=2JXAScbVEVOVTGmn81_bcFw@mail.gmail.com>
 <11199595.GgDE2yo8AA@wuerfel>
Message-ID: <7hwpuqcvmo.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> The iproc PCI driver tries to figure out whether the MMIO window has
> a valid size, but does this using a 64-bit modulo operation, which
> is not allowed on 32-bit kernels and leads to a link error:
>
> drivers/built-in.o: In function `iproc_pcie_setup':
> :(.text+0x4b798): undefined reference to `__aeabi_uldivmod'
>
> This works around that error by using the div64_u64() function
> provided by the kernel. While this is an expensive operation,
> it is harmless because we only call it during the probing
> of the driver.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 0ab99ca8eb6c ("PCI: iproc: Fix compile warnings")

Tested-by: Kevin Hilman <khilman@linaro.org>

Verified that this fixes the build failure on arm multi_v7_defconfig +
CONFIG_ARM_LPAE=y on top of next-20151013.

Kevin
