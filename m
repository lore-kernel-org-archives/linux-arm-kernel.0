From: daniel@iogearbox.net (Daniel Borkmann)
Date: Mon, 25 Jun 2018 10:48:23 +0200
Subject: Crash in netlink/sk_filter_trim_cap on ARMv7 on 4.18rc1
In-Reply-To: <CALeDE9Nkz+cbueruiez_43ZS1ebAiQHDaVZRARE8raypYz323A@mail.gmail.com>
References: <CALeDE9PP__kPHX_aW24kwzGf9BgA0gQOQJSY+Qw0yFMOLn4Pcw@mail.gmail.com>
 <7ff516fd-1d01-4d7a-1d5d-b58932c0c69d@gmail.com>
 <CALeDE9Nkz+cbueruiez_43ZS1ebAiQHDaVZRARE8raypYz323A@mail.gmail.com>
Message-ID: <04192986-0f46-f7a1-7f3f-86849aa73f1e@iogearbox.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/24/2018 11:24 AM, Peter Robinson wrote:
>>> I'm seeing this netlink/sk_filter_trim_cap crash on ARMv7 across quite
>>> a few ARMv7 platforms on Fedora with 4.18rc1. I've tested RPi2/RPi3
>>> (doesn't happen on aarch64), AllWinner H3, BeagleBone and a few
>>> others, both LPAE/normal kernels.
>>>
>>> I'm a bit out of my depth in this part of the kernel but I'm wondering
>>> if it's known, I couldn't find anything that looked obvious on a few
>>> mailing lists.
>>>
>>> Peter
>>
>> Hi Peter
>>
>> Could you provide symbolic information ?
> 
> I passed in through scripts/decode_stacktrace.sh is that what you were after:
> 
> [    8.673880] Internal error: Oops: a06 [#10] SMP ARM
> [    8.673949] ---[ end trace 049df4786ea3140a ]---
> [    8.678754] Modules linked in:
> [    8.678766] CPU: 1 PID: 206 Comm: systemd-udevd Tainted: G      D
>         4.18.0-0.rc1.git0.1.fc29.armv7hl+lpae #1
> [    8.678769] Hardware name: Allwinner sun8i Family
> [    8.678781] PC is at sk_filter_trim_cap ()
> [    8.678790] LR is at   (null)
> [    8.709463] pc : lr : psr: 60000013 ()
> [    8.715722] sp : c996bd60  ip : 00000000  fp : 00000000
> [    8.720939] r10: ee79dc00  r9 : c12c9f80  r8 : 00000000
> [    8.726157] r7 : 00000000  r6 : 00000001  r5 : f1648000  r4 : 00000000
> [    8.732674] r3 : 00000007  r2 : 00000000  r1 : 00000000  r0 : 00000000
> [    8.739193] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
> [    8.746318] Control: 30c5387d  Table: 6e7bc880  DAC: ffe75ece
> [    8.752055] Process systemd-udevd (pid: 206, stack limit = 0x(ptrval))
> [    8.758574] Stack: (0xc996bd60 to 0xc996c000)
[...]

Should be fixed by (PR to Linus with fix is pending):

https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git/commit/?id=9262478220eac908ae6e168c3df2c453c87e2da3

Sorry for that,
Daniel
