From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 18 Dec 2013 11:01:15 -0500
Subject: [PATCH V2 2/8] string: fix strncmp function
In-Reply-To: <20131218125203.GI4360@n2100.arm.linux.org.uk>
References: <1386767259-15693-1-git-send-email-p.wilczek@samsung.com>
 <1387368551-18958-1-git-send-email-p.wilczek@samsung.com>
 <1387368551-18958-3-git-send-email-p.wilczek@samsung.com>
 <20131218121551.GH4360@n2100.arm.linux.org.uk>
 <52B193BE.1080206@gmail.com>
 <20131218125203.GI4360@n2100.arm.linux.org.uk>
Message-ID: <20131218160114.GP2609@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 18, 2013 at 12:52:03PM +0000, Russell King - ARM Linux wrote:
> On Wed, Dec 18, 2013 at 01:23:26PM +0100, Daniel Mack wrote:
> > On 12/18/2013 01:15 PM, Russell King - ARM Linux wrote:
> > > For instance, can you be sure that there aren't any uses of strncmp()
> > > which already test for less-than-zero etc?
> > 
> > In this case, yes. The code as it stands is very small, and users only
> > check for the return value of these functions to be 0.
> > 
> > But I wonder whether that patch is needed at all. At least the rest of
> > this series does not even seem to introduce new call sites of strcmp()
> > or strncmp() ...
> 
> The implementation appears to be buggy as it stands - all it does is
> sum up the differences in the whole string.
> 
> What if you're comparing two strings:
> 
> 	ac
> 	ca
> 
> The first character has a difference of +2, the second has a difference
> of -2.  Sum those together and you get zero.  Oh, the two strings are
> identical!

Yes, you are correct, the implementation isn't perfect.  I'll correct it
since I introduced it.

> Oh, and the other nitpick with the code is this:
> 
> 	*(a++)
> 
> Really, are those parens really needed?  If you don't know the precendence
> there, then you really shouldn't be programming in C, because this might
> also be buggy:
> 
> 	*(a++) - *(b++)
> 
> because if we declare that we don't know the precedence rules, it could be
> that this is evaluated as *((a++) - (*(b++))) which would lead to errors!
> Maybe some more parens should be added to make it clear!  Or maybe we
> should just learn the precedence rules and realise that:
> 
> 	*a++ - *b++
> 
> is correct and clear and there's no need for any stupid idiotic parens
> here.
> 
> Yes, I loath unnecessary parens.

Ahhh...  Good morning Russell! :)))

Yes, this is a bad habit I picked up, no shit, with gcc v2.96.  If you
recall, 2.96 was fucked up like a soup sandwich [1].  That was right
as I was starting my first job coding in C and I recall having to work
around many bugs, including segfaults when passing a double to printf().

The parentheses you caught above are another fallout from that.  iirc,
v2.96 *actually* did the wrong thing if we had

	*a++ = expr;

After a year or two of maintaining that code on Vermillion [2] (a Redhat
derivative the lead engineer liked), *(a++) was safe, and *a++ was
dangerous.

In Redhat's defense, I should've corrected the bad habit once I moved to
other distros and realized v2.96 was the problem.  But I didn't.  My
bad.  Patch on the way.

thx,

Jason.

[1] http://gcc.gnu.org/gcc-2.96.html
[2] "Vermillion is my customized linux distribution based on redhat."
    was found in $searchengine, but not at a site I want to link to.
    Apparently, the Internet forgot about this distro...
