From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Sep 2011 19:58:09 +0100
Subject: Link failures due to __bug_table in current -next
In-Reply-To: <20110919184230.GF540@opensource.wolfsonmicro.com>
References: <20110919120954.GA20314@opensource.wolfsonmicro.com>
	<20110919184027.GZ16381@n2100.arm.linux.org.uk>
	<20110919184230.GF540@opensource.wolfsonmicro.com>
Message-ID: <20110919185809.GA16381@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2011 at 07:42:30PM +0100, Mark Brown wrote:
> On Mon, Sep 19, 2011 at 07:40:27PM +0100, Russell King - ARM Linux wrote:
> > On Mon, Sep 19, 2011 at 01:09:54PM +0100, Mark Brown wrote:
> 
> > > I'm wondering if we need something like 7c8a25 (CRIS: Discard exit.text
> > > and .data at runtime) but figuring it out is a bit beyond my ld skills
> > > right now.
> 
> > fatal: ambiguous argument '7c8a25': unknown revision or path not in the working
> > tree.
> 
> > Maybe you could be more specific?
> 
> It's in -next as of today, presumably it comes from the CRIS tree.  I
> didn't look too closely once the revert worked for me.

Pleas elook at the error message again.  >>>ambiguous<<<.  That means
git knows about the ID but more than one commit matches it:

$ for f in 0 1 2 3 4 5 6 7 8 9 a b c d e f; do git cat-file -p 7c8a25$f >/dev/null; done
fatal: Not a valid object name 7c8a250
fatal: Not a valid object name 7c8a252
fatal: Not a valid object name 7c8a253
fatal: Not a valid object name 7c8a254
fatal: Not a valid object name 7c8a255
fatal: Not a valid object name 7c8a256
fatal: Not a valid object name 7c8a257
fatal: Not a valid object name 7c8a258
fatal: Not a valid object name 7c8a259
fatal: Not a valid object name 7c8a25a
fatal: Not a valid object name 7c8a25c
fatal: Not a valid object name 7c8a25d
fatal: Not a valid object name 7c8a25e
fatal: Not a valid object name 7c8a25f

So there's IDs 7c8a251 and 7c8a25b in existence, and git doesn't know
which one to use.  So using that, I can track down the commit you
actually meant.

What you're actually after is:

	7c8a25b (CRIS: Discard exit.text and .data at runtime)

which is what you'd get from git if you ask it to give you the shortened
git ID.  (Git knows when the shortened git ID clashes and will add
additional digits to make up a unique ID.)

You can use "git log --pretty='%h (%s)'" to get a log already formatted
with parens around the summary line.
