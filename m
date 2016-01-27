From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Wed, 27 Jan 2016 12:33:32 +0100
Subject: Serial ports with non connected RTS/CTS
In-Reply-To: <20160127115817.79e384b1@ipc1.ka-ro>
References: <56A89C48.1040604@parkeon.com> <20160127115817.79e384b1@ipc1.ka-ro>
Message-ID: <56A8AB0C.8010407@parkeon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 27/01/16 11:58, Lothar Wa?mann wrote:
>
> If a driver has no support for RTS/CTS (e.g. due to the missing
> fsl,uart-has-rtscts property for i.MX UARTs) then trying to enable HW
> flowcontrol via the TCETS ioctl should fail (as is the case with the
> i.MX serial driver).
> Thus it should be impossible to enable crtscts if the serial driver has
> no RTC/CTS support without any need for userspace to know about the
> HW details.

It doesn't do that for me [kernel 4.4]

The stty command to activate rtscts does return an error if the hardware 
doesn't support it.

# stty -F /dev/ttymxc1 crtscts
stty: /dev/ttymxc1: unable to perform all requested operations

But the TCETS ioctl  itselfdoes not fail:

ioctl(0, SNDCTL_TMR_STOP or TCSETSW, {B115200 -opost -isig -icanon -echo 
...}) = 0
ioctl(0, SNDCTL_TMR_TIMEBASE or TCGETS, {B115200 -opost -isig -icanon 
-echo ...}) = 0
ioctl(0, SNDCTL_TMR_TIMEBASE or TCGETS, {B115200 -opost -isig -icanon 
-echo ...}) = 0
write(2, "stty: ", 6stty: )                   = 6
write(2, "/dev/ttymxc1: unable to perform "..., 56/dev/ttymxc1: unable 
to perform all requested operations) = 56


The error message is because stty does a TCGETS afterwards and errors if 
the result is different to that requested.

slattach does not compare the requested and actual configuaration


The kernel code in the imx driver is:
static void
imx_set_termios(struct uart_port *port, struct ktermios *termios,
            struct ktermios *old)
{
...
     if (termios->c_cflag & CRTSCTS) {
         if (sport->have_rtscts) {
             ucr2 &= ~UCR2_IRTS;

             if (port->rs485.flags & SER_RS485_ENABLED) {
                 /*
                  * RTS is mandatory for rs485 operation, so keep
                  * it under manual control and keep transmitter
                  * disabled.
                  */
                 if (!(port->rs485.flags &
                       SER_RS485_RTS_AFTER_SEND))
                     ucr2 |= UCR2_CTS;
             } else {
                 ucr2 |= UCR2_CTSC;
             }
         } else {
             termios->c_cflag &= ~CRTSCTS;
         }
     } else if (port->rs485.flags & SER_RS485_ENABLED)


So requesting RTSCTS if the hardware doesn't support it does not 
generate an error but the bit is reset in the termios structure.

This makes sense to me. Userspace can ask for something - the driver 
does it's best and reports to userspace what it actually did.
It's then up to userspace to decide if that's acceptable.

And indeed "man termios" :

"Note that *tcsetattr*() returns success if /any/ of the requested 
changes could be successfully carried out. Therefore, when making 
multiple changes it may be necessary to follow this call with a further 
call to *tcgetattr*() to check that all changes have been performed 
successfully. "



Martin
