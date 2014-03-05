From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Wed,  5 Mar 2014 11:49:08 +0000
Subject: [PATCH v6 1/3] Fix ioport_map() for !CONFIG_GENERIC_IOMAP cases.
In-Reply-To: <1394020150-1875-1-git-send-email-Liviu.Dudau@arm.com>
References: <1394020150-1875-1-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <1394020150-1875-2-git-send-email-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The inline version of ioport_map() that gets used when !CONFIG_GENERIC_IOMAP
is wrong. It returns a mapped (i.e. virtual) address that can start from
zero and completely ignores the PCI_IOBASE and IO_SPACE_LIMIT that most
architectures that use !CONFIG_GENERIC_MAP define.

Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: Tanmay Inamdar <tinamdar@apm.com>
---
 include/asm-generic/io.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index d5afe96..df72051 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -331,7 +331,7 @@ static inline void iounmap(void __iomem *addr)
 #ifndef CONFIG_GENERIC_IOMAP
 static inline void __iomem *ioport_map(unsigned long port, unsigned int nr)
 {
-	return (void __iomem *) port;
+	return (void __iomem *)(PCI_IOBASE + (port & IO_SPACE_LIMIT));
 }
 
 static inline void ioport_unmap(void __iomem *p)
-- 
1.9.0
