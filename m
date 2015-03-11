From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 11 Mar 2015 13:44:57 +0100
Subject: [PATCH] n_tty: use kmalloc() instead of vmalloc() to avoid crash
 on armada-xp
In-Reply-To: <54FF21BE.2040506@list.ru>
References: <54FF21BE.2040506@list.ru>
Message-ID: <550038C9.7010807@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stas,

On 10/03/2015 17:54, Stas Sergeev wrote:
> Hello, the patch below is needed for a successful boot on armada-xp.
> 

I am really surprised by this patch because I used the Armada XP based
board in a daily base and I never saw this issue.

Could you provide your .config?

Also could you confirm that you use the dts from arch/arm/boot/dts
wihtout any change?


Thanks,

Gregory


> -=-=-=-=-=-=-=-=-=# Don't remove this line #=-=-=-=-=-=-=-=-=-
> This fixes the following crash at boot:
> 
>  Unhandled fault: external abort on non-linefetch (0x808) at 0xf00ca018
>  Internal error: : 808 [#1] SMP ARM
> 
>  CPU: 2 PID: 1 Comm: swapper/0 Not tainted 4.0.0-rc1 #3
>  Hardware name: Marvell Armada 370/XP (Device Tree)
>  task: ed41e800 ti: ed43e000 task.ti: ed43e000
>  PC is at _set_bit+0x28/0x50
>  LR is at n_tty_set_termios+0x328/0x358
>  pc : [<c01bc858>]    lr : [<c0207314>]    psr: 40000113
>  sp : ed43fd00  ip : 00000000  fp : 00000000
>  r10: 00000002  r9 : 00000000  r8 : ec930200
>  r7 : 00000000  r6 : f00ca018  r5 : f00ca000  r4 : ed69cc00
>  r3 : 00002000  r2 : 00002000  r1 : f00ca018  r0 : 00000000
>  Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
>  Control: 10c5387d  Table: 0000406a  DAC: 00000015
>  Process swapper/0 (pid: 1, stack limit = 0xed43e220)
> 
> The offending instruction in _set_bit() is "strex r0, r2, [r1]"
> For some reason the exclusive access instructions do not like the
> vmalloc() space... While there may be another fix to make them
> fine about vmalloc() space, it still looks like a good idea to
> use kmalloc() for allocating a small (sub-page) struct.
> 
> Signed-off-by: Stas Sergeev <stsp@users.sourceforge.net>
> ---
>  drivers/tty/n_tty.c |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
> index cf6e0f2..e03622e 100644
> --- a/drivers/tty/n_tty.c
> +++ b/drivers/tty/n_tty.c
> @@ -50,7 +50,6 @@
>  #include <linux/uaccess.h>
>  #include <linux/module.h>
>  #include <linux/ratelimit.h>
> -#include <linux/vmalloc.h>
>  
>  
>  /* number of characters left in xmit buffer before select has we have
> room */
> @@ -1892,7 +1891,7 @@ static void n_tty_close(struct tty_struct *tty)
>      if (tty->link)
>          n_tty_packet_mode_flush(tty);
>  
> -    vfree(ldata);
> +    kfree(ldata);
>      tty->disc_data = NULL;
>  }
>  
> @@ -1911,7 +1910,7 @@ static int n_tty_open(struct tty_struct *tty)
>      struct n_tty_data *ldata;
>  
>      /* Currently a malloc failure here can panic */
> -    ldata = vmalloc(sizeof(*ldata));
> +    ldata = kmalloc(sizeof(*ldata), GFP_KERNEL);
>      if (!ldata)
>          goto err;
>  
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
