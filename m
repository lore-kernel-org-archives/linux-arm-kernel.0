From: haokexin@gmail.com (Kevin Hao)
Date: Thu, 15 Jan 2015 15:09:26 +0800
Subject: [PATCH] arm64: kill off the libgcc dependency
In-Reply-To: <20150114143926.GY12302@n2100.arm.linux.org.uk>
References: <1421231934-31720-1-git-send-email-haokexin@gmail.com>
 <3138622.1rQcFu1jAj@wuerfel> <20150114114827.GH4050@arm.com>
 <2438951.7KFuXx85Hp@wuerfel>
 <CAKv+Gu-E=0Fm7woFSWcdBLfmxB+5diGtO91c2zy-t2M1_NTNeg@mail.gmail.com>
 <20150114143926.GY12302@n2100.arm.linux.org.uk>
Message-ID: <20150115070925.GB23621@pek-khao-d1.corp.ad.wrs.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 14, 2015 at 02:39:26PM +0000, Russell King - ARM Linux wrote:
> It's actually exactly issues like this which have prompted the kernel to
> use its own libgcc on many architectures.
> 
> Not only is it what Arnd says above, but it's also to do with making sure
> that we know what goes into the kernel is sane.
> 
> Although libgcc is part of the compiler, libgcc is built with the
> expectation that it will be running in userland - it expects to link
> to a libc.  That's why you can't build libgcc without having the glibc
> headers around.
> 
> For example, on ARM, libgcc.a may contain calls to __div0, and it may
> provide its own __div0 implementation, which invokes various Linux
> system calls.
> 
> Various functions reference _GLOBAL_OFFSET_TABLE_ which we don't want
> to have in the kernel.
> 
> Depending on how the compiler was built, libgcc.a may be built for
> ARMv4, ARMv5, ARMv6 or ARMv7, and may not be appropriate for linking
> with the kernel.  (Eg, you wouldn't want to try to link an ARMv7
> libgcc.a in an ARMv5 kernel - and we /really/ don't want the mess
> of having different toolchains for different ARM arch versions.)
> 
> It may also drag in the userspace exception unwind support.
> 
> Meanwhile, having the kernel build the compiler support functions that
> it needs ensures that (a) we know what compiler support functions are
> being used, (b) we know the implementation of those support functions
> are sane for use in the kernel, (c) we can build them with appropriate
> compiler flags for best performance, and (d) we remove an unnecessary
> dependency on the build toolchain.

Thanks Russell for the detailed explanation. I will put this into the
commit log.

Thanks,
Kevin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150115/aafd24dc/attachment.sig>
