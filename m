From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 3 Apr 2017 12:06:55 -0400 (EDT)
Subject: [PATCH v2 0/5] minitty: a minimal TTY layer alternative for
 embedded systems
In-Reply-To: <1491224186.3704.11.camel@linux.intel.com>
References: <20170401222119.25106-1-nicolas.pitre@linaro.org>
 <CAHp75VdGm2uVPBhfAge4Wx6WW2y52oddpOSfJgdYAfTUQPN7TQ@mail.gmail.com>
 <alpine.LFD.2.20.1704021149550.1847@knanqh.ubzr>
 <1491224186.3704.11.camel@linux.intel.com>
Message-ID: <alpine.LFD.2.20.1704031121520.1847@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 3 Apr 2017, Alan Cox wrote:

> If you need a tiny tiny tty layer console for some kind of not quite
> mini-Linux please just steal the one from Fuzix or something similar
> thats only a couple of K in size and only needs extremely simple send
> byte/rx byte type handlers.

This, however, requires that every UART driver be rewritten to suit this 
code. I don't want to lose one of Linux's best advantage which is 
extensive hardware support. I want to reuse as much of the existing 
hardware drivers as possible unchanged.

I already have code that fits the Linux model and it weights 
only 8K.

> Alternatively just compile out tty support entirely. What do you
> actually need ? Console doesn't need tty layer and if you have a
> debug/management interface that doesn't have to be tty and text based
> either.

It is nevertheless very convenient to be able to use a standard shell 
with it. I can easily remove canonical mode support and then it is down 
to 7.3K. Modem line control and runtime baudrate handling could also 
trivially be configured out for yet more saving.

> Being able to compile out tty support would be useful, having two tty
> layers that are intertwined and now both totally unmaintable is not
> IMHO progress.

I beg to disagree here.  First, before you call my code "totally 
unmaintainable" I'd politely ask you to have a look at it first.

There is also very little intertwining here. My code does not rely on 
the existing TTY code (except for the termios baudrate handling which I 
factored out). I'm creating my own char devices on one end and 
interacting with UART drivers using the same low-level call interface 
used by the existing code at the other end. And given that it is much 
simpler in termps of capabilities, it is also very easy to maintain.


Nicolas
