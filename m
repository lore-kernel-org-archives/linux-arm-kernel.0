From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 30 Dec 2015 23:36:27 +0100
Subject: [PATCH v6 13/20] arm64: ilp32: share aarch32 syscall wrappers to
 ilp32
In-Reply-To: <20151230172905.GA8296@yury-N73SV>
References: <1450215766-14765-1-git-send-email-ynorov@caviumnetworks.com>
 <201512232141.54384.arnd@arndb.de> <20151230172905.GA8296@yury-N73SV>
Message-ID: <1875383.FRuM9m49WW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 30 December 2015 20:29:05 Yury Norov wrote:
> 
> So. For ilp32, the only wrapper left here, is compat_sys_mmap2_wrapper.
> But this is workaroud, as comment tells:
>         Note: off_4k (w5) is always in units of 4K. If we can't do the
>         requested offset because it is not page-aligned, we return -EINVAL.
> 
> Not sure we should pull it to ILP32. If so, we can call sys_mmap_pgoff()
> directly. And we don't need this patch at all therefore. Any throughts?
> 
> 

I think providing the 64-bit version of sys_mmap() would be the simplest
API, as that avoids any possible confusion about the shift amount (hardcoded
12 bits vs PAGE_BITS). It fits in with the other syscalls that pass an loff_t
value here.

	Arnd
