From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 4 Mar 2016 12:14:24 +0100
Subject: DWord alignment on ARMv7
In-Reply-To: <20160304110210.GA19428@n2100.arm.linux.org.uk>
References: <56D8BA3F.7050508@pengutronix.de> <20160303235426.GA11237@arm.com>
 <CAKv+Gu8D37DgfbopvB1On_=fNqrBzmCmOCTotX2Lvv6NoSCtvw@mail.gmail.com>
 <20160304110210.GA19428@n2100.arm.linux.org.uk>
Message-ID: <CAKv+Gu8b05BsNMPD2QNf9pLyRwSNGhc-5TVskwfudYuVqeCoAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 March 2016 at 12:02, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Mar 04, 2016 at 11:48:10AM +0100, Ard Biesheuvel wrote:
>> I don't think it is the job of the filesystem driver to reason about
>> whether get_unaligned_le64() does the right thing under any particular
>> configuration. If ARM's implementation of get_unaligned_le64() issues
>> load instructions that result in a trap, it is misbehaving and should
>> be fixed.
>
> It's not ARMs implementation, we don't have our own implementation, but
> we seem to (today) use asm-generic stuff, which is sub-optimal.
>

Indeed. I was not suggesting that ARM carries broken code, simply that
btrfs should not have to worry that it gets built on a platform that
requires extra care when invoking get_unaligned_le64()

> Looking at the state of that, I guess we need to implement our own
> asm/unaligned.h - and as the asm-generic stuff assumes that all
> access sizes fall into the same categories, I'm guessing we'll need
> to implement _all_ accessors ourselves.
>
> That really sounds very sub-optimal, but I don't see any other solution
> which wouldn't make the asm-generic stuff even more painful to follow
> through multiple include files than it already is today.
>

I wonder if we should simply apply something like the patch below
(untested): it depends on how many 32-bit architectures implement
double word load instructions, but for ones that don't, the patch
shouldn't change anything, nor should it change anything for 64-bit
architectures.



-------8<-----------
diff --git a/include/linux/unaligned/access_ok.h
b/include/linux/unaligned/access_ok.h
index 99c1b4d20b0f..019d0b7ea6a3 100644
--- a/include/linux/unaligned/access_ok.h
+++ b/include/linux/unaligned/access_ok.h
@@ -16,7 +16,11 @@ static inline u32 get_unaligned_le32(const void *p)

 static inline u64 get_unaligned_le64(const void *p)
 {
-       return le64_to_cpup((__le64 *)p);
+       if (BITS_PER_LONG == 64)
+               return le64_to_cpup((__le64 *)p);
+       else
+               return ((u64)le32_to_cpup((__le32 *)p)) |
+                      ((u64)le32_to_cpup((__le32 *)p + 1) << 32);
 }

 static inline u16 get_unaligned_be16(const void *p)
@@ -31,7 +35,11 @@ static inline u32 get_unaligned_be32(const void *p)

 static inline u64 get_unaligned_be64(const void *p)
 {
-       return be64_to_cpup((__be64 *)p);
+       if (BITS_PER_LONG == 64)
+               return be64_to_cpup((__be64 *)p);
+       else
+               return ((u64)be32_to_cpup((__be32 *)p) << 32) |
+                      ((u64)be32_to_cpup((__be32 *)p + 1));
 }

 static inline void put_unaligned_le16(u16 val, void *p)
@@ -46,7 +54,12 @@ static inline void put_unaligned_le32(u32 val, void *p)

 static inline void put_unaligned_le64(u64 val, void *p)
 {
-       *((__le64 *)p) = cpu_to_le64(val);
+       if (BITS_PER_LONG == 64) {
+               *((__le64 *)p) = cpu_to_le64(val);
+       } else {
+               *((__le32 *)p) = cpu_to_le32(val);
+               *((__le32 *)p + 1) = cpu_to_le32(val >> 32);
+       }
 }

 static inline void put_unaligned_be16(u16 val, void *p)
@@ -61,7 +74,12 @@ static inline void put_unaligned_be32(u32 val, void *p)

 static inline void put_unaligned_be64(u64 val, void *p)
 {
-       *((__be64 *)p) = cpu_to_be64(val);
+       if (BITS_PER_LONG == 64) {
+               *((__be64 *)p) = cpu_to_be64(val);
+       } else {
+               *((__be32 *)p) = cpu_to_le32(val >> 32);
+               *((__be32 *)p + 1) = cpu_to_le32(val);
+       }
 }

 #endif /* _LINUX_UNALIGNED_ACCESS_OK_H */
