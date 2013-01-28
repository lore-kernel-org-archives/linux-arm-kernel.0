From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 28 Jan 2013 12:50:23 +0000
Subject: [PATCH 19/19] [INCOMPLETE] ARM: make return_address available
 for ARM_UNWIND
In-Reply-To: <CA+KhAHYJus7+LsVhNa4RcxfpeTBtV=_vf2YDACtoMujo5c6tXA@mail.gmail.com>
References: <1359123276-15833-1-git-send-email-arnd@arndb.de>
 <1359132254.21576.230.camel@gandalf.local.home>
 <20130125165934.GE2069@linaro.org>
 <201301260045.28804.arnd@arndb.de>
 <CA+KhAHYJus7+LsVhNa4RcxfpeTBtV=_vf2YDACtoMujo5c6tXA@mail.gmail.com>
Message-ID: <20130128125023.GA2027@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 28, 2013 at 11:33:11AM +0900, Keun-O Park wrote:
> Hello guys,
> 
> Could you please review the patch of fixing bug first of returning
> wrong address when using frame pointer?
> I am wondering if the first patch is not delivered to the mailing.

I posted a similar patch to alkml a couple of months ago, but I got
no response and it looks like I forgot about it.

http://lists.infradead.org/pipermail/linux-arm-kernel/2012-November/129381.html

[...]

> 
> ~~~~~~~~~~~~~~~~~~~~~snip~~~~~~~~~~~~~~~~~~~~~~~~~
> From 3a60b536d22a2043d735c890a9aac9e7cb72de8f Mon Sep 17 00:00:00 2001
> From: sahara <keun-o.park@windriver.com>
> Date: Thu, 3 Jan 2013 17:12:37 +0900
> Subject: [PATCH 1/2] arm: fix returning wrong CALLER_ADDRx
> 
> This makes return_address return correct value for ftrace feature.
> unwind_frame does not update frame->lr but frame->pc for backtrace.
> And, the initialization for data.addr was missing so that wrong value
> returned when unwind_frame failed.
> 
> Signed-off-by: sahara <keun-o.park@windriver.com>
> ---
>  arch/arm/kernel/return_address.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/kernel/return_address.c b/arch/arm/kernel/return_address.c
> index 8085417..fafedd8 100644
> --- a/arch/arm/kernel/return_address.c
> +++ b/arch/arm/kernel/return_address.c
> @@ -26,7 +26,7 @@ static int save_return_addr(struct stackframe *frame, void *d)
>         struct return_address_data *data = d;
> 
>         if (!data->level) {
> -               data->addr = (void *)frame->lr;
> +               data->addr = (void *)frame->pc;
> 
>                 return 1;
>         } else {
> @@ -41,7 +41,8 @@ void *return_address(unsigned int level)
>         struct stackframe frame;
>         register unsigned long current_sp asm ("sp");
> 
> -       data.level = level + 1;
> +       data.level = level + 2;
> +       data.addr = NULL;

Can you explain why this is needed?  I think I concluded it wasn't
necessary, but you may be right -- I think if walk_stackframe()
fails to unwind the next frame just after data.level reaches zero,
then data.addr can remain unset and return_address() may return
uninitialised garbage.

Initialising data.addr to NULL before we start seems a good way
to avoid that.

Cheers
---Dave
