From: eric.miao@canonical.com (Eric Miao)
Date: Wed, 16 Jun 2010 11:16:43 +0800
Subject: [PATCH 02/10] arm/zImage: some comments for __armv3_mpu_cache_on
In-Reply-To: <1276165636-20150-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20100610102427.GC31057@pengutronix.de>
	<1276165636-20150-2-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <AANLkTiluJns87Cc7Xk4VA-_9nXMNuhfcR2Kwu0A0IevK@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/6/10 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> __armv3_mpu_cache_on seems broken. ?As there is noone around who knows
> about these machines just keep the code as is but point out the strange
> things.
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> ?arch/arm/boot/compressed/head.S | ? ?3 +++
> ?1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index 390aa92..384150b 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -396,12 +396,15 @@ __armv3_mpu_cache_on:
>
> ? ? ? ? ? ? ? ?mov ? ? r0, #0
> ? ? ? ? ? ? ? ?mcr ? ? p15, 0, r0, c7, c0, 0 ? @ invalidate whole cache v3
> + ? ? ? ? ? ? ? /* ?? ARMv3 MMU doesn not allow reading the control register, does this really work on ARMv3 MPU? */


>From bogus@does.not.exist.com  Sun Jun  6 12:36:48 2010
From: bogus@does.not.exist.com ()
Date: Sun, 06 Jun 2010 16:36:48 -0000
Subject: No subject
Message-ID: <mailman.1.1276658227.27306.linux-arm-kernel@lists.infradead.org>

http://en.wikipedia.org/wiki/ARM_architecture

ARM740T is actually V4T, and reading of control register should be OK.
Although I guess due to historic reason, it's using armv3_* prefix for
the functions?

> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mrc =C2=A0 =C2=A0 =
p15, 0, r0, c1, c0, 0 =C2=A0 @ read control reg
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0@ .... .... .... WC.M
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0orr =C2=A0 =C2=A0 =
r0, r0, #0x000d =C2=A0 =C2=A0 =C2=A0 =C2=A0 @ .... .... .... 11.1
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* ?? this overwrites =
the value constructed above? */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mov =C2=A0 =C2=A0 =
r0, #0

This does seem to be an error.

> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mcr =C2=A0 =C2=A0 =
p15, 0, r0, c1, c0, 0 =C2=A0 @ write control reg
>
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* ?? invalidate for t=
he second time? */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mcr =C2=A0 =C2=A0 =
p15, 0, r0, c7, c0, 0 =C2=A0 @ invalidate whole cache v3
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mov =C2=A0 =C2=A0 =
pc, lr
>
> --
> 1.7.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
