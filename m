From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 14 Jan 2010 11:24:32 +0000
Subject: pxa320: change uart configuration
In-Reply-To: <20100114115225.94334g603pqhe1d5@webmail.tu-cottbus.de>
References: <20100112183000.14575jy4enpsv6ag@webmail.tu-cottbus.de>
	<20100112173606.GF5633@n2100.arm.linux.org.uk>
	<20100114115225.94334g603pqhe1d5@webmail.tu-cottbus.de>
Message-ID: <20100114112432.GA21385@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 14, 2010 at 11:52:25AM +0100, Judith Baumgarten wrote:
> Zitat von Russell King - ARM Linux <linux@arm.linux.org.uk>:
>
>> On Tue, Jan 12, 2010 at 06:30:00PM +0100, Judith Baumgarten wrote:
>>> I want to change the uart configuration of the pxa serial ports in order
>>> to be able to connect to different devices. The problem is, that it jumps
>>> back to its initial configuration, when it receives some data. I used
>>> stty of busybox 1.14.3 as well as the termios-structure to change the
>>> configuration, but it always remained the same. I could protect some
>>> configurations by using the TIOCSLCKTRMIOS ioctl, but the baudrate still
>>> jumps back.
>>
>> Something will be changing it back.  A getty maybe?
>
> We have no getty on our system. Inittab contains just the following entries:
>
> ::sysinit:/etc/init.d/rcS
> ttyS0::respawn:-/bin/sh
> ttyS1::respawn:-/bin/sh
> tty1::respawn:-/bin/sh
> tty2::respawn:-/bin/sh
> ::ctrlaltdel:/bin/umount -a -r
>
> and a "ps ax | grep tty" has no result.

You have two shells - one on ttyS0 and one on ttyS1.  While these are
running on these ports, they will want to control the settings - so
if you try to make use of these two serial ports, you're going to
cause confusion.

Firstly, the shells will fight you with your termios settings.  Secondly,
any received characters will be delivered randomly between the shell and
your program - some characters will be seen by the shell, others will
be seen by your program.

This is just something you do not want to do.  If you want to control a
port, you need exclusive access to it - which means not starting any
other program on the port.  In the case of serial ports, there's a
locking mechanism for programs for serial ports (getty, uucp, minicom,
etc) which involves creating lock files - eg, /var/lock/LCK..ttyS0.

http://tldp.org/HOWTO/Serial-HOWTO.html#toc14.2

covers some of the issues there.
