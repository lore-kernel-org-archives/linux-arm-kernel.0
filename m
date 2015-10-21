From: peter@hurleysoftware.com (Peter Hurley)
Date: Wed, 21 Oct 2015 09:20:38 -0400
Subject: console vs earlycon ?
In-Reply-To: <CAK7LNARem16fTim8Ds_y8ezMusz_aRtv6c59KoxyC0rLV-RBWw@mail.gmail.com>
References: <CAK7LNARem16fTim8Ds_y8ezMusz_aRtv6c59KoxyC0rLV-RBWw@mail.gmail.com>
Message-ID: <56279126.8080506@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/21/2015 04:21 AM, Masahiro Yamada wrote:
> Hi.
> 
> 
> 
> 
> I think there are three places where console could be enabled.
> 
> [1] earlycon
> 
> Each driver entry is declared with
> EARLYCON_DECLARE()  or OF_EARLYCON_DECLARE()
> 
> 
> 
> [2] console_init()
> 
> Each entry is declared with  console_initcall()
> 
> 
> 
> [3]  when driver is probed
> The console is usually enabled at this point
> unless some special treatment is done.
> 
> 
> 
> 
> My question is about [2].

For 8250 sub-drivers, the console_initcall() is only for legacy
platforms, and not for 8250 ports added via serial8250_register_8250_port().

In this contexts, legacy platforms are:
1. early_serial_setup()
2. platforms that define SERIAL_PORT_DFNS (eg., ISA ports)


At the point where console_initcall() occurs, the 8250 core has _not_
been initialized (ie., serial8250_init() has _not_ run).



> I am using 8250-ish UART device.
> 
> 
> I noticed univ8250_console_match() and univ8250_console_setup()
> always fail at the point of [2] unless early_serial_setup() has been
> called in advance;
> however, it looks like early_serial_setup() is only used for old platforms.
> 
> So, console cannot be enabled at [2] for modern platforms.

Since console_init() => console_initcall() occurs before almost everything,
it's not practical to use for probed drivers.


> My questions are:
> 
>  -  Given that earlycon can be now available for major architectures such ARM,
>      [2] will be deprecated at some point in the future?

PPC and x86 platforms still rely on console_init() so it will be some time
before this disappears.

>  - I am implementing  earlycon  for my own UART driver.
>    Is it meaningless to implement  console_initcall()  as well as earlycon?

Probed drivers should only implement earlycon and console. 8250 sub-drivers
should only implement earlycon and/or console if the base 8250 earlycon and/or
console are not operational.

Regards,
Peter Hurley
