From: mingo@kernel.org (Ingo Molnar)
Date: Tue, 26 Nov 2013 12:19:08 +0100
Subject: [PATCH] use -fstack-protector-strong
In-Reply-To: <alpine.LFD.2.10.1311252310080.9667@knanqh.ubzr>
References: <20131125221400.GA11041@www.outflux.net>
 <5293DA66.6050902@zytor.com>
 <CAGXu5j+QpAhifwjTdmsvk+i1Yq3Qk2CkzNgfFnttmfMh_B3buQ@mail.gmail.com>
 <alpine.LFD.2.10.1311252310080.9667@knanqh.ubzr>
Message-ID: <20131126111908.GB2410@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Nicolas Pitre <nicolas.pitre@linaro.org> wrote:

> On Mon, 25 Nov 2013, Kees Cook wrote:
> 
> > On Mon, Nov 25, 2013 at 3:16 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> > > On 11/25/2013 02:14 PM, Kees Cook wrote:
> > >> Build the kernel with -fstack-protector-strong when it is available
> > >> (gcc 4.9 and later). This increases the coverage of the stack protector
> > >> without the heavy performance hit of -fstack-protector-all.
> > >
> > > What is the difference between the various options?
> > 
> > -fstack-protector-all:
> > Adds the stack-canary saving prefix and stack-canary checking suffix
> > to _all_ function entry and exit. Results in substantial use of stack
> > space for saving the canary for deep stack users (e.g. historically
> > xfs), and measurable (though shockingly still low) performance hit due
> > to all the saving/checking. Really not suitable for sane systems, and
> > was entirely removed as an option from the kernel many years ago.
> > 
> > -fstack-protector:
> > Adds the canary save/check to functions that define an 8
> > (--param=ssp-buffer-size=N, N=8 by default) or more byte local char
> > array. Traditionally, stack overflows happened with string-based
> > manipulations, so this was a way to find those functions. Very few
> > total functions actually get the canary; no measurable performance or
> > size overhead.
> > 
> > -fstack-protector-strong
> > Adds the canary for a wider set of functions, since it's not just
> > those with strings that have ultimately been vulnerable to
> > stack-busting. With this superset, more functions end up with a
> > canary, but it still remains small compared to all functions with no
> > measurable change in performance. Based on the original design
> > document, a function gets the canary when it contains any of:
> > - local variable's address used as part of the RHS of an assignment or
> > function argument
> > - local variable is an array (or union containing an array),
> > regardless of array type or length
> > - uses register local variables
> > https://docs.google.com/a/google.com/document/d/1xXBH6rRZue4f296vGt9YQcuLVQHeE516stHwt8M9xyU
> > 
> > Chrome OS has been using -fstack-protector-strong for its kernel
> > builds for the last 8 months with no problems.
> 
> Could you get this information inside the commit log for your patch 
> please?  This is very valuable info to have right next to the change 
> in the repository without having to dig into the gcc manual or 
> finding the relevant email thread.

Another piece of information we need for the changelog is a vmlinux 
kernel size comparison, with/without the patch, for a defconfig build 
(or a Ubuntu distro config build).

Thanks,

	Ingo
