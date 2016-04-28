From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Apr 2016 14:50:28 +0100
Subject: [PATCH 3/3] ARM: domain: move {set, get}_domain under config guard
In-Reply-To: <5720AD9D.7020909@arm.com>
References: <1461325416-29570-1-git-send-email-vladimir.murzin@arm.com>
 <1461325416-29570-4-git-send-email-vladimir.murzin@arm.com>
 <20160427104918.GQ19428@n2100.arm.linux.org.uk>
 <5720AD9D.7020909@arm.com>
Message-ID: <20160428135028.GE19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 27, 2016 at 01:16:29PM +0100, Vladimir Murzin wrote:
> I've confused myself that support for CPU_SW_DOMAIN_PAN implies
> CONFIG_CPU_USE_DOMAINS, but now I see they are in fact different
> features/users of those accessors.
> 
> So something like below should be sufficient to fix my case, right?

How about:

 arch/arm/include/asm/domain.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/include/asm/domain.h b/arch/arm/include/asm/domain.h
index fc8ba1663601..4e218993c12d 100644
--- a/arch/arm/include/asm/domain.h
+++ b/arch/arm/include/asm/domain.h
@@ -84,6 +84,7 @@
 
 #ifndef __ASSEMBLY__
 
+#ifdef CONFIG_CPU_CP15
 static inline unsigned int get_domain(void)
 {
 	unsigned int domain;
@@ -103,6 +104,16 @@ static inline void set_domain(unsigned val)
 	  : : "r" (val) : "memory");
 	isb();
 }
+#else
+static inline unsigned int get_domain(void)
+{
+	return 0;
+}
+
+static inline void set_domain(unsigned val)
+{
+}
+#endif
 
 #ifdef CONFIG_CPU_USE_DOMAINS
 #define modify_domain(dom,type)					\

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
