From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 May 2016 16:50:01 +0200
Subject: [PATCH 20/25] arm64:ilp32: add sys_ilp32.c and a separate table
 (in entry.S) to use it
In-Reply-To: <5733149C.4030903@huawei.com>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <573305A8.50406@huawei.com> <5733149C.4030903@huawei.com>
Message-ID: <5250356.myv9GIZ34h@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 11 May 2016 19:16:44 Zhangjian wrote:
> Hi,
> 
> On 2016/5/11 18:12, Zhangjian (Bamvor) wrote:
> > Hi, Arnd
> >
> > On 2016/5/11 16:09, Arnd Bergmann wrote:
> >  > On Wednesday 11 May 2016 10:04:16 Zhangjian wrote:
> >  >>> I don't remember. It's probably not important whether we have the shift
> >  >>> in there, as long as it's independent of the actual kernel page size and
> >  >>> user space and kernel agree on the calling conventions.
> >  >> Well. I am ok with where to shift the pages size because we get the same
> >  >> result. I was just thinking if we should get rid of the name of mmap2 in our
> >  >> ILP32 porting. Actually, it is mmap but we name it as mmap2. User may confused
> >  >> if they do not know the implementations.
> >  >
> >  > That is a good point: If the implementation matches the mmap() behavior rather than
> >  > mmap2(), we should rename the macro by doing
> >  >
> >  > #undef __NR_mmap2
> >  > #define __NR_mmap 222
> >  >
> >  > in the uapi/asm/unistd.h file for ilp32 mode.
> > Do you mean define the following things in kernel:
> > ```
> > diff --git a/arch/arm64/include/uapi/asm/unistd.h b/arch/arm64/include/uapi/asm/unistd.h
> > index 1caadc2..3f79640 100644
> > --- a/arch/arm64/include/uapi/asm/unistd.h
> > +++ b/arch/arm64/include/uapi/asm/unistd.h
> > @@ -14,3 +14,9 @@
> >    * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> >    */
> >   #include <asm-generic/unistd.h>
> > +
> > +#ifdef __ILP32__
> > +#undef __NR_mmap2
> > +#define __NR_mmap 222
> > +#endif /* #ifdef __ILP32__ */
> > +
> > ```
> > Then glibc could call mmap instead of mmap2.
> > I could not try it now. Because after change off_t to 64bit in glibc, stat
> > is fail. I may need to revert the stat relative patch.
> After revert stat relative patch in glibc, mmap01-mmap14 success. But mmap16
> success with segfault. I will investigate it later.
> 
> There is pointer and size_t in mmap, so, IIUC, we need to clear the top halves
> of register by using COMPAT_SYSCALL_WRAP6.

Correct, good catch!

> And after check the function in
> arch/s390/kernel/compat_linux.c, I feel that we need to do the same thing for
> pread64 and pwrite64.
> 

> But I got following error when I try to add
> COMPAT_SYSCALL_WRAP4(pread64, unsigned int, fd, char __user *, buf,
> size_t, count, loff_t, pos);
> COMPAT_SYSCALL_WRAP4(pwrite64, unsigned int, fd, const char __user *, buf,
> size_t, count, loff_t, pos);
> 

Hmm, that is indeed tricky. I think COMPAT_SYSCALL_WRAP4 rightfully
refuses the loff_t argument here, as the common case is that this is
not possible.

Can you open-code this using a COMPAT_SYSCALL4 definition similar to what
arch/tile has, but without the merging of the two halves of the argument?

	Arnd
