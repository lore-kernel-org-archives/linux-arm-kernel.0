From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 11 Feb 2016 14:49:43 +0100
Subject: [PATCH 1/2] serial: 8250: fix building mediatek with SERIAL_8250=m
In-Reply-To: <20160208165535.GZ23093@windriver.com>
References: <1454935947-2743255-1-git-send-email-arnd@arndb.de>
 <20160208165535.GZ23093@windriver.com>
Message-ID: <4992215.sKvb0IIruL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 February 2016 11:55:35 Paul Gortmaker wrote:
> > drivers/tty/built-in.o: In function `mtk8250_set_termios':
> > 8250_ingenic.c:(.text+0x1bee8): undefined reference to `serial8250_do_set_termios'
> > 8250_ingenic.c:(.text+0x1bf10): undefined reference to `uart_get_baud_rate'
> > 8250_ingenic.c:(.text+0x1c09c): undefined reference to `uart_get_divisor'
> > drivers/tty/built-in.o: In function `mtk8250_do_pm':
> > 8250_ingenic.c:(.text+0x1c0d0): undefined reference to `serial8250_do_pm'
> > drivers/tty/built-in.o: In function `mtk8250_probe':
> > 8250_ingenic.c:(.text+0x1c2e4): undefined reference to `serial8250_register_8250_port'
> > serial/8250/8250_mtk.c:287:242: error: data definition has no type or storage class [-Werror]
> > serial/8250/8250_mtk.c:287:122: error: 'mtk8250_platform_driver_init' defined but not used [-Werror=unused-function]
> 
> Probably should drop the ingenic lines above ; assuming they are make -j N
> related and that mtk doesn't depend on or build ingenic.

I looked at these again and noticed that this is just being misreported
by the linker. I don't know exactly what happens here but I see it a lot:
the function names ("mtk8250_set_termios") are all correct, but the file
names ("8250_ingenic.c") are wrong. I normally edit out the file names
manually but forgot that here. I'll fix it up when resending.

	Arnd
