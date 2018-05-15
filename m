From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 May 2018 14:48:31 +0100
Subject: [PATCH 1/4] amba: Export amba_bustype
In-Reply-To: <20180515081519.22751a39c49e63224da3acac@arm.com>
References: <20180508140628.f30774c70c4c481bff3f8000@arm.com>
 <CAPDyKFqagt5zhz-8hLSXOqofv-nBqg4i-EVjA=UV3Jfi4zktKg@mail.gmail.com>
 <20180515081519.22751a39c49e63224da3acac@arm.com>
Message-ID: <20180515134831.GG16141@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2018 at 08:15:19AM -0500, Kim Phillips wrote:
> On Tue, 15 May 2018 08:59:02 +0200
> Ulf Hansson <ulf.hansson@linaro.org> wrote:
> 
> > On 8 May 2018 at 21:06, Kim Phillips <kim.phillips@arm.com> wrote:
> > > This patch is provided in the context of allowing the Coresight driver
> > > subsystem to be loaded as modules.  Coresight uses amba_bus in its call
> > > to bus_find_device() in of_coresight_get_endpoint_device() when
> > > searching for a configurable endpoint device.  This patch allows
> > > Coresight to reference amba_bustype when built as a module.
> > 
> > Sounds like you are fixing a bug, don't your want this to go for
> > stable and then also add a fixes tag?
> 
> How do you consider this a bug fix?  What commit would the fixes tag
> reference?  The introduction of the amba bus?  Not only aren't busses
> required to export their bus_type, but that commit predates git.

I do not consider it a bug fix (see my reply to Ulf) and I certainly
do not think it should qualify for backporting to *stable* kernels.

While the impact on stable kernels of just this patch should be low,
that's not really the point: one of the requirements for stable kernels
is that patches should be _real_ bug fixes - stuff that affects people
using the kernel.

That is not the case in this instance - there is no problem with any
of the existing kernels with not having this symbol exported.

The only problem which we're aware of is with Coresight, and only then
when your patches to allow Coresight to be modular are merged.  That's
a new feature, and this new feature now requires a symbol that was not
previously required to be exported to now be exported.

So, the need for this export comes from your new feature, not from a
bug report that is affecting people.  As long as your new feature is
not backported (does it even qualify for backporting to stable kernels?)
then there is no problem with any existing stable kernel, and so there
is no requirement for it to be backported.

Hence, there's no need to Cc stable, and no need for a fixes tag.  It's
not a fix, it's a feature enhancement to permit modular code to use
bus_find_device() with this bus type which wasn't previously required.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
