From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 Sep 2016 14:11:43 +0200
Subject: [PATCH 1/2] armv8: aarch32: Execute 32-bit Linux for LayerScape
 platforms
In-Reply-To: <1474597146-33312-1-git-send-email-b18965@freescale.com>
References: <1474597146-33312-1-git-send-email-b18965@freescale.com>
Message-ID: <12411518.Vrka20sV4r@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, September 23, 2016 10:19:05 AM CEST Alison Wang wrote:
> The ARMv8 architecture supports:
> 1. 64-bit execution state, AArch64.
> 2. 32-bit execution state, AArch32, that is compatible with previous
> versions of the ARM architecture.
> 
> LayerScape platforms are compliant with ARMv8 architecture. This patch
> is to support running 32-bit Linux kernel for LayerScape platforms.
> 
> Verified on LayerScape LS1043ARDB, LS1012ARDB, LS1046ARDB boards.
> 
> Signed-off-by: Ebony Zhu <ebony.zhu@nxp.com>
> Signed-off-by: Alison Wang <alison.wang@nxp.com>

I'm not too happy about adding random 64-bit platforms in arch/arm/.
We have done this twice already (ARCH_VIRT and ARCH_BCM2835), which
are both platforms that can come with ARMv6, ARMv7 or ARMv8 cores
and are otherwise almost identical. However, there are two problem
I see with the general approach:

a) We don't actually support ARMv8 as a target architecture, in fact
   we don't even support ARMv7VE (Cortex-A7/A12/A15/A17, Krait-400,
   PJ4B-MP and Brahma-B15) properly. For an ARMv8-only kernel
   we should pass the correct compiler flags. We should also have
   this for any upcoming Cortex-A32 and Cortex-R52 platforms.

b) Generally speaking it's a bad idea to run an platform that
   supports aarch64 in aarch32 mode, you should use a native kernel
   with syscall emulation for 32-bit user space unless you have a
   very strong reason not to do that. If you have a strong reason
   why your platform is different from all the others, please at
   least explain it in the changelog.
   On the other hand, any platform support both aarch64 and aarch32
   mode should in theory run with a 32-bit kernel, and it might be
   nice to allow that for *all* platforms that we support on a 64-bit
   kernel. If we decide to do this, we should come up with a way to
   include the platform configuration from arch/arm64 in the arm
   Kconfig file.

	Arnd
