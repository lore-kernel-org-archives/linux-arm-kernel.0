From: xuwei5@hisilicon.com (Wei Xu)
Date: Tue, 30 Jan 2018 10:18:36 +0000
Subject: [RFC PATCH] tty: pl011: Avoid stuck-off spurious interrupts
In-Reply-To: <20180130092502.GD5862@e103592.cambridge.arm.com>
References: <1517242181-20652-1-git-send-email-Dave.Martin@arm.com>
 <5A6F5EDB.20405@hisilicon.com>
 <20180130092502.GD5862@e103592.cambridge.arm.com>
Message-ID: <5A70467C.3020009@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

On 2018/1/30 9:25, Dave Martin wrote:
> On Mon, Jan 29, 2018 at 05:50:19PM +0000, Wei Xu wrote:
>> Hi Dave,
>>
>> On 2018/1/29 16:09, Dave Martin wrote:
>>> Commit 9b96fbacda34 ("serial: PL011: clear pending interrupts")
>>> clears the RX and receive timeout interrupts on pl011 startup, to
>>> avoid a screaming-interrupt scenario that can occur when the
>>> firmware or bootloader leaves these interrupts spuriously
>>> asserted.
>>>
>>> This has been noted as an issue when running Linux on qemu [1].
>>>
>>> Unfortunately, the above fix seems to lead to potential
>>> misbehaviour if the RX FIFO interrupt is asserted _non_ spuriously
>>> on driver startup, if the RX FIFO is also already full to the
>>> trigger level.
>>>
>>> Clearing the RX FIFO interrupt does not change the FIFO fill level.
>>> In this scenario, because the interrupt is now clear and because
>>> the FIFO is already full to the trigger level, no new assertion of
>>> the RX FIFO interrupt can occur unless the FIFO is drained back
>>> below the trigger level.  This never occurs because the pl011
>>> driver is waiting for an RX FIFO interrupt to tell it that there is
>>> something to read, and does not read the FIFO at all until that
>>> interrupt occurs.
>>>
>>> Thus, simply clearing "spurious" interrupts on startup may be
>>> misguided, since there is no way to be sure that the interrupts are
>>> truly spurious, and things can go wrong if they are not.
>>>
>>> This patch attempts to handle (suspected) spurious interrupts more
>>> robustly, by allowing the interrupt(s) to fire but quenching the
>>> scream.
>>>
>>> pl011_int() runs and attempts to drain the FIFO anyway just as if
>>> the interrupts were real.  If the FIFO is already empty, great.  To
>>> avoid a screaming spurious interrupt, the RX FIFO and timeout
>>> interrupts are now explicitly cleared in between committing to
>>> drain the RX FIFO and actually draining it.  We do not have to
>>> worry about lost interrupts here, because we are effectively in
>>> polled mode inside pl011_int() until the RX FIFO becomes empty:
>>>
>>>   * A new char received before the RX FIFO is fully drained will be
>>>     drained out synchronously by pl011_int() along with the other
>>>     chars already pending.  A new char received after the RX FIFO
>>>     is drained will result in correct RX FIFO interrupt assertion,
>>>     because emptying the RX FIFO guarantees that the RX FIFO /
>>>     timeout interrupt state machines are back in a sane state.
>>>
>>>   * A new RX timeout before the RX FIFO is fully drained is no
>>>     problem, because pl011_int() has already committed to emptying
>>>     the FIFO at this point, guaranteeing that no stray chars will
>>>     be left behind.  A new RX timeout after the RX FIFO is fully
>>>     drained will result in correct interrupt assertion.
>>>
>>> This patch does not attempt to address the case where the RX FIFO
>>> fills faster than it can be drained: that is a pathological
>>> condition that is beyond the scope of the driver to work around.
>>> Users cannot expect this to work unless they enable hardware flow
>>> control.
>>>
>>> [1] [Qemu-devel] [Qemu-arm] [PATCH] pl011: do not put into fifo
>>> before enabled the interruption
>>> https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg06446.html
>>>
>>> Reported-by: Wei Xu <xuwei5@hisilicon.com>
>>> Cc: Russell King <linux@armlinux.org.uk>
>>> Cc: Linus Walleij <linus.walleij@linaro.org>
>>> Cc: Peter Maydell <peter.maydell@linaro.org>
>>> Fixes: 9b96fbacda34 ("serial: PL011: clear pending interrupts")
>>> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
>>> ---
>>>  drivers/tty/serial/amba-pl011.c | 6 +-----
>>>  1 file changed, 1 insertion(+), 5 deletions(-)
>>>
>>
>> After commented the 1549 line in the amba-pl011.c[1] and applied this patch,
>> the console is not hanged any more.
>>
>> The UART011_ICR is cleared in the pl011_hwinit that will clear the
>> RX interruption as well.
>> Is it OK to remove 1549 as well?
>> Thanks!
> 
> Hmm, that probably does make sense: I was looking only at the
> pl011_startup() path, but the clearing of interrupts in pl011_hwinit()
> appears like it can lead to the same problem, as you say.
> 
> So I think that it makes sense to remove RTIS and RXIS from the status
> bit clearing on line 1550.  To avoid accidentally breaking any existing
> behaviour, it may be safer to leave the other interrupts alone.
> 
> So does the following work?

