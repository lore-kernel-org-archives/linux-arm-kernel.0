From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 7 Jun 2018 11:13:53 +0200
Subject: [PATCH v4 05/14] coresight: get/put module in
 coresight_build/release_path
In-Reply-To: <3219276b-2703-bc30-92e1-bae80cdc5901@arm.com>
References: <20180605210710.22227-1-kim.phillips@arm.com>
 <20180605210710.22227-6-kim.phillips@arm.com>
 <20180606082422.GB19727@kroah.com>
 <a457594c-b391-23e1-6ab5-d115073cac5a@arm.com>
 <20180606155501.704583e1412996a1a2c6fa61@arm.com>
 <20180607083401.GE16651@kroah.com>
 <3219276b-2703-bc30-92e1-bae80cdc5901@arm.com>
Message-ID: <20180607091353.GA20438@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 07, 2018 at 10:04:33AM +0100, Suzuki K Poulose wrote:
> Hi Greg,
> 
> On 06/07/2018 09:34 AM, Greg Kroah-Hartman wrote:
> > On Wed, Jun 06, 2018 at 03:55:01PM -0500, Kim Phillips wrote:
> > > On Wed, 6 Jun 2018 10:46:36 +0100
> > > Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> > > 
> > > > On 06/06/2018 09:24 AM, Greg Kroah-Hartman wrote:
> > > > > On Tue, Jun 05, 2018 at 04:07:01PM -0500, Kim Phillips wrote:
> > > > > > Increment the refcnt for driver modules in current use by calling
> > > > > > module_get in coresight_build_path and module_put in release_path.
> > > > > > 
> > > > > > This prevents driver modules from being unloaded when they are in use,
> > > > > > either in sysfs or perf mode.
> > > > > 
> > > > > Why does it matter?  Shouldn't you be allowed to remove any module at
> > > > > any point in time, much like a networking driver?
> 
> The user doesn't have an explicit refcount on the individual components
> in a trace session. So, when a trace session is in progress, it is as
> good as having a "file" open on each component that is part of the
> active trace session. So, we don't want the driver to be removed when
> the component is being used in the trace collection.

Why not?  What's wrong with that happening and then the trace collection
starts failing with -ENODEV or something?

Remember, removing a kernel module is something that only happens very
rarely, and is an explicit choice by someone with root permissions.  If
you want to remove that module, it should be able to go, as you know
what you are doing at that point in time.

Don't try to "protect the user from themselves" here, they want to shoot
their foot, make it hurt if they are aiming it there :)

> This will be
> released as soon as the session is ended. It is just like a PMU driver
> where the module refcount is held to ensure the module stays until the
> session is over. In this case, we have multiple components, each with
> its own driver invisible to the PMU driver. Hence the coresight driver
> must hold the reference.

Again, please think this through and don't add extra complexity to the
normal path, and get it right if you do it (the existing patch is not
right as I pointed out.)  Personally, I feel the code should just be
able to be unloaded whenever they want, user beware...

thanks,

greg k-h
