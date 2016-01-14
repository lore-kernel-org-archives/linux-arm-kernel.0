From: ynorov@caviumnetworks.com (Yury Norov)
Date: Thu, 14 Jan 2016 21:11:43 +0300
Subject: [PATCH v6 20/21] all: s390: make compat wrappers the generic
 solution
In-Reply-To: <1452792198-10718-21-git-send-email-ynorov@caviumnetworks.com>
References: <1452792198-10718-1-git-send-email-ynorov@caviumnetworks.com>
 <1452792198-10718-21-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <20160114181143.GA11048@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 14, 2016 at 08:23:17PM +0300, Yury Norov wrote:
> The problem that makes us to use wrappers is that some compat
> architectures allows user code to access top halves of registers.
> This is not a problem for syscalls that are already handled by compat
> code, or for that who has types of the same size in kernel and
> userspace. In case of lp64/ilp32 the problem is in pointer types, long,
> unsigned long.
> 
> S390 folks already have the solution for it. In this patch,
> it is turned to be general, as arm64/ilp32 needs it too.
> 
> Build-tested on s390.
> 
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> ---

[...]

> +#ifndef __SC_COMPAT_CAST
> +#define __SC_COMPAT_CAST(t, a)	((t)(long) ((t)(-1) < 0 ? (s32)(a) : (u32)(a)))
> +#endif

It should be like:
#define __SC_COMPAT_CAST(t, a)	((t) ((t)(-1) < 0 ? (s64)(s32)(a) : (u64)(u32)(a)))
