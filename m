From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 10 Dec 2013 17:49:21 -0800
Subject: [PATCH v3 20/36] mtd: st_spi_fsm: Provide a method to put the
 chip into 32bit addressing mode
In-Reply-To: <1385727565-25794-21-git-send-email-lee.jones@linaro.org>
References: <1385727565-25794-1-git-send-email-lee.jones@linaro.org>
 <1385727565-25794-21-git-send-email-lee.jones@linaro.org>
Message-ID: <20131211014921.GK27149@ld-irv-0074.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 29, 2013 at 12:19:09PM +0000, Lee Jones wrote:
> --- a/drivers/mtd/devices/st_spi_fsm.c
> +++ b/drivers/mtd/devices/st_spi_fsm.c
> @@ -28,6 +28,8 @@
>  #include "st_spi_fsm.h"
>  #include "serial_flash_cmds.h"
>  
> +static struct stfsm_seq stfsm_seq_en_32bit_addr;/* Dynamically populated */

You need a space between the semicolon and the comment.

But why isn't this struct just embedded in the struct stfsm? I don't
like static instances like this, especially when they are dynamically
configured (as your comment notes). In the crazy even that we ever have
two of these FSMs on an SoC (can this happen?), you'll be introducing a
race on needlessly-shared data.

The same comment applies to your later structs stfsm_seq_read and
stfsm_seq_write.

Brian
