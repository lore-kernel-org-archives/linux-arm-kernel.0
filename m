From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 10 Jan 2014 10:34:20 +0100
Subject: [RFC PATCH] tty/serial: at91: disable uart timer at start of
 shutdown
In-Reply-To: <CAJjB1qJez363RAaNg1bzE3QTsaGDFfAqOJux=VttNXCyaQTy3A@mail.gmail.com>
References: <CAJjB1qLBoXA_XeEV+qU6pi0JVS+==kVA7mEDuAufrYup3htU2g@mail.gmail.com>
 <1389176916-6114-1-git-send-email-nicolas.ferre@atmel.com>
 <CAJjB1q+0cMqGRX8e5ssvvvo1pSw4KY7n38vWOh-PnE8GRC2Pug@mail.gmail.com>
 <CAJjB1qJez363RAaNg1bzE3QTsaGDFfAqOJux=VttNXCyaQTy3A@mail.gmail.com>
Message-ID: <52CFBE9C.8080204@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/01/2014 08:08, Mark Roszko :
> Just to sumarize the bug after poking before the patch:
>    systemd calls open/close on /dev/ttyS0 per line
>    atmel_shutdown executes on close
>    uart_timer_callback may fire during shutdown before timer is killed
>    tasklet gets scheduled after tasklet_kill
>    atmel_shutdown returns back to uart_close
> dice roll:
>    if the tasklet executes before uart_close kills the tty references,
> the kernel is fine           <--- I saw this happening more often than
> panics, around once every 3 resets
>    if the tasklet executes after uart_close kills the tty references, it panics
> 
> I tested the patch by old fashion way of manual board resets with a
> total of 70 resets each on two individual SAMA5D34-EK boards I have in
> my possession programmed with the same patched kernel image and
> rootfs. They did not panic once with the patch applied. Typically
> before the patch the panic would occur around once every 10 resets if
> not more often to the point it occured for 4 resets straight.
> 
> I have been trying to automate the testing, even If I make sure
> nothing is using ttyS0 and then run a program that spams open()
> writev() and close() (systemd uses the syscalls) to print messages, it
> will never panic so I'm possibly misunderstanding how the driver
> startup/shutdown ops get triggered(which should just be open/close
> respectively) or variable length of messages from systemd and timing
> between messages contributes to being unlucky and having the timer
> fire at the wrong time.
> 
> But from manual testing I'm pretty confident the bug is fixed.

Nice, thanks for the detailed feedback.

So I send the patch for inclusion to Greg.

Thanks for your help Mark. Best regards,
-- 
Nicolas Ferre
