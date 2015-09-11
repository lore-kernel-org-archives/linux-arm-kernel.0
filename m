From: ian.campbell@citrix.com (Ian Campbell)
Date: Fri, 11 Sep 2015 15:29:20 +0100
Subject: [PATCH] arm/xen: Enable user access to the kernel before
 issuing a privcmd call
In-Reply-To: <1441980963-9002-1-git-send-email-julien.grall@citrix.com>
References: <1441980963-9002-1-git-send-email-julien.grall@citrix.com>
Message-ID: <1441981760.3549.57.camel@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-09-11 at 15:16 +0100, Julien Grall wrote:
> When Xen is copyin data to/from the guest it will check if the kernel

"copying"

> has the right to do the access. If not, the hypercall will return an
> error.
> 
> After the commit a5e090acbf545c0a3b04080f8a488b17ec41fe02 "ARM:
> software-based priviledged-no-access support", the kernel can't access

"privileged"

> anymore the user space by default. This will result to fail on every

"any more" (or "any longer")

> hypercall made by the userspace (i.e via privcmd).
> 
> We have to enable the userspace access and then restore the correct
> permission everytime the privmcd is used to made an hypercall.

"every time" and "privcmd"

>  HYPERCALL1(tmem_op);
>  HYPERCALL2(multicall);
>  
> -ENTRY(privcmd_call)
> +ENTRY(__privcmd_call)

arch/arm/include/asm/assembler.h seems to contain uaccess_* macros which
could be used right here directly I think? That would be preferable to
wrapping I think.

Ian.
