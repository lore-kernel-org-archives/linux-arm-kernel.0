From: olof@lixom.net (Olof Johansson)
Date: Thu, 15 Aug 2013 22:25:20 -0700
Subject: [PATCH v5 2/3] drivers: of: add initialization code for dma
 reserved memory
In-Reply-To: <520A924C.6070309@wwwdotorg.org>
References: <1376049119-12655-1-git-send-email-m.szyprowski@samsung.com>
 <1376049119-12655-3-git-send-email-m.szyprowski@samsung.com>
 <520A924C.6070309@wwwdotorg.org>
Message-ID: <20130816052520.GA7035@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 13, 2013 at 02:08:44PM -0600, Stephen Warren wrote:
> On 08/09/2013 05:51 AM, Marek Szyprowski wrote:
> > Add device tree support for contiguous and reserved memory regions
> > defined in device tree. Initialization is done in 2 steps. First, the
> > memory is reserved, what happens very early when only flattened device
> > tree is available. Then on device initialization the corresponding cma
> > and reserved regions are assigned to each device structure.
> 
> Hmmm. This seems an awful lot like putting SW configuration/policy
> information into DT rather than HW description. This feels like a
> slippery slope... Isn't this kind of thing better handled by a kernel
> command-line option to set up the CMA size?

Sorry, you were not part of the in-person discussion since it happened
at Linaro Connect in Dublin. The concern is that we really need a way
to describe some of these _system_ properties. They're not necessarily
hardware properties, but they are well-known and likely properties of
the system that is running.

I.e. say you have a device with a known screen resolution running some
reasonably well-known software stacks/applications that you expect
will use a certain amount of graphics memory. Or you know how large
your camera sensor is, so you know how much carveout the ISP will need
for captures. So defining how large the default carveouts should be
is very much a property of this system. We would previously have put
these settings in a board file and be done, but now we need a way to
describe it.

/chosen was proposed, but that's mostly used for things that the
sysadmin would adjust (traditionally such as firmware stdin/stdout, etc).
/options isn't a good place either.

Having them on the command line doesn't really work well, over time
we'll start to accumulate cruft there. It's bad enough for some of the
devices out there that do it, I'd say.

So, for the specific case of memory carveouts, this was suggested as the best
way forward.


-Olof
