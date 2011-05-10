From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Tue, 10 May 2011 11:47:02 +0530
Subject: [PATCH v4 08/11] tty: add pruss SUART driver
In-Reply-To: <20110509145534.2677dfa1@lxorguk.ukuu.org.uk>
References: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com><1303474109-6212-9-git-send-email-subhasish@mistralsolutions.com><034A6447E0D54737B5CEE009A4D20B37@subhasishg><20110509144610.6b4f7090@lxorguk.ukuu.org.uk><3A9C5CD56396439DBF825BB4E5779DB9@subhasishg>
	<20110509145534.2677dfa1@lxorguk.ukuu.org.uk>
Message-ID: <F0818DA1343E4FF1B3096048359CCC4C@subhasishg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alan,

>> >> I then modified this function to as follows and the error is not 
>> >> observed
>> >> anymore.
>> >
>> > That looks like you are somehow calling uart_carrier_raised somewhere
>> > with interrupts disabled ?
>> >
>> I am not calling this function in my driver atall, this is getting called 
>> by
>> tty_port.c
>
> Can you verify the status of the interrupt flags at the point that
> routine is called in your code and get a backtrace of the path. It
> should never be gettng called with interrupts off, and if it is we need
> to know what the path is. Otherwise that code change would imply a bug
> in the core code for the platform which seems less likely.

Here is the back trace:

root at arago:~# ------------[ cut here ]------------
WARNING: at drivers/tty/serial/pruss_suart.c:295 
uart_carrier_raised+0x2c/0x74()
Modules linked in: pruss_uart
[<c002e888>] (unwind_backtrace+0x0/0xec) from [<c003e400>] 
(warn_slowpath_common+0x4c/0x64)
[<c003e400>] (warn_slowpath_common+0x4c/0x64) from [<c003e430>] 
(warn_slowpath_null+0x18/0x1c)
[<c003e430>] (warn_slowpath_null+0x18/0x1c) from [<c0190744>] 
(uart_carrier_raised+0x2c/0x74)
[<c0190744>] (uart_carrier_raised+0x2c/0x74) from [<c0182b84>] 
(tty_port_carrier_raised+0x1c/0x20)
[<c0182b84>] (tty_port_carrier_raised+0x1c/0x20) from [<c0183174>] 
(tty_port_block_til_ready+0x254/0x328)
[<c0183174>] (tty_port_block_til_ready+0x254/0x328) from [<c017d3ac>] 
(tty_open+0x310/0x478)
[<c017d3ac>] (tty_open+0x310/0x478) from [<c009f5d8>] 
(chrdev_open+0x1b4/0x1d0)
[<c009f5d8>] (chrdev_open+0x1b4/0x1d0) from [<c009ae34>] 
(__dentry_open+0x170/0x27c)
[<c009ae34>] (__dentry_open+0x170/0x27c) from [<c009b008>] 
(nameidata_to_filp+0x50/0x5c)
[<c009b008>] (nameidata_to_filp+0x50/0x5c) from [<c00a70e0>] 
(finish_open+0x90/0x17c)
[<c00a70e0>] (finish_open+0x90/0x17c) from [<c00a8fa4>] 
(do_filp_open+0x23c/0x520)
[<c00a8fa4>] (do_filp_open+0x23c/0x520) from [<c009ac0c>] 
(do_sys_open+0x58/0xe4)
[<c009ac0c>] (do_sys_open+0x58/0xe4) from [<c0029fa0>] 
(ret_fast_syscall+0x0/0x2c)

flags ---> 0xA0000013


This is how I generated the trace:

static void pruss_suart_enable_ms(struct uart_port *port)
{
        struct omapl_pru_suart *soft_uart =
            container_of(port, struct omapl_pru_suart, port[port->line]);
        struct device *dev = soft_uart->dev;

        WARN_ON(1);
        dev_dbg(dev, "modem control timer not supported\n");
} 
