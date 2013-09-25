From: gang.chen@asianux.com (Chen Gang)
Date: Wed, 25 Sep 2013 10:25:19 +0800
Subject: [PATCH v2] ARM: include: asm: use 'long long' instead of 'u64' within
 atomic.h
In-Reply-To: <20130924093041.GB15119@mudshark.cambridge.arm.com>
References: <523D7DC7.8030603@asianux.com>
 <20130924093041.GB15119@mudshark.cambridge.arm.com>
Message-ID: <5242498F.8060407@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

atomic* value is signed value, and atomic* functions need also process
signed value (parameter value, and return value), so 32-bit arm need
use 'long long' instead of 'u64'.

After replacement, it will also fix a bug for atomic64_add_negative():
"u64 is never less than 0".

The modifications are:

  in vim, use "1,% s/\<u64\>/long long/g" command.
  remove '__aligned(8)' which is useless for 64-bit.
  be sure of 80 column limitation after replacement.


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/arm/include/asm/atomic.h |   49 +++++++++++++++++++++--------------------
 1 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
index da1c77d..a715ac0 100644
--- a/arch/arm/include/asm/atomic.h
+++ b/arch/arm/include/asm/atomic.h
@@ -238,15 +238,15 @@ static inline int __atomic_add_unless(atomic_t *v, int a, int u)
 
 #ifndef CONFIG_GENERIC_ATOMIC64
 typedef struct {
-	u64 __aligned(8) counter;
+	long long counter;
 } atomic64_t;
 
 #define ATOMIC64_INIT(i) { (i) }
 
 #ifdef CONFIG_ARM_LPAE
-static inline u64 atomic64_read(const atomic64_t *v)
+static inline long long atomic64_read(const atomic64_t *v)
 {
-	u64 result;
+	long long result;
 
 	__asm__ __volatile__("@ atomic64_read\n"
 "	ldrd	%0, %H0, [%1]"
@@ -257,7 +257,7 @@ static inline u64 atomic64_read(const atomic64_t *v)
 	return result;
 }
 
-static inline void atomic64_set(atomic64_t *v, u64 i)
+static inline void atomic64_set(atomic64_t *v, long long i)
 {
 	__asm__ __volatile__("@ atomic64_set\n"
 "	strd	%2, %H2, [%1]"
@@ -266,9 +266,9 @@ static inline void atomic64_set(atomic64_t *v, u64 i)
 	);
 }
 #else
-static inline u64 atomic64_read(const atomic64_t *v)
+static inline long long atomic64_read(const atomic64_t *v)
 {
-	u64 result;
+	long long result;
 
 	__asm__ __volatile__("@ atomic64_read\n"
 "	ldrexd	%0, %H0, [%1]"
@@ -279,9 +279,9 @@ static inline u64 atomic64_read(const atomic64_t *v)
 	return result;
 }
 
-static inline void atomic64_set(atomic64_t *v, u64 i)
+static inline void atomic64_set(atomic64_t *v, long long i)
 {
-	u64 tmp;
+	long long tmp;
 
 	__asm__ __volatile__("@ atomic64_set\n"
 "1:	ldrexd	%0, %H0, [%2]\n"
@@ -294,9 +294,9 @@ static inline void atomic64_set(atomic64_t *v, u64 i)
 }
 #endif
 
-static inline void atomic64_add(u64 i, atomic64_t *v)
+static inline void atomic64_add(long long i, atomic64_t *v)
 {
-	u64 result;
+	long long result;
 	unsigned long tmp;
 
 	__asm__ __volatile__("@ atomic64_add\n"
@@ -311,9 +311,9 @@ static inline void atomic64_add(u64 i, atomic64_t *v)
 	: "cc");
 }
 
-static inline u64 atomic64_add_return(u64 i, atomic64_t *v)
+static inline long long atomic64_add_return(long long i, atomic64_t *v)
 {
-	u64 result;
+	long long result;
 	unsigned long tmp;
 
 	smp_mb();
@@ -334,9 +334,9 @@ static inline u64 atomic64_add_return(u64 i, atomic64_t *v)
 	return result;
 }
 
-static inline void atomic64_sub(u64 i, atomic64_t *v)
+static inline void atomic64_sub(long long i, atomic64_t *v)
 {
-	u64 result;
+	long long result;
 	unsigned long tmp;
 
 	__asm__ __volatile__("@ atomic64_sub\n"
@@ -351,9 +351,9 @@ static inline void atomic64_sub(u64 i, atomic64_t *v)
 	: "cc");
 }
 
-static inline u64 atomic64_sub_return(u64 i, atomic64_t *v)
+static inline long long atomic64_sub_return(long long i, atomic64_t *v)
 {
-	u64 result;
+	long long result;
 	unsigned long tmp;
 
 	smp_mb();
@@ -374,9 +374,10 @@ static inline u64 atomic64_sub_return(u64 i, atomic64_t *v)
 	return result;
 }
 
-static inline u64 atomic64_cmpxchg(atomic64_t *ptr, u64 old, u64 new)
+static inline long long atomic64_cmpxchg(atomic64_t *ptr, long long old,
+					long long new)
 {
-	u64 oldval;
+	long long oldval;
 	unsigned long res;
 
 	smp_mb();
@@ -398,9 +399,9 @@ static inline u64 atomic64_cmpxchg(atomic64_t *ptr, u64 old, u64 new)
 	return oldval;
 }
 
-static inline u64 atomic64_xchg(atomic64_t *ptr, u64 new)
+static inline long long atomic64_xchg(atomic64_t *ptr, long long new)
 {
-	u64 result;
+	long long result;
 	unsigned long tmp;
 
 	smp_mb();
@@ -419,9 +420,9 @@ static inline u64 atomic64_xchg(atomic64_t *ptr, u64 new)
 	return result;
 }
 
-static inline u64 atomic64_dec_if_positive(atomic64_t *v)
+static inline long long atomic64_dec_if_positive(atomic64_t *v)
 {
-	u64 result;
+	long long result;
 	unsigned long tmp;
 
 	smp_mb();
@@ -445,9 +446,9 @@ static inline u64 atomic64_dec_if_positive(atomic64_t *v)
 	return result;
 }
 
-static inline int atomic64_add_unless(atomic64_t *v, u64 a, u64 u)
+static inline int atomic64_add_unless(atomic64_t *v, long long a, long long u)
 {
-	u64 val;
+	long long val;
 	unsigned long tmp;
 	int ret = 1;
 
-- 
1.7.7.6
