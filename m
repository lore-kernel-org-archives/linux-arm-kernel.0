From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Nov 2010 22:33:44 +0000
Subject: About multi-line printk and the need (not) to repeat loglevel
	markers [Was: Re: [PATCH] ARM: mx3/pcm037: properly allocate memory
	for mx3-camera]
In-Reply-To: <AANLkTinmky17XZZPh7QvcY_r=66f_PwzRYFPUSvhiJGK@mail.gmail.com>
References: <20101011152516.GF27153@n2100.arm.linux.org.uk>
	<1290505382-16110-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20101123101210.GA18170@n2100.arm.linux.org.uk>
	<20101123103940.GN4693@pengutronix.de>
	<20101123105830.GO4693@pengutronix.de>
	<AANLkTinmky17XZZPh7QvcY_r=66f_PwzRYFPUSvhiJGK@mail.gmail.com>
Message-ID: <20101123223344.GE26510@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 24, 2010 at 07:16:06AM +0900, Linus Torvalds wrote:
> No. The KERN_WARNING in the middle of a string is always totally
> bogus. There is no "should be". It's just wrong.
> 
> The "\n" is added automatically iff there is a log-level marker at the
> beginning of the string (with LOG_CONT being the exception). So
> 
>    printk("foo bar baz ");
>    printk(KERN_WARNING "fiz\n");
> 
> should output two lines ("foo bar baz" with the default loglevel, and
> "fiz" with KERN_WARNING). Even though there is no explicit "\n" there
> for the first one.
> 
> But KERN_XYZ anywhere but in the beginning of the string do not
> matter. Adding newlines changes none of that. It doesn't make the
> marker beginning of the string, it just makes it beginning of the
> line.

Oh dear.

Note that KERN_foo in the middle of strings, even after a newline are
preserved in the output.  So:

                printk(KERN_WARNING "BUG: Your driver calls ioremap() on system memory.  This leads\n"
                       KERN_WARNING "to architecturally unpredictable behaviour on ARMv6+, and ioremap()\n"
                       KERN_WARNING "will fail in the next kernel release.  Please fix your driver.\n");

results in <4>'s appearing on the console.  I've always written code
over the last 15 years assuming that after any newline in printk output,
the log level gets reset and so needs a new log level specifier.

Sounds like this is something which needs auditing as a result of your
change, and sounds like its something that kernelnewbies people could
do.  My own greps haven't revealed any cases though.
