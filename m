From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Jan 2013 11:21:02 +0000
Subject: [PATCH RESEND 6/6] clk: s5p-g2d: Fix incorrect usage of
 IS_ERR_OR_NULL
In-Reply-To: <20130103111040.GD7247@mwanda>
References: <1355852048-23188-1-git-send-email-linux@prisktech.co.nz>
 <1355852048-23188-7-git-send-email-linux@prisktech.co.nz>
 <50D62BC9.9010706@mvista.com> <50E32C06.5020104@gmail.com>
 <CA+_b7DK2zbBzbCh15ikEAeGP5h-V9gQ_YcX15O-RNvWxCk8Zfg@mail.gmail.com>
 <1357104713.30504.8.camel@gitbox> <20130103090520.GC7247@mwanda>
 <20130103100000.GJ2631@n2100.arm.linux.org.uk> <20130103111040.GD7247@mwanda>
Message-ID: <20130103112102.GM2631@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 03, 2013 at 02:10:40PM +0300, Dan Carpenter wrote:
> Come on...  Don't say we haven't read comment.  Obviously, the first
> thing we did was read that comment.  I've read it many times at this
> point and I still think we should add in a bit which says:

So where does it give you in that comment permission to treat NULL any
differently to any other non-IS_ERR() return value?

It is very clear: values where IS_ERR() is true are considered errors.
Everything else is considered valid.

> "NOTE:  Drivers should treat the return value as an opaque cookie
> and not dereference it.  NULL returns don't imply an error so don't
> use IS_ERR_OR_NULL() to check for errors."

No.  The one thing I've learnt through maintaining www.arm.linux.org.uk
is that the more of these kinds of "lets add to documentation" suggestions
you get, the more _unclear_ the documentation becomes, and the more it is
open to bad interpretation, and the more suggestions to add more words you
receive.

Concise documentation is the only way to go.  And what we have there today
is concise and to the point.  It specifies it very clearly:

 * Returns a struct clk corresponding to the clock producer, or
 * valid IS_ERR() condition containing errno.

That one sentence gives you all the information you need about it's return
value.  It gives you two choices.  (1) a return value where IS_ERR() is
true, which is an error, and (2) a return value where IS_ERR() is false,
which is a valid cookie.

Maybe you don't realise, but IS_ERR(NULL) is false.  Therefore, this falls
into category (2).

You can't get clearer than that, unless you don't understand the IS_ERR()
and associated macro.

Moreover, it tells you the function to use to check the return value for
errors.  IS_ERR().  It doesn't say IS_ERR_OR_NULL(), it says IS_ERR().

All it takes is for people to engage their grey cells and read the
documentation as it stands, rather than trying to weasel their way around
it and invent crap that it doesn't say.
