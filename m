From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 May 2018 14:41:45 +0100
Subject: [PATCH 1/4] amba: Export amba_bustype
In-Reply-To: <CAPDyKFqagt5zhz-8hLSXOqofv-nBqg4i-EVjA=UV3Jfi4zktKg@mail.gmail.com>
References: <20180508140628.f30774c70c4c481bff3f8000@arm.com>
 <CAPDyKFqagt5zhz-8hLSXOqofv-nBqg4i-EVjA=UV3Jfi4zktKg@mail.gmail.com>
Message-ID: <20180515134144.GF16141@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2018 at 08:59:02AM +0200, Ulf Hansson wrote:
> On 8 May 2018 at 21:06, Kim Phillips <kim.phillips@arm.com> wrote:
> > This patch is provided in the context of allowing the Coresight driver
> > subsystem to be loaded as modules.  Coresight uses amba_bus in its call
> > to bus_find_device() in of_coresight_get_endpoint_device() when
> > searching for a configurable endpoint device.  This patch allows
> > Coresight to reference amba_bustype when built as a module.
> 
> Sounds like you are fixing a bug, don't your want this to go for
> stable and then also add a fixes tag?

What bug is this fixing exactly that would qualify it for stable
backporting?

The lack of an export is never a bug unless there is some existing
user which requires it.  This is not the case here.

What Kim is doing in his new patch series is making Coresight - which
is currently only available as either disabled or built-in - possible
to be loaded as a module.  This is a new feature, and in the process
of creating this new feature, Kim needs a symbol that wasn't previously
needed to be exported.

I think it would be hard to argue that Coresight not being available
as a module is a bug worthy of backporting to older kernels.

Therefore, it is not a bug, and it certainly does not qualify for
backporting to stable trees:

 - It must be obviously correct and tested.

Probably.

 - It cannot be bigger than 100 lines, with context.

Is.

 - It must fix only one thing.

Does.

 - It must fix a real bug that bothers people (not a, "This could be a
   problem..." type thing).

Nope.

 - It must fix a problem that causes a build error (but not for things
   marked CONFIG_BROKEN), an oops, a hang, data corruption, a real
   security issue, or some "oh, that's not good" issue.  In short, something
   critical.

Nope, not in any stable tree.

 - Serious issues as reported by a user of a distribution kernel may also
   be considered if they fix a notable performance or interactivity issue.
   As these fixes are not as obvious and have a higher risk of a subtle
   regression they should only be submitted by a distribution kernel
   maintainer and include an addendum linking to a bugzilla entry if it
   exists and additional information on the user-visible impact.

Hasn't been.

 - New device IDs and quirks are also accepted.

Is not that.

 - No "theoretical race condition" issues, unless an explanation of how the
   race can be exploited is also provided.

Is not that.

 - It cannot contain any "trivial" fixes in it (spelling changes,
   whitespace cleanups, etc).

Doesn't (so okay.)

 - It must follow the
   :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
   rules.

Does.

 - It or an equivalent fix must already exist in Linus' tree (upstream).

Eventually.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
