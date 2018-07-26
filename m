From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 26 Jul 2018 15:02:39 +0100
Subject: [PATCH 1/6] ARM: signal: copy registers using __copy_from_user()
In-Reply-To: <20180726135632.GZ17271@n2100.armlinux.org.uk>
References: <20180710141322.GL17271@n2100.armlinux.org.uk>
 <E1fctOl-0005ul-69@rmk-PC.armlinux.org.uk>
 <20180726122350.qtf7h6qekru23bv2@lakrids.cambridge.arm.com>
 <20180726135632.GZ17271@n2100.armlinux.org.uk>
Message-ID: <20180726140239.kuswswnsgyd3uisv@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2018 at 02:56:32PM +0100, Russell King - ARM Linux wrote:
> On Thu, Jul 26, 2018 at 01:23:50PM +0100, Mark Rutland wrote:
> > On Tue, Jul 10, 2018 at 03:13:47PM +0100, Russell King wrote:
> > > When restoring the ARM integer registers, use __copy_from_user() to
> > > copy them into kernel space before restoring them, rather than
> > > __get_user_error().
> > 
> > I assume that this is so that we only have to pay the cost of sanitizing
> > the user pointer once in __copy_from_user(), rather than in each
> > __get_user_error()?
> > 
> > Can we mention that in the commit message? e.g. something like:
> > 
> >   In subsequent patches, each uaccess will sanitize the __user pointer
> >   to prevent speculative accesses to kernel memory.
> >   
> >   To amortize the cost of this sanitization when restoring the integer
> >   registers, we can use __copy_from_user() rather than a sequence of
> >   __get_user_error() calls.
> 
> It's not only that, it's also the overhead of the software PAN support
> as well, and it's a change I've been thinking has been worth doing
> for some time.

Makes sense.

If you can put something in the commit message to cover all of that:

Acked-by: Mark Rutland <mark.rutland@arm.com>

... applying to patches 2 and 3, too.

Mark.
