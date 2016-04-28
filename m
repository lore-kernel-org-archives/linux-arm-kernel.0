From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 29 Apr 2016 00:43:41 +0200
Subject: [PATCH 20/25] arm64:ilp32: add sys_ilp32.c and a separate table
 (in entry.S) to use it
In-Reply-To: <20160428222137.GB18227@yury-N73SV>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <2760348.qmm1L3yQch@wuerfel> <20160428222137.GB18227@yury-N73SV>
Message-ID: <4271094.ei7kj5zJxn@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 29 April 2016 01:21:37 Yury Norov wrote:
> index 1458ad7..410d817 100644
> --- a/arch/arm64/kernel/sys_ilp32.c
> +++ b/arch/arm64/kernel/sys_ilp32.c
> @@ -17,6 +17,8 @@
>  * along with this program.  If not, see
>  * <http://www.gnu.org/licenses/>.
>  */
>     
> +#define __SYSCALL_COMPAT
> +
>  #include <linux/compiler.h>
>  #include <linux/errno.h>
>  #include <linux/fs.h>
> @@ -48,13 +50,12 @@ asmlinkage long
>  ilp32_sys_rt_sigreturn_wrapper(void);
>    
>  #include <asm/syscall.h>
>      
> -#undef __SYSCALL
> -#undef __SC_COMP
> -#undef __SC_WRAP
> -#undef __SC_3264
> -#undef __SC_COMP_3264
>  
> -#define __SYSCALL_COMPAT
>  #define __SYSCALL(nr, sym)     [nr] = sym,
>  #define __SC_WRAP(nr, sym)     [nr] = compat_##sym,
>          
> This patch makes gcc warn about redefinition.
> 
> arch/arm64/kernel/sys_ilp32.c:59:0: warning: "__SYSCALL" redefined
>  #define __SYSCALL(nr, sym) [nr] = sym,
>  ^
> In file included from include/asm-generic/unistd.h:1:0,
> 

Ok, I think I see it now. Can you #undef the two symbols at the
end of arch/arm64/include/uapi/asm/unistd.h or possibly
include/uapi/asm-generic/unistd.h?

	Arnd
