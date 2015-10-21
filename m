From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 21 Oct 2015 10:57:07 +0200
Subject: console vs earlycon ?
In-Reply-To: <CAK7LNARem16fTim8Ds_y8ezMusz_aRtv6c59KoxyC0rLV-RBWw@mail.gmail.com>
References: <CAK7LNARem16fTim8Ds_y8ezMusz_aRtv6c59KoxyC0rLV-RBWw@mail.gmail.com>
Message-ID: <5490668.HV7UIzY6eu@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 21 October 2015 17:21:07 Masahiro Yamada wrote:
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
> 
> I am using 8250-ish UART device.
> 
> 
> I noticed univ8250_console_match() and univ8250_console_setup()
> always fail at the point of [2] unless early_serial_setup() has been
> called in advance;
> however, it looks like early_serial_setup() is only used for old platforms.
> 
> So, console cannot be enabled at [2] for modern platforms.
> 
> 
> My questions are:
> 
>  -  Given that earlycon can be now available for major architectures such ARM,
>      [2] will be deprecated at some point in the future?
> 
>  - I am implementing  earlycon  for my own UART driver.
>    Is it meaningless to implement  console_initcall()  as well as earlycon?

I would still do both. We don't enable earlycon by default at the moment,
and I'd say things should remain working with just console_initcall().

How closely related to 8250 is your hardware? If it's not all that different,
you should probably reuse the existing driver.

	Arnd
