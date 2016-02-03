From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 03 Feb 2016 16:58:46 +0100
Subject: [PATCH 01/10] serial: mvebu-uart: initial support for Armada-3700
 serial port
In-Reply-To: <20160202181935.19b4ab7e@lxorguk.ukuu.org.uk> (One Thousand
 Gnomes's message of "Tue, 2 Feb 2016 18:19:35 +0000")
References: <1454436468-4241-1-git-send-email-gregory.clement@free-electrons.com>
 <1454436468-4241-2-git-send-email-gregory.clement@free-electrons.com>
 <20160202181935.19b4ab7e@lxorguk.ukuu.org.uk>
Message-ID: <87vb654wg9.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
 
 On mar., f?vr. 02 2016, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk> wrote:

>> +static void mvebu_uart_set_termios(struct uart_port *port,
>> +				   struct ktermios *termios,
>> +				   struct ktermios *old)
>> +{
>> +	unsigned long flags;
>> +	unsigned int baud;
>> +
>> +	spin_lock_irqsave(&port->lock, flags);
>> +
>> +	port->read_status_mask = STAT_RX_RDY | STAT_OVR_ERR |
>> +		STAT_TX_RDY | STAT_TX_FIFO_FUL;
>> +
>> +	if (termios->c_iflag & INPCK)
>> +		port->read_status_mask |= STAT_FRM_ERR | STAT_PAR_ERR;
>> +
>> +	port->ignore_status_mask = 0;
>> +	if (termios->c_iflag & IGNPAR)
>> +		port->ignore_status_mask |=
>> +			STAT_FRM_ERR | STAT_PAR_ERR | STAT_OVR_ERR;
>> +
>> +	if ((termios->c_cflag & CREAD) == 0)
>> +		port->ignore_status_mask |= STAT_RX_RDY | STAT_BRK_ERR;
>
> If you don't support parity or charactive size then you should be forcing
> those bits in the tty->termios so that the caller sees what settings they
> get. tty_termios_copy_hw is close to what you need except that you can
> support IGNPAR.

OK thanks for the pointer.

>
> You also want to provide the actual baud rate chosen (see how 8250.c does
> it using tty_termios_encode_baud_rate().
>
>
>> +static struct uart_driver mvebu_uart_driver = {
>> +	.owner			= THIS_MODULE,
>> +	.driver_name		= "serial",
>> +	.dev_name		= "ttyS",
>> +	.major			= TTY_MAJOR,
>> +	.minor			= 64,
>
> NAK
>
> TTY_MAJOR 64+ is the 8250 driver and ttyS is the 8250 driver name. You
> should be using a dynamic major (0) for all new drivers and you need to
> pick a different and unused ttyXXX format name.

I missed this one, I will remove .major and .minor and use our own
ttyXX.

Thanks,

Gregory

>
> Alan

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
