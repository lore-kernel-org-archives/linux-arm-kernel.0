From: grant.likely@linaro.org (Grant Likely)
Date: Thu, 16 Jan 2014 17:03:20 +0000
Subject: [RFC 04/18] driver core & of: Mark of_nodes of added device as
 populated
In-Reply-To: <CAL_JsqJGQFstgFu=tpho91C0iv4eH9XSCAVKfXXQO4Z+yD-0tw@mail.gmail.com>
References: <1387815830-8794-1-git-send-email-pawel.moll@arm.com> <
 1387815830-8794-5-git-send-email-pawel.moll@arm.com> <
 CAL_JsqJGQFstgFu=tpho91C0iv4eH9XSCAVKfXXQO4Z+yD-0tw@mail.gmail.com>
Message-ID: <20140116170320.F083BC40973@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 8 Jan 2014 11:28:01 -0600, Rob Herring <robherring2@gmail.com> wrote:
> On Mon, Dec 23, 2013 at 10:23 AM, Pawel Moll <pawel.moll@arm.com> wrote:
> > In "Device Tree powered" systems, platform devices are usually
> > massively populated with of_platform_populate() call, executed
> > at some level of initcalls, either by generic architecture
> > or by platform-specific code.
> >
> > There are situations though where certain devices must be
> > created (and bound with drivers) before all the others.
> > This presents small challenge in DT-driven systems, as
> > devices explicitly created in early code would be created
> > again by of_platform_populate().
> 
> Isn't this already at least partially solved with the aux data
> support? I'm guessing the difference here is how the early device is
> created.

Still, creating a device early and then trying to remember that it has
been done does nothing but add complexity for a very small number of use
cases. I still would much rather see things that need really early setup
to avoid the device model entirely and do the bare minimum needed to
allow the kernel to get to initcall time. In the cases where a subsystem
API requires a struct device, I would consider using a dummy throwaway
struct device for the early bits.

g.
