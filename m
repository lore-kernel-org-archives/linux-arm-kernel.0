From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 25 Oct 2012 18:31:58 +0530
Subject: [PATCH v2 5/7] i2c: omap: wait for transfer completion before
 sending STP bit
In-Reply-To: <1351167915-15079-6-git-send-email-balbi@ti.com>
References: <1350899218-13624-1-git-send-email-balbi@ti.com>
 <1351167915-15079-1-git-send-email-balbi@ti.com>
 <1351167915-15079-6-git-send-email-balbi@ti.com>
Message-ID: <50893846.3020106@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 25 October 2012 05:55 PM, Felipe Balbi wrote:
> Later patches will come adding support for
> reporting amount of bytes transferred so that
> client drivers can count how many bytes are
> left to transfer.
>
> This is useful mostly in case of NACKs when
> client driver wants to know exactly which
> byte got NACKed so it doesn't have to resend
> all bytes again.
>
> In order to make that work with OMAP's I2C
> controller, we need to prevent sending STP
> bit until message is transferred. The reason
> behind that is because OMAP_I2C_CNT_REG gets
> reset to original value after STP bit is
> shifted through I2C_SDA line and that would
> prevent us from reading the correct number of
> bytes left to transfer.
>
> The full programming model suggested by IP
> owner was the following:
>
> - start I2C transfer (without STP bit)
> - upon completion or NACK, read I2C_CNT register
> - write STP bit to I2C_CON register
> - wait for ARDY bit
>
> With this patch we're implementing all steps
> except step #2 which will come in a later
> patch adding such support.
>
Will this not break the bisect since CNT and
NACK, completion is added in later patch

> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
Apart from above, rest of the change follow
the change log and looks fine tome. The
change is quite drastic so hopefully it
has gone through wider testing.

Regards
santosh
