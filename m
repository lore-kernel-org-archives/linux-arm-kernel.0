From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 24 Nov 2010 09:17:48 +0100
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
Message-ID: <20101124081748.GV4693@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Linus,

On Wed, Nov 24, 2010 at 07:16:06AM +0900, Linus Torvalds wrote:
> 10/11/23 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> >
> > BTW, I just noticed that Linus wrote:
> >
> > ? ? ? ?Additionally, if no newline existed, one is added (unless the
> > ? ? ? ?log-level is the explicit KERN_CONT marker, to explicitly show
> > ? ? ? ?that it's a continuation of a previous line).
> >
> > This seems to be unimplemented, otherwise the output of
> >
> > ? ? ? ?printk(KERN_ERR "foo bar baz ");
> > ? ? ? ?printk("buz\n" KERN_WARNING "fiz\n");
> >
> > should be
> >
> > ? ? ? ?"foo bar baz \n" at error level
> > ? ? ? ?"buz\n<4>fiz\n" at default level
> 
> No. The KERN_WARNING in the middle of a string is always totally
> bogus. There is no "should be". It's just wrong.
> 
> The "\n" is added automatically iff there is a log-level marker at the
> beginning of the string (with LOG_CONT being the exception).
So

	printk("anything that doesn't look like a loglevel marker"); 

always behaves like

	printk(KERN_CONT "anything that doesn't look like a loglevel marker");

so unless someone wants to print a literal kernel marker we can just do

-#define        KERN_CONT       "<c>"
+#define        KERN_CONT       ""

without any harm.

I wonder why you implemented "iff there is a log-level marker at the
beginning ot the string (with KERN_CONT being the exception)." and not
"unless there is a KERN_CONT marker".

>                                                              So
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
I see one reason to interpret markers after a newline.  In case
recursion_bug is true, printk_buf is initialized with recursion_bug_msg
and my message gets appended.  So currently the marker I pass with my
message is ignored.
Maybe wanting to fix that is just my addiction to overengineering :-)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
