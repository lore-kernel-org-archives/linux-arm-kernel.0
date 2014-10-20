From: khilman@kernel.org (Kevin Hilman)
Date: Mon, 20 Oct 2014 14:07:45 -0700
Subject: [RESEND/PATCH] i2c: pxa: Use suspend() and resume() instead of
 the _noirq hooks
In-Reply-To: <1413829432-7815-1-git-send-email-ezequiel@vanguardiasur.com.ar>
 (Ezequiel Garcia's message of "Mon, 20 Oct 2014 15:23:52 -0300")
References: <1413829432-7815-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Message-ID: <7hzjcqe9ge.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ezequiel Garcia <ezequiel@vanguardiasur.com.ar> writes:

> The _noirq were previously chosen to make sure all the users of the
> adapter were suspended by the time the adapter itself enters the
> suspended state.
>
> The {suspend,resume}_noirq usage was converted from an earlier
> implementation based on suspend_late and resume_early on this commit:
>
> commit 57f4d4f1b72983f8c76e2f232e064730aeffe599
> Author: Magnus Damm <damm@igel.co.jp>
> Date:   Wed Jul 8 13:22:39 2009 +0200
>
>     I2C: Rework i2c-pxa suspend_late()/resume_early()
>
> However, all the I2C devices are probed as children of its I2C adapter,
> and hence the device model guarantees they are suspended before its parent, and
> resumed after it.
>
> In other words, there's no need to use the _noirq hooks to get a suspend/resume
> device/adapter order.

Are you sure *really* about this?

It's usally not the children that are the problem here.  It's usually
some other driver trying to use an I2C device e.g. MMC changing voltage
using an I2C-based PMIC during its suspend process.

Kevin
