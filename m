From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 05 Aug 2016 17:50:10 +0200
Subject: Why do we need reset_control_get_optional() ?
In-Reply-To: <1469703649.12835.34.camel@pengutronix.de>
References: <CAK7LNAQnitMMp5wMXXvVeS-UFF=Fo9m=M1hL=5f4=RF8JYCnGg@mail.gmail.com>
 <CAK7LNAQ0nCQymq+M+FTUXoK7yBj_5CJp9nqDjO3u5wcnckXtmw@mail.gmail.com>
 <1469703649.12835.34.camel@pengutronix.de>
Message-ID: <1859714.7lR6dsl2IG@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, July 28, 2016 1:00:49 PM CEST Philipp Zabel wrote:
> Am Donnerstag, den 28.07.2016, 19:52 +0900 schrieb Masahiro Yamada:

> > > In my experimental patch, I make the _optional functions
> > > return NULL if no "resets" property is provided but return
> > > an error if there are reset lines but the subsystem is
> > > disabled, i.e. an optional reset must be used if it's in the
> > > DT, but can be ignored otherwise.
> > 
> > I do not like this idea.
> > 
> > reset_control_get() (or variants) should not return NULL, it is ambiguous.
> > It should return ERR_PTR(-ENOENT) if no "resets" property.
> > 
> > I only want two types for functions that return a pointer.
> > 
> > [1] return a valid pointer on success, or return NULL on failure
> >     (for example, kmalloc())
> > [2] return a valid pointer on success, or return error pointer on failure
> >    (many of _register() functions)
> > 
> > Mixing [1] and [2] will be a mess.

Ah, right. I was thinking only of the case where the reset subsystem
is completely disabled here, so returning NULL could be considered
a valid return code that can in turn be passed into the other
functions.

However, I agree that returning NULL as a valid result from
..._get_optional() would be bad style, so let's drop my idea
there.

> I too would prefer to keep that as-is. The reset_control_get_optional
> stub could return -ENOENT if there is no resets device tree property.

Now I'm also confused about what we really need
reset_control_get_optional() for, and which error codes the callers
are supposed to check.

This is the matrix I think you mean for _get_optional:

CONFIG_RESET_CONTROLLER=y, dt entry present: valid pointer (or other error)
CONFIG_RESET_CONTROLLER=n, dt entry present: -EOPNOTSUPP
CONFIG_RESET_CONTROLLER=y, dt entry missing: -ENOENT
CONFIG_RESET_CONTROLLER=n, dt entry missing: -ENOENT

Is this what you had in mind? If so, what is the value of the
added runtime warning for reset_control_get? Any caller of that
function would already check for errors, the only difference
I see is that callers of _optional can ignore -ENOENT.

	Arnd
