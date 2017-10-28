From: gengdongjiu@huawei.com (Dongjiu Geng)
Date: Sat, 28 Oct 2017 14:45:59 +0800
Subject: [PATCH v3] KVM: arm/arm64: fix the incompatible matching for external
 abort
Message-ID: <1509173159-30579-1-git-send-email-gengdongjiu@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For this matching, switch expression uses fault type which is
not {I,D}FSC value, but the case expression uses {I,D}FSC,
they are incompatible. So change the switch expression to
use {I,D}FSC.

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
---
 arch/arm/include/asm/kvm_emulate.h   | 2 +-
 arch/arm64/include/asm/kvm_emulate.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/kvm_emulate.h b/arch/arm/include/asm/kvm_emulate.h
index 98089ff..7571b4e 100644
--- a/arch/arm/include/asm/kvm_emulate.h
+++ b/arch/arm/include/asm/kvm_emulate.h
@@ -203,7 +203,7 @@ static inline u8 kvm_vcpu_trap_get_fault_type(struct kvm_vcpu *vcpu)
 
 static inline bool kvm_vcpu_dabt_isextabt(struct kvm_vcpu *vcpu)
 {
-	switch (kvm_vcpu_trap_get_fault_type(vcpu)) {
+	switch (kvm_vcpu_trap_get_fault(vcpu)) {
 	case FSC_SEA:
 	case FSC_SEA_TTW0:
 	case FSC_SEA_TTW1:
diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index e5df3fc..8c918c5 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -237,7 +237,7 @@ static inline u8 kvm_vcpu_trap_get_fault_type(const struct kvm_vcpu *vcpu)
 
 static inline bool kvm_vcpu_dabt_isextabt(const struct kvm_vcpu *vcpu)
 {
-	switch (kvm_vcpu_trap_get_fault_type(vcpu)) {
+	switch (kvm_vcpu_trap_get_fault(vcpu)) {
 	case FSC_SEA:
 	case FSC_SEA_TTW0:
 	case FSC_SEA_TTW1:
-- 
1.9.1
