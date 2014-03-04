From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Tue,  4 Mar 2014 15:50:14 +0000
Subject: [PATCH v5 1/3] Fix ioport_map() for !CONFIG_GENERIC_IOMAP cases.
In-Reply-To: <1393948216-11599-1-git-send-email-Liviu.Dudau@arm.com>
References: <1393948216-11599-1-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <1393948216-11599-2-git-send-email-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The inline version of ioport_map() that gets used when !CONFIG_GENERIC_IOMAP
is wrong. It returns a mapped (i.e. virtual) address that can start from
zero and completely ignores the PCI_IOBASE and IO_SPACE_LIMIT that most
architectures that use !CONFIG_GENERIC_MAP define.

Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>

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
