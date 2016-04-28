From: ynorov@caviumnetworks.com (Yury Norov)
Date: Fri, 29 Apr 2016 01:21:37 +0300
Subject: [PATCH 20/25] arm64:ilp32: add sys_ilp32.c and a separate table
 (in entry.S) to use it
In-Reply-To: <2760348.qmm1L3yQch@wuerfel>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <20160426165701.GE8525@e104818-lin.cambridge.arm.com>
 <20160428191914.GA28527@yury-N73SV> <2760348.qmm1L3yQch@wuerfel>
Message-ID: <20160428222137.GB18227@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 28, 2016 at 10:43:59PM +0200, Arnd Bergmann wrote:
> On Thursday 28 April 2016 22:19:14 Yury Norov wrote:
> > 
> > Yes, we need. Otherwise we have circular dependency like this:
> > arch/arm64/kernel/sys_ilp32.c:60:0: warning: "__SC_WRAP" redefined
> >  #define __SC_WRAP(nr, sym) [nr] = compat_##sym,
> >   ^
> >   In file included from include/asm-generic/unistd.h:1:0,
> >                    from ./arch/arm64/include/uapi/asm/unistd.h:16,
> >                    from ./arch/arm64/include/asm/unistd.h:62,
> >                    from ./include/uapi/linux/unistd.h:7,
> >                    from include/linux/syscalls.h:23,
> >                    from arch/arm64/kernel/sys_ilp32.c:30:
> > include/uapi/asm-generic/unistd.h:33:0: note: this is the location of the previous definition
> >  #define __SC_WRAP __SYSCALL
> > 
> > Defining __SYSCALL_COMPAT at the top of the file does not help much.
> 
> Hmm, this sounds like something that we should fix in the asm-generic/unistd.h
> file. Is it just for __SC_WRAP, or also the other macros?
> 
> 	Arnd

For __SYSCALL and __SC_WRAP:

diff --git a/arch/arm64/kernel/sys_ilp32.c
b/arch/arm64/kernel/sys_ilp32.c
index 1458ad7..410d817 100644
--- a/arch/arm64/kernel/sys_ilp32.c
+++ b/arch/arm64/kernel/sys_ilp32.c
@@ -17,6 +17,8 @@
 * along with this program.  If not, see
 * <http://www.gnu.org/licenses/>.
 */
    
+#define __SYSCALL_COMPAT
+
 #include <linux/compiler.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
@@ -48,13 +50,12 @@ asmlinkage long
 ilp32_sys_rt_sigreturn_wrapper(void);
   
 #include <asm/syscall.h>
     
-#undef __SYSCALL
-#undef __SC_COMP
-#undef __SC_WRAP
-#undef __SC_3264
-#undef __SC_COMP_3264
 
-#define __SYSCALL_COMPAT
 #define __SYSCALL(nr, sym)     [nr] = sym,
 #define __SC_WRAP(nr, sym)     [nr] = compat_##sym,
         
This patch makes gcc warn about redefinition.

arch/arm64/kernel/sys_ilp32.c:59:0: warning: "__SYSCALL" redefined
 #define __SYSCALL(nr, sym) [nr] = sym,
 ^
In file included from include/asm-generic/unistd.h:1:0,
                 from ./arch/arm64/include/uapi/asm/unistd.h:16,
                 from ./arch/arm64/include/asm/unistd.h:62,
                 from ./include/uapi/linux/unistd.h:7,
                 from include/linux/syscalls.h:23,
                 from arch/arm64/kernel/sys_ilp32.c:30:
include/uapi/asm-generic/unistd.h:15:0: note: this is the location of the previous definition
 #define __SYSCALL(x, y)
 ^
arch/arm64/kernel/sys_ilp32.c:60:0: warning: "__SC_WRAP" redefined
 #define __SC_WRAP(nr, sym) [nr] = compat_##sym,
 ^
In file included from include/asm-generic/unistd.h:1:0,
                 from ./arch/arm64/include/uapi/asm/unistd.h:16,
                 from ./arch/arm64/include/asm/unistd.h:62,
                 from ./include/uapi/linux/unistd.h:7,
                 from include/linux/syscalls.h:23,
                 from arch/arm64/kernel/sys_ilp32.c:30:
include/uapi/asm-generic/unistd.h:33:0: note: this is the location of the previous definition
 #define __SC_WRAP __SYSCALL
 ^
