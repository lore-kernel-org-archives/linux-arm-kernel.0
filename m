From: robherring2@gmail.com (Rob Herring)
Date: Thu, 7 Nov 2013 19:34:13 -0600
Subject: [PATCH] ARM: Use udiv/sdiv for __aeabi_{u}idiv library functions
In-Reply-To: <1383852042-10780-1-git-send-email-sboyd@codeaurora.org>
References: <1383852042-10780-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <CAL_JsqJ9zbJFJePk2FHH8UhrUP2J7fuuiZLb+NhuTovRodqrCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 7, 2013 at 1:20 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> If we're running on a v7 ARM CPU, detect if the CPU supports the
> sdiv/udiv instructions and replace the signed and unsigned
> division library functions with an sdiv/udiv instruction.

[snip]

> diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
> index bd454b0..6ed6496 100644
> --- a/arch/arm/lib/Makefile
> +++ b/arch/arm/lib/Makefile
> @@ -15,6 +15,9 @@ lib-y         := backtrace.o changebit.o csumipv6.o csumpartial.o   \
>                    io-readsb.o io-writesb.o io-readsl.o io-writesl.o  \
>                    call_with_stack.o
>
> +lib-$(CONFIG_CPU_V7) += div-v7.o
> +CFLAGS_div-v7.o := -march=armv7-a

Won't this fail to build if the compiler doesn't have armv7-a support.
Perhaps we don't care about compilers that old.

Rob
