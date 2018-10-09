From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  9 Oct 2018 13:26:11 +0100
Subject: [PATCH 1/1] ARM: KVM: Correctly order SGI register entries in the
 cp15 array
In-Reply-To: <20181009122611.85534-1-marc.zyngier@arm.com>
References: <20181009122611.85534-1-marc.zyngier@arm.com>
Message-ID: <20181009122611.85534-2-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ICC_ASGI1R and ICC_SGI0R register entries in the cp15 array
are not correctly ordered, leading to a BUG() at boot time.

Move them to their natural location.

Fixes: 3e8a8a50c7ef ("KVM: arm: vgic-v3: Add support for ICC_SGI0R and ICC_ASGI1R accesses")
Reported-by: Florian Fainelli <f.fainelli@gmail.com>
Tested-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/coproc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kvm/coproc.c b/arch/arm/kvm/coproc.c
index 450c7a4fbc8a..cb094e55dc5f 100644
--- a/arch/arm/kvm/coproc.c
+++ b/arch/arm/kvm/coproc.c
@@ -478,15 +478,15 @@ static const struct coproc_reg cp15_regs[] = {
 
 	/* ICC_SGI1R */
 	{ CRm64(12), Op1( 0), is64, access_gic_sgi},
-	/* ICC_ASGI1R */
-	{ CRm64(12), Op1( 1), is64, access_gic_sgi},
-	/* ICC_SGI0R */
-	{ CRm64(12), Op1( 2), is64, access_gic_sgi},
 
 	/* VBAR: swapped by interrupt.S. */
 	{ CRn(12), CRm( 0), Op1( 0), Op2( 0), is32,
 			NULL, reset_val, c12_VBAR, 0x00000000 },
 
+	/* ICC_ASGI1R */
+	{ CRm64(12), Op1( 1), is64, access_gic_sgi},
+	/* ICC_SGI0R */
+	{ CRm64(12), Op1( 2), is64, access_gic_sgi},
 	/* ICC_SRE */
 	{ CRn(12), CRm(12), Op1( 0), Op2(5), is32, access_gic_sre },
 
-- 
2.19.1
