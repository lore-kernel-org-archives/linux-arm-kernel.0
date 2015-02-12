From: nsz@port70.net (Szabolcs Nagy)
Date: Thu, 12 Feb 2015 09:12:34 +0100
Subject: [musl] Re: [PATCHv3 00/24] ILP32 support in ARM64
In-Reply-To: <20150211190537.GK32724@port70.net>
References: <20141002155217.GH32147@e104818-lin.cambridge.arm.com>
 <20150210181302.GA23886@brightrain.aerifal.cx>
 <20150211173919.GF9058@e104818-lin.cambridge.arm.com>
 <20150211190537.GK32724@port70.net>
Message-ID: <20150212081234.GL32724@port70.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Szabolcs Nagy <nsz@port70.net> [2015-02-11 20:05:37 +0100]:
> 
> (i think this is also a problem if userspace code uses syscall(2) directly,
> libc cannot possibly know where to signextend and the kernel side does not
> do the fixup right now)
> 

nobody picked up this issue, is this resolved?

ie. if userspace calls syscall(SYS_foo,...) directly with 32bit
longs does it always work out correctly on the kernel side?

the sign extension is a problem for signed long arguments,
i only found these in the kernel:


fs/buffer.c:SYSCALL_DEFINE2(bdflush, int, func, long, data)

fs/open.c:SYSCALL_DEFINE2(truncate, const char __user *, path, long, length)

fs/aio.c:SYSCALL_DEFINE3(io_submit, aio_context_t, ctx_id, long, nr,
fs/aio.c-               struct iocb __user * __user *, iocbpp)

fs/aio.c:SYSCALL_DEFINE5(io_getevents, aio_context_t, ctx_id,
fs/aio.c-               long, min_nr,
fs/aio.c-               long, nr,

kernel/ptrace.c:SYSCALL_DEFINE4(ptrace, long, request, long, pid, unsigned long, addr,
kernel/ptrace.c-                unsigned long, data)

ipc/syscall.c:SYSCALL_DEFINE6(ipc, unsigned int, call, int, first, unsigned long, second,
ipc/syscall.c-          unsigned long, third, void __user *, ptr, long, fifth)
