From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Wed, 15 Jun 2016 01:26:23 +0200
Subject: [PATCH] PM / Hibernate: Don't let kasan instrument snapshot.c
In-Reply-To: <1464870032-12289-1-git-send-email-james.morse@arm.com>
References: <1464870032-12289-1-git-send-email-james.morse@arm.com>
Message-ID: <7230305.BYjCFel4WC@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, June 02, 2016 01:20:32 PM James Morse wrote:
> Kasan causes the compiler to instrument C code and is used at runtime to
> detect accesses to memory that has been freed, or not yet allocated.
> 
> The code in snapshot.c saves and restores memory when hibernating. This will
> access whole pages in the slab cache that have both free and allocated
> areas, resulting in a large number of false positives from Kasan.
> 
> Disable instrumentation of this file.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> ---
> With this, I can hibernate/resume a kernel built with kasan on arm64.
> 
>  kernel/power/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/power/Makefile b/kernel/power/Makefile
> index cb880a14cc39..eb4f717705ba 100644
> --- a/kernel/power/Makefile
> +++ b/kernel/power/Makefile
> @@ -1,6 +1,8 @@
>  
>  ccflags-$(CONFIG_PM_DEBUG)	:= -DDEBUG
>  
> +KASAN_SANITIZE_snapshot.o	:= n
> +
>  obj-y				+= qos.o
>  obj-$(CONFIG_PM)		+= main.o
>  obj-$(CONFIG_VT_CONSOLE_SLEEP)	+= console.o
> 

Applied, thanks!

Does the arch code need to be annotated in a similar way too?
