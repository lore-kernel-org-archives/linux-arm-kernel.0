From: will.deacon@arm.com (Will Deacon)
Date: Mon, 5 Oct 2015 13:32:42 +0100
Subject: [PATCH] arm: perf: Fix userspace call stack walking
In-Reply-To: <20151001172643.GA23147@dreric01-gentoo.localdomain>
References: <20151001172643.GA23147@dreric01-gentoo.localdomain>
Message-ID: <20151005123242.GB8818@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Drew,

On Thu, Oct 01, 2015 at 06:26:47PM +0100, Drew Richardson wrote:
> I got some undeliverable responses the first time, sorry if you get this twice
> 
> ---
> 
> The layout of stack frames has changed over time. Testing using a
> arm-linux-gnueabi gcc-4.2 from 2007 the original code didn't work but
> this new code does. It also works with clang as well as newer versions
> of gcc.
> 
> gcc has this layout for it's stackframes
> 
> caller_fp
> caller_lr <- fp
> 
> However clang has this layout
> 
> caller_fp <- fp
> caller_lr

Do you have any buy-in from the toolchain people that this won't continue
to change over time? Adding more and more heuristics to walk the stack of
binaries compiled using GCC x.y doesn't really scale...

> Since the layouts are not compatible use a heuristic to determine for
> each stack frame which layout is used.
> 
> Signed-off-by: Drew Richardson <drew.richardson@arm.com>
> ---
>  arch/arm/kernel/perf_callchain.c | 86 +++++++++++++++++++++++++++++++++++-----
>  1 file changed, 76 insertions(+), 10 deletions(-)

Please can you update the compat stack walker in
arch/arm64/kernel/perf_callchain.c too?

Will
