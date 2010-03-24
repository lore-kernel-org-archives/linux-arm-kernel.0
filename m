From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 24 Mar 2010 12:11:33 +0100
Subject: Device probe order (i2c regulator vs. platform device)
In-Reply-To: <4BA9D93E.50705@warmcat.com>
References: <E4D3F24EA6C9E54F817833EAE0D912AC09C80E05C7@bssrvexch01.BS.local>
	<4BA9D93E.50705@warmcat.com>
Message-ID: <005501cacb42$c5bbcde0$513369a0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wednesday, March 24, 2010 10:20 AM Andy Green wrote:

> On 03/24/10 07:10, Somebody in the thread at some point said:
> > Hello,
> >
> > I've encountered a problem with regulator framework and the device
> > probe order. In my system there is a pmic chip connected thought i2c
> > bus and a platform device (let's call it A) that depends on the
> > regulator device (for proper probing pmic chip must enable voltage to
> > the device A). In the current configuration the i2c driver is also a
> > platform device. However during the system initialization the device
> > A is probed before the i2c driver would register pmic chip and its
> > regulators.
> >
> > How I can delay probing the device A to the moment when the regulator
> > device will be available in the system? Is there any generic was of
> > changing the device probe order?
> 
> Delaying registering devices is only half the problem.  You must also
> correct these device's parent dev to be the PMU's.
>
> Otherwise your suspend and resume ordering turns to crap and you will
> immediately be in Hell, for example the PMIC may go down taking away
> power from the SD Card before you finished talking to it.
> 
> With correct device parent ordering, then children are guaranteed to be
> suspended before the parent, it means the PMIC won't go down until all
> these guys registered as dependent on it have nicely gone down.

That's true.
 
> What I have been doing is adding a platform callback in the pmic
> platform_data which is called at the end of pmic probe.
> 
> In the machine file, in the callback I then register everything that
> relies on PMIC power arrangements, and correct the device parent at to
> be the PMIC at the same time.
> 
> It would be very good is this was regularized somehow into a standard
> API because it's absolutely a requirement for many boards that their
> devices ARE dependent on PMU as a parent.

Right, this is a really common case. Maybe this callback could be added
to the regulator framework as well?

On the other hand a more generic solution might be needed, because besides
the PMU there might be some other dependences between various devices that
not possible to be ensured in the current framework (I'm thinking of v4l2
subdevs that link 2 separate devices together, but currently are used only
with i2c clients).

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
