From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 21 Sep 2012 15:41:11 +0200
Subject: [PATCH 3/3] serial: pl011: allow very high baudrates
In-Reply-To: <20120920190034.GB15609@n2100.arm.linux.org.uk>
References: <1348134368-25663-1-git-send-email-linus.walleij@stericsson.com>
 <20120920190034.GB15609@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdY1ZxQoyGFO9OnKr0WYQzooxPGvZV8Gnr_YO_yT_+ddDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2012 at 9:00 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Sep 20, 2012 at 11:46:08AM +0200, Linus Walleij wrote:
>> From: Linus Walleij <linus.walleij@linaro.org>
>>
>> The ST Microelectronics variant of the PL011 is capable of supporting
>> very high non-standard baud rates, even above 4 Mbps. However the
>> uart_get_baud_rate() will not allow us to set these, so override that
>> calculation on very high speeds.
>
> You don't explain why it doesn't.  It should in theory allow you to,
> because there's no limits within that function other than those which
> you pass in as the minimum and maximum.

So I looked closer: uart_get_baud_rate() in turn calls out to
tty_termios_baud_rate() which does some fuzzy matching to the
fix baudrate table and simply "snaps" the baudrate to the closest
match if it is "close enough".

I.e. 4050000 baud is close enough to 4000000 so it will round
off and "snap" to 4000000, whereas 3250000 baud will not
"close enough" to 3000000 so it will not "snap" to 3000000.

So we don't like that 4050000 snaps to 4000000.

I wonder how to fix this ... I'm planning to do what the comment
in tty_ioctl says:

/**
 *	tty_termios_baud_rate
 *	@termios: termios structure
 *
 *	Convert termios baud rate data into a speed. This should be called
 *	with the termios lock held if this termios is a terminal termios
 *	structure. May change the termios data. Device drivers can call this
 *	function but should use ->c_[io]speed directly as they are updated.
 *
 *	Locking: none
 */

Device drivers should use c_[io]speed directly!

Alan Cox wrote this, so Alan: should I just ditch the use of
uart_get_baud_rate() and program the divider directly from
c_[io]speed?

Yours,
Linus Walleij
