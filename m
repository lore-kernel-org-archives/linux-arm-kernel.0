From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Wed, 1 Nov 2017 12:17:55 -0700
Subject: [RFC] Improving udelay/ndelay on platforms where that is possible
In-Reply-To: <CA+55aFxxH0HE9SfUoLVqsvDKO0PfeM+vSoDmbXQv85yJcPZoPQ@mail.gmail.com>
References: <d3f42f35-8175-58f6-78b7-3331efe64da2@sigmadesigns.com>
 <20171101175325.2557ce85@alans-desktop>
 <4b707ce0-6067-ab36-e167-1acf348d26bf@free.fr>
 <CA+55aFxxH0HE9SfUoLVqsvDKO0PfeM+vSoDmbXQv85yJcPZoPQ@mail.gmail.com>
Message-ID: <CA+55aFx86WR3wFibq6MUtSCvVG9Ty-m=tAFh0XHSfu192fFeiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 1, 2017 at 12:09 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Yes, there is a *fallback* for when somebody doesn't do ndelay() at
> all, but that doesn't make it the default.
>
> It's just a "the architecture didn't implement ndelay at all, we'll
> work around it".

Side  note: I will continue to claim that anybody who thinks they need
ndelay() needs to rethink their position anyway, due to all the issues
I did already bring up.

So I'd say that pretty much 100% of all ndelay() users are just wrong.
If you are doing a driver that needs that kind of delay granularity,
you had better already know exactly how long it takes to read the
status register, and just do that instead.

And if you don't know how long it takes to read a status register, you
have no business thinking that you need ndelay(). You probably ended
up reading one piece of hardware doc ("the sample-and-hold register
takes 200ns to settle") without then reading the other low-level
hardware documentation that talks about the timings of the chip
accesses from the host side.

                 Linus
