From: loeliger@gmail.com (Jon Loeliger)
Date: Tue, 1 Jul 2014 14:12:21 -0500
Subject: Some Large Address Space Ponders on A9
In-Reply-To: <14859259.LsA3SotVTm@wuerfel>
References: <CAJgR-BhNHYVYJo+jXAOCy+xzXP-AMjJ7LhuzssrQSEPQN4W=2A@mail.gmail.com>
 <14859259.LsA3SotVTm@wuerfel>
Message-ID: <CAJgR-Bg0Vjs3mZEzkVRKRqEU=+WPz2WjK_iKpqiNGCDW7J=Qbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 1, 2014 at 11:43 AM, Arnd Bergmann <arnd@arndb.de> wrote:

>> I think the device-tree handling code is able to grok and process
>> 64-bit addresses.  Does it make sense to allow the phys_addr_t and
>> the resource_size_t to take on different sizes?  That is, to break the
>> above definition of resource_size_t from types.h and allow its size
>> to be determined independently of phys_addr_t?
>
> resource_size_t and phys_addr_t should really be the same all the
> time.
>
>         Arnd

So, as an experiment I did this:

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 1f8fed9..0dfb76f 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -631,6 +631,9 @@ config ARCH_PHYS_ADDR_T_64BIT
 config ARCH_DMA_ADDR_T_64BIT
        bool

+config RESOURCE_SIZE_T_64BIT
+       bool
+
 config ARM_THUMB
        bool "Support Thumb user binaries" if !CPU_THUMBONLY
        depends on CPU_ARM720T || CPU_ARM740T || CPU_ARM920T || CPU_ARM922T || \
diff --git a/include/linux/types.h b/include/linux/types.h
index 4d118ba..331d59a 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -164,7 +164,11 @@ typedef u64 phys_addr_t;
 typedef u32 phys_addr_t;
 #endif

+#ifdef CONFIG_RESOURCE_SIZE_T_64BIT
+typedef u64 resource_size_t;
+#else
 typedef phys_addr_t resource_size_t;
+#endif

And then this:

+       select RESOURCE_SIZE_T_64BIT

Verified a few things:

$ gdb -q ./vmlinux
Reading symbols from vmlinux...done.
(gdb) p sizeof(resource_size_t)
$1 = 8
(gdb) p sizeof(phys_addr_t)
$2 = 4
(gdb) p sizeof(dma_addr_t)
$3 = 4

And it all booted just fine.

jdl
