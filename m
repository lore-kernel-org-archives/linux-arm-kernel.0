From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 22 Mar 2014 00:52:33 +0100
Subject: [PATCH] ARM: Use 64-bit DMA addresses for LPAE+VirtIO-MMIO
In-Reply-To: <90DB5198-051A-48EC-B577-5342BD706713@arm.com>
References: <1395250522-30031-1-git-send-email-cov@codeaurora.org>
 <532C96B9.4090805@codeaurora.org>
 <90DB5198-051A-48EC-B577-5342BD706713@arm.com>
Message-ID: <4272242.L9VmujUH59@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 March 2014 23:27:24 Catalin Marinas wrote:
> On 21 Mar 2014, at 19:44, Christopher Covington <cov@codeaurora.org> wrote:
> > On 03/21/2014 12:27 PM, Catalin Marinas wrote:
> >>> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> >>> index 1f8fed9..a62bcc9 100644
> >>> --- a/arch/arm/mm/Kconfig
> >>> +++ b/arch/arm/mm/Kconfig
> >>> @@ -617,6 +617,7 @@ config ARM_LPAE
> >>>     bool "Support for the Large Physical Address Extension"
> >>>     depends on MMU && CPU_32v7 && !CPU_32v6 && !CPU_32v5 && \
> >>>             !CPU_32v4 && !CPU_32v3
> >>> +   select ARCH_DMA_ADDR_T_64BIT if VIRTIO_MMIO
> >> 
> >> That's the wrong place to enable ARCH_DMA_ADDR_T_64BIT. Do you have a
> >> platform with >32-bit physical address space? If yes, it should be
> >> selected there.
> > 
> > The platforms I'm currently using are models like the Versatile Express
> > RTSM/FVP. I can respin with changes to ARCH_VEXPRESS and ARCH_VIRT instead.
> 
> But do you use RAM beyond 32-bit on such models?

I think the more important question here is what the normal behavior is
for these platforms. I believe in most cases you don't have RAM above
the boundary, so we should not enable the option by default as it can
have noticeable overhead (we'd turn it on all the time if it didn't).

How about one of these two 

a)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 9ea4b7b..6e3b6db 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -628,7 +628,9 @@ config ARCH_PHYS_ADDR_T_64BIT
 	def_bool ARM_LPAE
 
 config ARCH_DMA_ADDR_T_64BIT
-	bool
+	def_bool "Allow DMA to high (>4GB) addresses"
+	depends on ARCH_PHYS_ADDR_T_64BIT
+	default y
 	help

 config ARM_THUMB
 	bool "Support Thumb user binaries" if !CPU_THUMBONLY


b)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 9ea4b7b..4a21b1e 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -619,16 +619,28 @@ config ARM_LPAE
 	help
 	  Say Y if you have an ARMv7 processor supporting the LPAE page
 	  table format and you would like to access memory beyond the
-	  4GB limit. The resulting kernel image will not run on
-	  processors without the LPA extension.
+	  4GB limit, or run virtual machines usign KVM.
+	  The resulting kernel image will not run on processors without
+	  the LPA extension.
 
 	  If unsure, say N.
 
 config ARCH_PHYS_ADDR_T_64BIT
-	def_bool ARM_LPAE
+	bool "Support more than 4GB of physical address space" if EXPERT
+	depends on ARM_LPAE
+	default y
+	help
+	  Say Y if you use LPAE to access RAM or MMIO registers at
+	  addresses beyond the low 4GB of address space. If this
+	  option is disabled, the kernel will use the LPAE page table
+	  format and it can offer KVM support, but will use a slightly
+	  more efficient representation of physical memory addresses
+	  that restricts access to 32-bit addressable locations.
+
+	  If unsure, say Y.
 
 config ARCH_DMA_ADDR_T_64BIT
-	bool
+	def_bool ARCH_PHYS_ADDR_T_64BIT
 
 config ARM_THUMB
 	bool "Support Thumb user binaries" if !CPU_THUMBONLY



In either case, platforms that need this support can always
'select' it, while a kernel built only for platforms that don't
need it can offer this as a user-selectable option.

	Arnd
