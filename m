From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 08 Aug 2016 23:39:38 +0200
Subject: Why do we need reset_control_get_optional() ?
In-Reply-To: <1470674376.2497.49.camel@pengutronix.de>
References: <CAK7LNAQnitMMp5wMXXvVeS-UFF=Fo9m=M1hL=5f4=RF8JYCnGg@mail.gmail.com>
 <1859714.7lR6dsl2IG@wuerfel> <1470674376.2497.49.camel@pengutronix.de>
Message-ID: <8414390.v8zIvdprGF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, August 8, 2016 6:39:36 PM CEST Philipp Zabel wrote:
> > Now I'm also confused about what we really need
> > reset_control_get_optional() for, and which error codes the callers
> > are supposed to check.
> > 
> > This is the matrix I think you mean for _get_optional:
> > 
> [...]
> > CONFIG_RESET_CONTROLLER=n, dt entry present: -EOPNOTSUPP
> > CONFIG_RESET_CONTROLLER=n, dt entry missing: -ENOENT
> 
> ^^ I didn't consider this distiction.
> 
> > Is this what you had in mind? If so, what is the value of the
> > added runtime warning for reset_control_get? Any caller of that
> > function would already check for errors, the only difference
> > I see is that callers of _optional can ignore -ENOENT.
> 
> My initial motivation was to make it as hard as possible to misconfigure
> the kernel, which is why I initially didn't want stubs for the
> non-optional variant. Of course that would cause build failures and/or
> reduced compile test coverage, so we added the stubs and the warning to
> make it obvious when a misconfigured kernel is running: on a kernel with
> RESET_CONTROLLER=n drivers that use reset_control_get are expected to
> build, but they are not expected to work. I suppose the same is the case
> for _optional, if the dt entry is present, so maybe we should drop
> reset_control_get_optional and add always a warning in case of
> -EOPNOTSUPP.
> I don't want all drivers to have to differentiate between -EOPNOTSUPP
> and -ENOENT error codes, only current reset_control_get_optional users
> have to do that.

In almost all cases, I think drivers that require the reset line
wouldn't even check the failure code but just pass it down to
the caller (usually platform_device_probe()), so the really don't
need to care.

Some drivers might want to handle -EPROBE_DEFER (by not warning
about it before returning from probe), and -ENOENT can be handled
in a similar way (by continuing instead of failing).

	Arnd
