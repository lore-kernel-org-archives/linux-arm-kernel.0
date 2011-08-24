From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 24 Aug 2011 13:59:40 +0200
Subject: [PATCH 2/3] mach-ux500: initialize l2x0 at arch_init time
In-Reply-To: <CAH9JG2W+KkTZJ67eDqju3jQfc8OZhf0gBzKvhSodpOQS=-q2kQ@mail.gmail.com>
References: <1314177826-19151-1-git-send-email-linus.walleij@stericsson.com>
	<4E54CAE8.1060702@ti.com>
	<CAH9JG2W+KkTZJ67eDqju3jQfc8OZhf0gBzKvhSodpOQS=-q2kQ@mail.gmail.com>
Message-ID: <CACRpkdZWwwapspVFrZNC8ReURrKVYFUDzdmEL7HiZWOjZ907jQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2011 at 12:12 PM, Kyungmin Park <kmpark@infradead.org> wrote:
> On Wed, Aug 24, 2011 at 6:56 PM, Santosh <santosh.shilimkar@ti.com> wrote:
>> On Wednesday 24 August 2011 02:53 PM, Linus Walleij wrote:
>>
>> More and more you delay L2 cache enable in boot-process,
>> your boot-up time is going to shoot-up.
>>
>> Have you thought about it. Cache's should be enabled as
>> early as possible.
>
> Right, after change from early_init to arch_init. it takes more time.

Hm no good. I'll drop this.

We've seen that if we try to unlock the I&D l2x0 at the
early_initcall() as in [3/3] it will sometimes fail, like it's
still locked down afterwards. Calling it from .init_machine()
appears to work. So in my dumbness I moved it to
arch_initcall() which should be equivalent. Does anyone
have some subtle hint or experience on how to get around
that one issue, or should I just put in a second
arch_initcall() for just the unlocking?

Sascha, I guess Freescale should also move the l2x0 init to
early_init() in mach-imx/cache-l2x0.c if possible. Can
you try the below on your machine(s)?

diff --git a/arch/arm/mach-imx/cache-l2x0.c b/arch/arm/mach-imx/cache-l2x0.c
index 69d1322..e5538a4 100644
--- a/arch/arm/mach-imx/cache-l2x0.c
+++ b/arch/arm/mach-imx/cache-l2x0.c
@@ -53,4 +53,4 @@ static int mxc_init_l2x0(void)

        return 0;
 }
-arch_initcall(mxc_init_l2x0);
+early_initcall(mxc_init_l2x0);

Yours,
Linus Walleij
