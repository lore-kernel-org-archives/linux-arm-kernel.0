From: ynvich@gmail.com (Sergei Ianovich)
Date: Wed, 16 Apr 2014 23:01:47 +0400
Subject: [PATCH v4 12/21] serial: support for 16550A serial ports on
 LP-8x4x
In-Reply-To: <20140416193532.0782f045@alan.etchedpixels.co.uk>
References: <1397668411-27162-7-git-send-email-ynvich@gmail.com>
 <1397668667-27328-1-git-send-email-ynvich@gmail.com>
 <1397668667-27328-6-git-send-email-ynvich@gmail.com>
 <20140416193532.0782f045@alan.etchedpixels.co.uk>
Message-ID: <c4533da6-30bd-4ea4-9011-a7e3b7258e62@email.android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk> wrote:
>> +	baud = uart_get_baud_rate(port, termios, old,
>> +				  port->uartclk / 16 / 0xffff,
>> +				  port->uartclk / 16);
>> +	switch (baud) {
>> +	case 2400:
>> +		len |= 1;
>> +		break;
>> +	case 4800:
>> +		len |= 2;
>> +		break;
>> +	case 19200:
>> +		len |= 4;
>> +		break;
>> +	case 38400:
>> +		len |= 5;
>> +		break;
>> +	case 57600:
>> +		len |= 6;
>> +		break;
>> +	case 115200:
>> +		len |= 7;
>> +		break;
>> +	case 9600:
>> +	default:
>> +		len |= 3;
>> +		break;
>> +	};
>
>Some explanation of this would be useful - eg why is it set to 7 for
>115200 baud and 3 for 115201 baud ?

I am not related to the device vendor in any way, so please take my answers for what they are worth.

It seems that there is not enough pins to properly connect the chips to the memory bus and just you the standard 8250 UART driver. Instead, clock divisor is set using this register.

So, if you know you're asking for (115200) you get it. If you don't or guess (115201), you get the default 9600.

This is a policy, it may not be the right way to write a driver, but it is cheap and it works.
