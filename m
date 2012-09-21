From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Fri, 21 Sep 2012 20:56:03 +0100
Subject: [PATCH 3/3] serial: pl011: allow very high baudrates
In-Reply-To: <CACRpkdakLAPmD0TQwe2VNhdePDuFv2KXD2U1xoP1C0axkx2p7A@mail.gmail.com>
References: <1348134368-25663-1-git-send-email-linus.walleij@stericsson.com>
 <20120920190034.GB15609@n2100.arm.linux.org.uk>
 <CACRpkdY1ZxQoyGFO9OnKr0WYQzooxPGvZV8Gnr_YO_yT_+ddDw@mail.gmail.com>
 <20120921162543.1ed18775@pyramind.ukuu.org.uk>
 <CACRpkdakLAPmD0TQwe2VNhdePDuFv2KXD2U1xoP1C0axkx2p7A@mail.gmail.com>
Message-ID: <20120921205603.436a0194@pyramind.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 21 Sep 2012 19:52:04 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Fri, Sep 21, 2012 at 5:25 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> 
> > Untested but I suspect the following may help
> 
> Nope it doesn't, it's not this part that goes wrong, it's the call to
> tty_termios_encode_baud_rate() that is the problem, not how it
> gets called. It's that function that fuzzes and "snaps" the baudrate
> to some rough-fit speed and screws things up for me.

It should only snap the baud rate if your caller didn't ask for a specific
speed. With the older uart_get_baud_rate code it mangled the encoding
because BOTHER got mangled by uart_get_baud_rate.

The intended behaviour at tty layer is

Caller passes BOTHER and actual bit rate - we return BOTHER and a bit
rate

Caller does not pass BOTHER (may not be TCGETS2 aware) we snap to the
nearest Bfoo rate if within 5% otherwise we return BOTHER based rates.

If you are calling TCSETS2 passing BOTHER and an actual specific speed
you should always be getting handed back the speed requested as it'll see
the BOTHER flag is present and assume the caller is smart.

So how are you setting the speed and can you see at which point it is
getting mushed ?

Alan
