From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 04 Mar 2016 16:49:33 +0100
Subject: DWord alignment on ARMv7
In-Reply-To: <20160304145656.GC19428@n2100.arm.linux.org.uk>
References: <56D8BA3F.7050508@pengutronix.de> <2494410.DJhrOHD4yE@wuerfel>
 <20160304145656.GC19428@n2100.arm.linux.org.uk>
Message-ID: <2294120.VJxTtGXQFz@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 04 March 2016 14:56:56 Russell King - ARM Linux wrote:
> On Fri, Mar 04, 2016 at 03:41:58PM +0100, Arnd Bergmann wrote:
> > On Friday 04 March 2016 13:46:51 Russell King - ARM Linux wrote:
> > > On Fri, Mar 04, 2016 at 02:30:23PM +0100, Arnd Bergmann wrote:
> > > > Ah, I thought it only required 32-bit alignment like ldm/stm, but it
> > > > seems that it won't do that. However, an implementation like
> > > > 
> > > > unsigned long long get_unaligned_u64(void *p)
> > > > {
> > > >         unsigned long long upper, lower;
> > > >         lower = *(unsigned long*)p;
> > > >         upper = *(unsigned long*)(p+4);
> > > > 
> > > >         return lower | (upper << 32);
> > > > }
> > > > 
> > > > does get compiled into
> > > > 
> > > > 00000000 <f>:
> > > >    0:   e8900003        ldm     r0, {r0, r1}
> > > >    4:   e12fff1e        bx      lr
> > > 
> > > I think it may be something of a bitch to work around, because the
> > > compiler is going to do stuff like that behind your back.
> > > 
> > > The only way around that would be to bypass the compiler by using
> > > asm(), but then you end up bypassing the instruction scheduling too.
> > > That may not matter, as the resulting overhead may still be lower.
> > 
> > I think the compiler is correctly optimizing the code according to
> > what we tell it about the alignment here:
> 
> It is, that's not what I was saying though - I wasn't saying whether or
> not the compiler is correctly optimising the code (it is.)  I was saying
> that we _don't_ want the compiler optimising the code in this way here -
> that's a completely _different_ point.

Yes, I understood that. What I meant was that the kernel implementation
here tells the compiler that it's safe to do certain optimization when
it's actually not.

> > 
> > because it will allow using ldr/str+rev for unaligned
> > cross-endian accesses, but disallow ldm/stm+rev.
> 
> Looks like it's going to make the unaligned stuff even more of a rabbit
> warren of include files.

So here is what I came up with. I think this should be good on
most architectures (if we are not sure about that, we could make
it ARM and ARM64 specific), and it's actually noticeably simpler than
the previous version. This again removes the distinction between
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS set and not set in the
get_unaligned code (as it was before the patch that introduced
the regression), but optimizes the cross-endian loads/stores enough
so the compiler uses the same access as native-endian, followed
by a byte swap operation on architectures that have it.

	Arnd

commit 5987b14b8d13eafc3bb78b070c4d482706cf3ce6
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Fri Mar 4 16:15:20 2016 +0100

    asm-generic: always use struct based unaligned access
    
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

 include/asm-generic/unaligned.h     | 20 +++++---------------
 include/linux/unaligned/be_struct.h | 13 +++++++------
 include/linux/unaligned/le_struct.h | 13 +++++++------
 3 files changed, 19 insertions(+), 27 deletions(-)

diff --git a/include/asm-generic/unaligned.h b/include/asm-generic/unaligned.h
index 1ac097279db1..e8f5523eeb0a 100644
--- a/include/asm-generic/unaligned.h
+++ b/include/asm-generic/unaligned.h
@@ -3,29 +3,19 @@
 
 /*
  * This is the most generic implementation of unaligned accesses
- * and should work almost anywhere.
+ * and should work almost anywhere, we trust that the compiler
+ * knows how to handle unaligned accesses.
  */
 #include <asm/byteorder.h>
 
-/* Set by the arch if it can handle unaligned accesses in hardware. */
-#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
-# include <linux/unaligned/access_ok.h>
-#endif
+#include <linux/unaligned/le_struct.h>
+#include <linux/unaligned/be_struct.h>
+#include <linux/unaligned/generic.h>
 
 #if defined(__LITTLE_ENDIAN)
-# ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
-#  include <linux/unaligned/le_struct.h>
-#  include <linux/unaligned/be_byteshift.h>
-# endif
-# include <linux/unaligned/generic.h>
 # define get_unaligned	__get_unaligned_le
 # define put_unaligned	__put_unaligned_le
 #elif defined(__BIG_ENDIAN)
-# ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
-#  include <linux/unaligned/be_struct.h>
-#  include <linux/unaligned/le_byteshift.h>
-# endif
-# include <linux/unaligned/generic.h>
 # define get_unaligned	__get_unaligned_be
 # define put_unaligned	__put_unaligned_be
 #else
diff --git a/include/linux/unaligned/be_struct.h b/include/linux/unaligned/be_struct.h
index 132415836c50..9ab8c53bb3fe 100644
--- a/include/linux/unaligned/be_struct.h
+++ b/include/linux/unaligned/be_struct.h
@@ -2,35 +2,36 @@
 #define _LINUX_UNALIGNED_BE_STRUCT_H
 
 #include <linux/unaligned/packed_struct.h>
+#include <asm/byteorder.h>
 
 static inline u16 get_unaligned_be16(const void *p)
 {
-	return __get_unaligned_cpu16((const u8 *)p);
+	return be16_to_cpu((__le16 __force)__get_unaligned_cpu16((const u8 *)p));
 }
 
 static inline u32 get_unaligned_be32(const void *p)
 {
-	return __get_unaligned_cpu32((const u8 *)p);
+	return be32_to_cpu((__le32 __force)__get_unaligned_cpu32((const u8 *)p));
 }
 
 static inline u64 get_unaligned_be64(const void *p)
 {
-	return __get_unaligned_cpu64((const u8 *)p);
+	return be64_to_cpu((__le64 __force)__get_unaligned_cpu64((const u8 *)p));
 }
 
 static inline void put_unaligned_be16(u16 val, void *p)
 {
-	__put_unaligned_cpu16(val, p);
+	__put_unaligned_cpu16((u16 __force)cpu_to_be16(val), p);
 }
 
 static inline void put_unaligned_be32(u32 val, void *p)
 {
-	__put_unaligned_cpu32(val, p);
+	__put_unaligned_cpu32((u32 __force)cpu_to_be32(val), p);
 }
 
 static inline void put_unaligned_be64(u64 val, void *p)
 {
-	__put_unaligned_cpu64(val, p);
+	__put_unaligned_cpu64((u64 __force)cpu_to_be64(val), p);
 }
 
 #endif /* _LINUX_UNALIGNED_BE_STRUCT_H */
diff --git a/include/linux/unaligned/le_struct.h b/include/linux/unaligned/le_struct.h
index 088c4572faa8..64171ad0b100 100644
--- a/include/linux/unaligned/le_struct.h
+++ b/include/linux/unaligned/le_struct.h
@@ -2,35 +2,36 @@
 #define _LINUX_UNALIGNED_LE_STRUCT_H
 
 #include <linux/unaligned/packed_struct.h>
+#include <asm/byteorder.h>
 
 static inline u16 get_unaligned_le16(const void *p)
 {
-	return __get_unaligned_cpu16((const u8 *)p);
+	return le16_to_cpu((__le16 __force)__get_unaligned_cpu16((const u8 *)p));
 }
 
 static inline u32 get_unaligned_le32(const void *p)
 {
-	return __get_unaligned_cpu32((const u8 *)p);
+	return le32_to_cpu((__le32 __force)__get_unaligned_cpu32((const u8 *)p));
 }
 
 static inline u64 get_unaligned_le64(const void *p)
 {
-	return __get_unaligned_cpu64((const u8 *)p);
+	return le64_to_cpu((__le64 __force)__get_unaligned_cpu64((const u8 *)p));
 }
 
 static inline void put_unaligned_le16(u16 val, void *p)
 {
-	__put_unaligned_cpu16(val, p);
+	__put_unaligned_cpu16((u16 __force)cpu_to_le16(val), p);
 }
 
 static inline void put_unaligned_le32(u32 val, void *p)
 {
-	__put_unaligned_cpu32(val, p);
+	__put_unaligned_cpu32((u32 __force)cpu_to_le32(val), p);
 }
 
 static inline void put_unaligned_le64(u64 val, void *p)
 {
-	__put_unaligned_cpu64(val, p);
+	__put_unaligned_cpu64((u64 __force)cpu_to_le64(val), p);
 }
 
 #endif /* _LINUX_UNALIGNED_LE_STRUCT_H */
