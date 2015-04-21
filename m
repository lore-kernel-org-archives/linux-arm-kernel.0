From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 21 Apr 2015 13:46:08 +0100
Subject: Standard/common method for booting secondary cores
In-Reply-To: <553640A4.9090506@free.fr>
References: <553580F7.7040903@free.fr>
 <20150421113914.GA3638@e103592.cambridge.arm.com>
 <553640A4.9090506@free.fr>
Message-ID: <20150421124608.GB3638@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 21, 2015 at 02:20:52PM +0200, Mason wrote:
> Hello Dave,
> 
> It seems you and Mark posted within seconds of each other :-)

Seems so...  fortunately we didn't argue the opposite to each
other.

> On 21/04/2015 13:41, Dave Martin wrote:
> >On Tue, Apr 21, 2015 at 12:43:03AM +0200, Mason wrote:
> >>Hello,
> >>
> >>With the current push for CONFIG_ARCH_MULTIPLATFORM,
> >>I'm wondering if things like starting secondary cores
> >>have been "standardized"/factorized to the point where
> >>I can just use some default implementation?
> >>
> >>I think the implementation I'm using as a starting
> >>point uses SMC calls. I think we are using "TrustZone"
> >>where Linux runs in NS (non secure) mode, and a tiny
> >>proprietary OS runs in secure mode.
> >
> >_If_ you're implementing something new
> 
> You're talking about software, right?
> (The hardware already exists.)

Yes, PSCI is a software interface.

> As I mentioned we do have a working implementation using
> SMC to request service from the secure OS, but I have some
> time to evaluate "better" strategies, as I port the
> platform to a newer kernel.
> 
> >and have a say in what gets implemented in the firmware,
> >please consider PSCI.
> 
> In this context, firmware would be the code run by the
> secure OS?

Yes, or at least those parts of the Secure World software that provide
essential services to the main OS.

> >Without this, little standardisation exists.  Low level CPU
> >power management must typically involve SMCs, but there's
> >no standardisation of their exact semantics, which implies that
> >some platform-specific glue will likely be needed.  The best you can
> >do is look for one or more backends in the kernel that are
> >close to what you need (if any), and if so propose some refactoring
> >to extend support to your platform.
> 
> My objective is to minimize platform-specific code, I will
> look into PSCI.
> 
> >>IIUC (which is probably NOT the case), when Linux runs
> >>in NS mode, some operations that are typically carried
> >>out at boot/init are not allowed, such as
> >>
> >>- starting secondary cores
> >>- configuring the L2 cache controller
> >>
> >>and this must be done by the secure OS via SMC?
> >
> >Generally, yes.
> 
> Is PSCI involved in L2$ configuration?

That depends on the platform.  Single-cluster systems might
not have to do very much L2 configuration, but it depends on
the hardware -- particularly of the L2 is external.

I suggest you take a look at the PSCI spec first -- this
should make is clearer what the firmware is expected to do.

Cheers
---Dave
