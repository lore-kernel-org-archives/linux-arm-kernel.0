From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Jun 2010 18:54:03 +0100
Subject: incorrect panic("failed to get clock for system timer"); ??
In-Reply-To: <4C0539E4.9090501@gmail.com>
References: <4C0539E4.9090501@gmail.com>
Message-ID: <20100601175403.GA6644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 01, 2010 at 12:48:36PM -0400, f. achkar wrote:
> Hi,
> Newbie debugging Linux-2.6.32-9 on S3C2450, the kernel seems to panic at :
> s3c2410_timer_init () at arch/arm/plat-s3c/time.c:256
> 
> if (IS_ERR(timerclk))
>         panic("failed to get clock for system timer");
> 
> more precisely  'if (IS_ERR(timerclk))' is non-null !?! although the
> 'timerclk' seem to be fine:
> (gdb) print *timerclk
> $27 = {list = {next = 0xc04a933c, prev = 0xc04a93ac}, owner = 0x0,
> parent = 0xc04abfd4, name = 0xc042c5a1 "timers", id = -1,
>   usage = 0, rate = 0, ctrlbit = 1024, enable = 0xc009631c
> <s3c2443_clkcon_enable_p>, set_rate = 0, get_rate = 0,
>   round_rate = 0, set_parent = 0}
> (gdb) s
> 257            panic("failed to get clock for system timer");
> (gdb) print (unsigned long)(timerclk)
> $28 = 3226112884
> (gdb)
> 
> I'm not sure why 'IS_ERR(timerclk)' is holding true? or is it a bug ?
> thanks,

Looks to me like a compiler bug.  Your timerclk is 0xC04A9374, which
certainly isn't a value which IS_ERR() should return true for.
