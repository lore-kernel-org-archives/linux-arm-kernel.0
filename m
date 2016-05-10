From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 May 2016 10:36:40 +0200
Subject: [PATCH 20/25] arm64:ilp32: add sys_ilp32.c and a separate table
 (in entry.S) to use it
In-Reply-To: <573190CF.6030408@huawei.com>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <20160506123731.GA11959@yury-N73SV> <573190CF.6030408@huawei.com>
Message-ID: <9651510.pg5Vmm8vKS@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 May 2016 15:42:07 Zhangjian wrote:
> On 2016/5/6 20:37, Yury Norov wrote:
> > On Fri, May 06, 2016 at 08:16:48PM +0800, Zhangjian (Bamvor) wrote:
> >
> > AFAIR, here we don't shift offset, as it's 64-bit both in user-
> > and kernel-space,
> In your ilp32-2.22 branch, you wrapper mmap to mmap2 in which type of
> offset is off_t. And off_t is 32bit in ilp32, correct?
> "sysdeps/unix/sysv/linux/aarch64/ilp32/mmap64.c"
> /* mmap is provided by mmap as they are the same. */
> void *__mmap (void *__addr, size_t __len, int __prot,
>                       int __flags, int __fd, __off_t __offset)
> {
>     void *result;
>     result = (void *)
>       INLINE_SYSCALL (mmap2, 6, __addr,
>                       __len, __prot, __flags, __fd, __offset);
>     return result;
> }

__off_t should be 'long long' on new architectures, and map
to __kernel_loff_t.

Can you see how it is defined?

	Arnd
