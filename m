From: siddhesh@gotplt.org (Siddhesh Poyarekar)
Date: Mon, 6 Aug 2018 16:49:25 +0530
Subject: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <alpine.LRH.2.02.1808060626060.2986@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1mWkjuwVnjw6OWWUM=UcP76bdFa680FebCseewHfx3NpA@mail.gmail.com>
 <9acdacdb-3bd5-b71a-3003-e48132ee1371@redhat.com>
 <CAJA7tRZbmnZq7RfvQeYEy_a1ZObWqpFpVdvgsXgsioQ3RyPMuA@mail.gmail.com>
 <CAKv+Gu97QvwoLLK_zueiA_gjg_4Q5cqU4YVUyHUVFFfffdyJaw@mail.gmail.com>
 <11f9185a-7f71-83df-3a57-0a0ae9c1f934@arm.com>
 <alpine.LRH.2.02.1808032046540.24748@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1=6F-fGLmXE0VqQHTqTCUKUT=Fz29mMT7349SPFisbZ9A@mail.gmail.com>
 <alpine.LRH.2.02.1808040611070.23762@file01.intranet.prod.int.rdu2.redhat.com>
 <fd2cae87-b2df-d8ef-8836-e6cbf8c5f851@redhat.com>
 <alpine.LRH.2.02.1808060325110.3756@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu_y6La77sWOSROrwfRy65jrFVYVvRZt+ewNheYhdhHCkQ@mail.gmail.com>
 <alpine.LRH.2.02.1808060626060.2986@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <df77857e-1674-38ea-2337-366182afb41e@gotplt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/06/2018 04:01 PM, Mikulas Patocka wrote:
> I think there are three possible solutions:
> 
> 1. provide an alternative memcpy implementation that doesn't do unaligned
> accesses and recompile the graphics software with -mstrict-align

Given that there's already a tunable glibc.cpu.cached_memopt for powerpc 
that (as Tulio clarified elsewhere) essentially does the same thing for 
cache-inhibited memory, it wouldn't be too much of an overhead to put in 
another ifunc implementation that gets chosen only when one sets this 
tunable.  In fact, we could reuse the C string routines for this to 
avoid adding yet another assembly implementation to have to support. 
That way we can minimally fix the issue at hand without regressing 
existing uses.

You can then set the glibc.cpu.cached_memopt tunable in the default 
environment for your board[1] or for applications that need it (e.g. 
whenever DISPLAY is exported or something like that).

The only difference from Power would be that cpu.noncached==0 for Power 
by default whereas for aarch64 it will be the other way around.  It 
shouldn't be too hard to enhance the framework to set platform-specific 
defaults.

Siddhesh

[1] Or if you're feeling particularly generous, help us implement 
systemwide tunables since you have an actual use case for it :)
