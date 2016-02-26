From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Feb 2016 13:46:27 +0100
Subject: [PATCH 2/2] lib/mpi: use "static inline" instead of "extern inline"
In-Reply-To: <1456490794-1034544-1-git-send-email-arnd@arndb.de>
References: <1456490794-1034544-1-git-send-email-arnd@arndb.de>
Message-ID: <1456490794-1034544-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When we use CONFIG_PROFILE_ALL_BRANCHES, every 'if()' introduces
a static variable, but that is not allowed in 'extern inline'
functions:

mpi-inline.h:116:204: warning: '______f' is static but declared in inline function 'mpihelp_sub' which is not static
mpi-inline.h:113:184: warning: '______f' is static but declared in inline function 'mpihelp_sub' which is not static
mpi-inline.h:70:184: warning: '______f' is static but declared in inline function 'mpihelp_add' which is not static
mpi-inline.h:56:204: warning: '______f' is static but declared in inline function 'mpihelp_add_1' which is not static

This changes the MPI code to use 'static inline' instead, to get
rid of hundreds of warnings.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/mpi/mpi-inline.h   | 2 +-
 lib/mpi/mpi-internal.h | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/mpi/mpi-inline.h b/lib/mpi/mpi-inline.h
index e2b39852b30a..c245ea31f785 100644
--- a/lib/mpi/mpi-inline.h
+++ b/lib/mpi/mpi-inline.h
@@ -30,7 +30,7 @@
 #define G10_MPI_INLINE_H
 
 #ifndef G10_MPI_INLINE_DECL
-#define G10_MPI_INLINE_DECL  extern inline
+#define G10_MPI_INLINE_DECL  static inline
 #endif
 
 G10_MPI_INLINE_DECL mpi_limb_t
diff --git a/lib/mpi/mpi-internal.h b/lib/mpi/mpi-internal.h
index c65dd1bff45a..7eceeddb3fb8 100644
--- a/lib/mpi/mpi-internal.h
+++ b/lib/mpi/mpi-internal.h
@@ -168,19 +168,19 @@ void mpi_rshift_limbs(MPI a, unsigned int count);
 int mpi_lshift_limbs(MPI a, unsigned int count);
 
 /*-- mpihelp-add.c --*/
-mpi_limb_t mpihelp_add_1(mpi_ptr_t res_ptr, mpi_ptr_t s1_ptr,
+static inline mpi_limb_t mpihelp_add_1(mpi_ptr_t res_ptr, mpi_ptr_t s1_ptr,
 			 mpi_size_t s1_size, mpi_limb_t s2_limb);
 mpi_limb_t mpihelp_add_n(mpi_ptr_t res_ptr, mpi_ptr_t s1_ptr,
 			 mpi_ptr_t s2_ptr, mpi_size_t size);
-mpi_limb_t mpihelp_add(mpi_ptr_t res_ptr, mpi_ptr_t s1_ptr, mpi_size_t s1_size,
+static inline mpi_limb_t mpihelp_add(mpi_ptr_t res_ptr, mpi_ptr_t s1_ptr, mpi_size_t s1_size,
 		       mpi_ptr_t s2_ptr, mpi_size_t s2_size);
 
 /*-- mpihelp-sub.c --*/
-mpi_limb_t mpihelp_sub_1(mpi_ptr_t res_ptr, mpi_ptr_t s1_ptr,
+static inline mpi_limb_t mpihelp_sub_1(mpi_ptr_t res_ptr, mpi_ptr_t s1_ptr,
 			 mpi_size_t s1_size, mpi_limb_t s2_limb);
 mpi_limb_t mpihelp_sub_n(mpi_ptr_t res_ptr, mpi_ptr_t s1_ptr,
 			 mpi_ptr_t s2_ptr, mpi_size_t size);
-mpi_limb_t mpihelp_sub(mpi_ptr_t res_ptr, mpi_ptr_t s1_ptr, mpi_size_t s1_size,
+static inline mpi_limb_t mpihelp_sub(mpi_ptr_t res_ptr, mpi_ptr_t s1_ptr, mpi_size_t s1_size,
 		       mpi_ptr_t s2_ptr, mpi_size_t s2_size);
 
 /*-- mpihelp-cmp.c --*/
-- 
2.7.0
