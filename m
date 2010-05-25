From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 25 May 2010 21:16:32 +0100
Subject: [PATCH] ARM: TCM memory bug on newer compilers
In-Reply-To: <1274805947-414-1-git-send-email-linus.walleij@stericsson.com>
References: <1274805947-414-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20100525201632.GC16204@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 25, 2010 at 06:45:47PM +0200, Linus Walleij wrote:
> Apparently newer compilers don't like you to refer to linker
> symbols as extern char *foo, we must use char foo and refer to
> the address of the char instead.

afaik, that's always been the case.

Let's take an example.  Location 0x1234 contains value 0x89abcdef.
The symbol __tcm_start has the address of 0x1234.

Now:

extern char *__tcm_start;

declares a pointer to a char.  The address of the __tcm_start storage
will be 0x1234.  The value of __tcm_start will be 0x89abcdef - and
this is the value that would be passed to __pa(__tcm_start).  The
value of __tcm_start[0] is whatever is stored at the address
0x89abcdef.

extern char __tcm_start[];

declares an array of char.  The address of the __tcm_start storage will
be 0x1234.  The value of __tcm_start is in this case defined to be the
same as the value of a pointer to the first element - so 0x1234.
The value of __tcm_start[0] will be whatever is stored at 0x1234, and in
LE that will be 0xef.

extern char __tcm_start;

declares a single char.  The address of the __tcm_start storage will be
0x1234.  The value of __tcm_start is the value at this address, and
still assuming LE, 0xef.

So, either use:

	extern char __tcm_start;
	pa_start = __pa(&__tcm_start);

or:

	extern char __tcm_start[];
	pa_start = __pa(__tcm_start);

which reveal the same answer.  However, this will give you something
completely different:

	extern char *__tcm_start;
	pa_start = __pa(__tcm_start);
