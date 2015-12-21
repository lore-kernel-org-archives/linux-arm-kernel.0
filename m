From: will.deacon@arm.com (Will Deacon)
Date: Mon, 21 Dec 2015 14:01:04 +0000
Subject: [BUG REPORT]: ARM64: perf: System hung in perf test
In-Reply-To: <5677F6E3.9050902@huawei.com>
References: <5677F6E3.9050902@huawei.com>
Message-ID: <20151221140104.GQ23092@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 21, 2015 at 08:56:03PM +0800, Wangnan (F) wrote:
> System hung can be reproduced on qemu and real hardware using:
> 
>  # perf test -v signal
> 
> If qemu is started with '-smp 1', system hung. In real hardware and in
> qemu with smp > 1, the result is:

That sounds like a qemu issue...

>  # /perf test -v signal
>  17: Test breakpoint overflow signal handler                  :
>  --- start ---
>  test child forked, pid 792
>  count1 11, count2 11, overflow 11
>  failed: RF EFLAG recursion issue detected
>  failed: wrong overflow hit
>  failed: wrong count for bp2
>  test child finished with -1
>  ---- end ----
>  Test breakpoint overflow signal handler: FAILED!

... and this sounds like the perf tool expecting to single-step over
signal handlers, whereas (on arm64) we deliberately single-step into
them, so you can run into a loop for this case.

Will
