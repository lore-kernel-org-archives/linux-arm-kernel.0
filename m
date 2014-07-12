From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 12 Jul 2014 11:16:02 +0100
Subject: [PATCH v7 0/4] arm: Fix DEBUG_LL for multi-platform kernels
 (without PL01X)
In-Reply-To: <1404127855-30459-1-git-send-email-daniel.thompson@linaro.org>
References: <1401206421-29832-1-git-send-email-daniel.thompson@linaro.org>
 <1404127855-30459-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <20140712101602.GH21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 12:30:51PM +0100, Daniel Thompson wrote:
> This patchset removes some single-platform compatibility tricks related
> to DEBUG_LL and, as a result, allows multi_v7_defconfig derived builds
> to enable DEBUG_LL. Currently the user selected kbuild setting is
> ignored and the PL01X's DEBUG_LL stub is silently selected instead. This
> is a pain if your hardware doesn't have this cell, not least because it
> takes a little time to figure out that kbuild built the wrong code.

I don't think this is quite right, because I'm now seeing randconfig
finding build errors with this.  We can end up with this configuration:

CONFIG_DEBUG_LL=y
CONFIG_DEBUG_LL_UART_NONE=y
# CONFIG_DEBUG_ICEDCC is not set
# CONFIG_DEBUG_SEMIHOSTING is not set
# CONFIG_DEBUG_LL_UART_8250 is not set
# CONFIG_DEBUG_LL_UART_PL01X is not set
CONFIG_DEBUG_LL_INCLUDE="mach/debug-macro.S"
# CONFIG_DEBUG_UART_8250 is not set

which results in:

arch/arm/kernel/debug.S:24:33: fatal error: mach/debug-macro.S: No such file or directory
make[2]: *** [arch/arm/kernel/debug.o] Error 1
arch/arm/kernel/head.S:27:33: fatal error: mach/debug-macro.S: No such file or directory
make[2]: *** [arch/arm/kernel/head.o] Error 1

Full config file:
http://www.arm.linux.org.uk/developer/build/file.php?lid=11023

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
