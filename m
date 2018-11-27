From: rafael.tinoco@linaro.org (Rafael David Tinoco)
Date: Tue, 27 Nov 2018 18:52:54 -0200
Subject: [PATCH] arm: always update thread_info->syscall
In-Reply-To: <20181127153553.GE30658@n2100.armlinux.org.uk>
References: <20181126225335.10477-1-rafael.tinoco@linaro.org>
 <20181126233303.GZ30658@n2100.armlinux.org.uk>
 <20181126234111.GA30658@n2100.armlinux.org.uk>
 <20181126234456.GB30658@n2100.armlinux.org.uk>
 <ad23e3dc-eee0-f9af-2f12-bfd7a14cd546@linaro.org>
 <20181127105620.GD30658@n2100.armlinux.org.uk>
 <20181127153553.GE30658@n2100.armlinux.org.uk>
Message-ID: <df0f7e94-8577-2789-a749-77855387909e@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/27/18 1:35 PM, Russell King - ARM Linux wrote:
> On x86 (32-bit app on 64-bit kernel), it has this behaviour:
> 
> $ ./syscall-test
> 162 0xffcc5a6c 0xffcc5a6c 0x48d09000 0x0 0xffcc5af4 0xffcc5a74 0xffcc5a2c 0xf77dfa59
> 162 0xffcc5a6c 0xffcc5a6c 0x48d09000 0x0 0xffcc5af4 0xffcc5a74 0xffcc5a2c 0xf77dfa59
> 
> which looks good, except:
> 
> $ strace -o /dev/null -f ./syscall-test
> 162 0xffc0070c 0xffc0070c 0x48d09000 0x0 0xffc00794 0xffc00714 0xffc006cc 0xf77f3a59
> 0 0xffc0070c 0xffc0070c 0x48d09000 0x0 0xffc00794 0xffc00714 0xffc006cc 0xf77f3a59
> 
> So, if we're syscall ptracing a program, __NR_restart_syscall gets
> exposed through this interface, but if we aren't, it isn't exposed.
> Which version is correct?  *shrug*, no documentation...

I looked around and could only find people using this interface as an
alternate mechanism - than ptracing - for discovering what a task was
doing a certain moment (Mostly during hangs. I haven't found a good
schematic way - or tool - that uses it, but I might be wrong there). For
that purpose, it would be better *not* to update when restart_syscall
happens, unless the hang is right there =o).

If you check:
https://bugs.linaro.org/show_bug.cgi?id=3783#c11

The only syscalls being updated now - that I could get, without any
workload - were 252 (epoll_wait) or 252 (sched_getaffinity):

252 0x7 0xbee80578 0x1b 0xffffffff 0xbee80578 0x7 0xbee80550 0xb6e9d286
252 0xa 0xbef3d930 0x9 0xffffffff 0x0 0x6c 0xbef3d908 0xb6e6f286
142 0x4 0x0 0xbea3eb2c 0x0 0x0 0x6c 0xbea3ea88 0xb6e40286
252 0x4 0xbe8d59e8 0x9 0xffffffff 0xbe8d59e8 0x4 0xbe8d59c0 0xb6e11286

All others I got zeroed, and that's where everything started.

Please, let me know if you still want a v2, or something else... like
fixing it and making it to ignore the restart_syscall for *at least*
having the same behavior across diff archs.

If it is not worth, I'll just blacklist those tests in our functional
tests environment and move on =).

Thanks a lot, very best rgds,
-- 
Rafael D. Tinoco
Linaro Kernel Validation
