From: bamvor.zhangjian@huawei.com (Zhangjian (Bamvor))
Date: Sat, 26 Mar 2016 21:08:41 +0800
Subject: [RFC5 PATCH v6 00/21] ILP32 for ARM64
In-Reply-To: <20160321184012.GA26563@yury-N73SV>
References: <1452792198-10718-1-git-send-email-ynorov@caviumnetworks.com>
 <56AB3805.1040308@huawei.com> <20160129170929.GA3543@yury-N73SV>
 <56AC38F1.2030608@huawei.com> <20160218223506.GA7816@yury-N73SV>
 <mvm8u29ukqw.fsf@hawking.suse.de> <20160225202855.GD16123@yury-N73SV>
 <56EBD84D.2060009@huawei.com> <20160318154918.GA1595@yury-N73SV>
 <mvmoaa8dwre.fsf@hawking.suse.de> <20160321184012.GA26563@yury-N73SV>
Message-ID: <56F689D9.2090800@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Yury

On 2016/3/22 2:40, Yury Norov wrote:
> On Mon, Mar 21, 2016 at 10:07:49AM +0100, Andreas Schwab wrote:
[...]
>
> Hi Andreas,
>
> Thank you for your patch. It seems like it fixed a couple of tests.
> I applied it to the library branch. Current list of fails is like this:
> float_bessel                   FAIL       137
> float_exp_log                  FAIL       137
> float_iperb                    FAIL       137
> float_power                    FAIL       137
> float_trigo                    FAIL       137
> pipeio_3                       FAIL       5
> abort01                        FAIL       2
> clone02                        FAIL       4
> kill10                         FAIL       2
> kill11                         FAIL       2
> mmap16                         FAIL       6
> nftw01                         FAIL       1
> nftw6401                       FAIL       1
> open12                         FAIL       2
> pathconf01                     FAIL       1
> profil01                       FAIL       1
> rename11                       FAIL       2
> rmdir02                        FAIL       2
> umount2_01                     FAIL       2
> umount2_02                     FAIL       2
> umount2_03                     FAIL       2
> utime06                        FAIL       2
> mtest06                        FAIL       11
This is a patch for glibc.
I found 64bit register is used in sysdep.h. It could fix some failure
in bigendian. I do not test it on little endian yet. Hope It helps.

Regards

Bamvor
 From a4af2b7a8903ac5e033ba838ec3328bdeb1113ba Mon Sep 17 00:00:00 2001
From: Yang Yingliang <yangyingliang@huawei.com>
Date: Thu, 13 Nov 2014 16:05:58 +0800
Subject: [PATCH] ARM64: ILP32: change register x1 to PTR_REG

It should use 32-bit register instead of 64-bit register in ILP32.

Suggested-by: Andrew Pinski <apinski@cavium.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Bamvor Jian Zhang <bamvor.zhangjian@huawei.com>
---
  sysdeps/aarch64/sysdep.h                 | 2 +-
  sysdeps/unix/sysv/linux/aarch64/sysdep.h | 2 +-
  2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sysdeps/aarch64/sysdep.h b/sysdeps/aarch64/sysdep.h
index 6673242..742d23c 100644
--- a/sysdeps/aarch64/sysdep.h
+++ b/sysdeps/aarch64/sysdep.h
@@ -104,7 +104,7 @@
  #define LDST_GLOBAL(OP, R, T,  EXPR)			\
  	adrp	x##T, :got:EXPR;			\
  	ldr	PTR_REG (T), [x##T, #:got_lo12:EXPR];	\
-	OP	x##R, [x##T];
+	OP	PTR_REG (R), [x##T];

  /* Since C identifiers are not normally prefixed with an underscore
     on this system, the asm identifier `syscall_error' intrudes on the
diff --git a/sysdeps/unix/sysv/linux/aarch64/sysdep.h b/sysdeps/unix/sysv/linux/aarch64/sysdep.h
index 2bfec77..8fb8a6b 100644
--- a/sysdeps/unix/sysv/linux/aarch64/sysdep.h
+++ b/sysdeps/unix/sysv/linux/aarch64/sysdep.h
@@ -108,7 +108,7 @@
  .Lsyscall_error:						\
  	adrp	x1, :gottprel:errno;				\
  	neg	w2, w0;						\
-	ldr	x1, [x1, :gottprel_lo12:errno];			\
+	ldr	PTR_REG(1), [x1, :gottprel_lo12:errno];		\
  	mrs	x3, tpidr_el0;					\
  	mov	x0, -1;						\
  	str	w2, [x1, x3];					\
-- 
1.8.4.5


> Yury.
>
