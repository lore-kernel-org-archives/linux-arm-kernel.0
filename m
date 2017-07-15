From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 15 Jul 2017 18:46:26 +0200
Subject: [RFC 1/2] PM / suspend: Add platform_suspend_target_state()
In-Reply-To: <5864280.u6UQBsuXnA@aspire.rjw.lan>
References: <20170622085102.mpk7vxodpgxtrlfd@piout.net>
 <2497538.J9F6XFeBfd@aspire.rjw.lan> <20170715062838.GA20741@amd>
 <5864280.u6UQBsuXnA@aspire.rjw.lan>
Message-ID: <20170715164626.GA1373@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > I had an idea of using an enum type encompassing all of the power states
> > > defined for various platforms and serving both as a registry (to ensure the
> > > uniqueness of the values assigned to the states) and a common ground
> > > between platforms and drivers.
> > > 
> > > Something like:
> > > 
> > > enum platform_target_state {
> > > 	PLATFORM_STATE_UNKNOWN = -1,
> > > 	PLATFORM_STATE_WORKING = 0,
> > > 	PLATFORM_STATE_ACPI_S1,
> > > 	PLATFORM_STATE_ACPI_S2,
> > > 	PLATFORM_STATE_ACPI_S3,
> > > 	PLATFORM_STATE_MY_BOARD_1_GATE_CLOCKS,
> > > 	PLATFORM_STATE_MY_BOARD_1_GATE_POWER,
> > > 	PLATFORM_STATE_ANOTHER_BOARD_DO_CRAZY_STUFF,
> > > 	...
> > > };
> > > 
> > > and define ->target_state to return a value of this type.
> > > 
> > > Then, if a driver sees one of these and recognizes that value, it should
> > > know exactly what to do.
> > 
> > Remind me why this is good idea?
> 
> Because there are drivers that need to do specific things during
> suspend on a specific board when it goes into a specific state as a
> whole.

We have seen driver that cares about voltage to his device being
lost. That's reasonable.

Inquiring what the platform target state is... is not.

> > If board wants to know if certain regulator stays online during
> > suspend, it should invent an API for _that_.
> 
> Ideally, yes.  However, that may be problematic for multiplatform kernels,
> because they would need to have all of those APIs built in and the driver
> code to figure out which API to use would be rather nasty.

Lets do it the right way. Big enum is wrong.

We already have

struct regulator_state {
       int uV; /* suspend voltage */
       unsigned int mode; /* suspend regulator operating mode */
       int enabled; /* is regulator enabled in this suspend state */
       int disabled; /* is the regulator disabled in this suspend state */
};

 * struct regulation_constraints - regulator operating constraints.
  * @state_disk: State for regulator when system is suspended in disk
  * mode.
  * @state_mem: State for regulator when system is suspended in mem
  * mode.
  * @state_standby: State for regulator when system is suspended in
  * standby
  *                 mode.
   
. So it seems that maybe we should tell the drivers if we are entering
"state_mem" or "state_standby" (something I may have opposed, sorry),
then the driver can get neccessary information from regulator
framework.

I don't think it should cause problems with multiplatform kernels.

Best regards,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170715/aad6fa22/attachment.sig>