Yes, it works with below patch.

> 
> (Note, have you tried to reproduce the bug and test the fix on mainline?
> The amba-pl011 driver in v4.4 looks a little different here.)

I can reproduce it with 4.15-rc9 Kernel and 2.11.0 QEMU without your patches.
And the issue is gone after applied your patches.
The log and commands are as below.

#The QEMU command is as:

	qemu-system-aarch64 -m 1024 -cpu host -M virt -nographic -kernel Image \
	-initrd rootfs.cpio.gz --enable-kvm \
	-device virtio-net-device,mac=9a:eb:ec:ed:ee:ef,id=idKUWkoN,netdev=idrOKidE \
	-netdev user,id=idrOKidE,hostfwd=tcp::5000-:22 \
	-append "ip=dhcp console=ttyAMA0 root=/dev/vda -m 4096 rw earlycon=pl011,0x9000000" 	

#The console is hung and the log of the console is as:

	root at ubuntu:~#
	> -device virtio-net-device,mac=9a:eb:ec:ed:ee:ef,id=idKUWkoN,netdev=idrOKidE \
	>  -netdev user,id=idrOKidE,hostfwd=tcp::5000-:22 \d=idKUWkoN,netdev=idrOKidE  \
	0000" end "ip=dhcp console=ttyAMA0 root=/dev/vda -m 4096 rw earlycon=pl011,0x900
	[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd082]
	[    0.000000] Linux version 4.15.0-rc9 (xuwei at EstBuildSvr1) (gcc version 4.9.2 20140904 (prerelease) (crosstool-NG linaro-1.13.1-4.9-2014.09 - Linaro GCC 4.9-2014.09)) #176 SMP PREEMPT Tue Jan 30 18:00:2
	6 CST 2018

	......

	[    1.733403] ALSA device list:
	[    1.734046]   No soundcards found.
	[    1.734901] uart-pl011 9000000.pl011: no DMA platform data
	[    1.737619] Freeing unused kernel memory: 1600K
	Starting rcS...
	++ Mounting filesystem
	++ Setting up mdev
	++ Starting telnet daemon
	++ Starting http daemon
	++ Starting ftp daemon
	++ Starting dropbear (ssh) daemon
	rcS Complete
	Welcome to Mini Linux
	GNU/Linux 4.15.0-rc9 aarch64
	estuary:/$

#And you can found that there is no pl011 interruption any more
and the the log from the ssh console is as:

	estuary:~$ cat /proc/interrupts
			   CPU0
	  3:        331     GIC-0  27 Level     arch_timer
	 36:         47     GIC-0  79 Edge      virtio0
	 38:          0     GIC-0  34 Level     rtc-pl031
	 39:          0     GIC-0  33 Level     uart-pl011
	 40:          0     GIC-0  23 Level     arm-pmu
	 41:          0     pl061   3 Edge      GPIO Key Poweroff
	IPI0:         0       Rescheduling interrupts
	IPI1:         0       Function call interrupts
	IPI2:         0       CPU stop interrupts
	IPI3:         0       CPU stop (for crash dump) interrupts
	IPI4:         0       Timer broadcast interrupts
	IPI5:         0       IRQ work interrupts
	IPI6:         0       CPU wake-up interrupts
	Err:          0
	estuary:~$ 	

Thank you so much!

Best Regards,
Wei

> 
> Cheers
> ---Dave
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index e7b5fc6..dd6c285 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -1672,9 +1672,8 @@ static int pl011_hwinit(struct uart_port *port)
>  
>  	uap->port.uartclk = clk_get_rate(uap->clk);
>  
> -	/* Clear pending error and receive interrupts */
> -	pl011_write(UART011_OEIS | UART011_BEIS | UART011_PEIS |
> -		    UART011_FEIS | UART011_RTIS | UART011_RXIS,
> +	/* Clear pending error interrupts */
> +	pl011_write(UART011_OEIS | UART011_BEIS | UART011_PEIS | UART011_FEIS,
>  		    uap, REG_ICR);
>  
>  	/*
> 
> [...]
> 
> .
> 
