From: broonie@kernel.org (Mark Brown)
Date: Fri, 16 Jan 2015 20:25:16 +0000
Subject: [PATCH v4 4/4] ARM: mvebu: Armada 385 GP: Add regulators to the
 SATA port
In-Reply-To: <54B9629C.9090800@redhat.com>
References: <1421330978-9694-1-git-send-email-gregory.clement@free-electrons.com>
 <1421330978-9694-5-git-send-email-gregory.clement@free-electrons.com>
 <54B8C933.7020502@redhat.com> <54B8D97B.3090908@free-electrons.com>
 <54B8E38A.6020709@redhat.com> <20150116123705.GM3043@sirena.org.uk>
 <54B9629C.9090800@redhat.com>
Message-ID: <20150116202516.GL3856@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 16, 2015 at 08:12:28PM +0100, Hans de Goede wrote:
> On 16-01-15 13:37, Mark Brown wrote:

> >>It is probably a good idea to use regulator-boot-on and
> >>then test things this way, and if that works use
> >>regulator-boot-on.

> >No, it's unlikely that boot-on makes sense here - it's there for cases
> >where we can't read back the hardware state at power on.

> Which we cannot here since we've a gpio driven regulator, with the pin
> in output mode, so we cannot read it back. Or at least the current kernel
> implementation relies on regulator-boot-on rather then reading the
> state back from the hardware.

Right, this always seems like a problem with the GPIO API - not being
able to read the state back is a total pain for boot handover, we should
really have a way of reading back the current output state.  This is one
of the few cases where boot-on can be useful, though ideally it'd be set
by the bootloader rather than as a static thing since otherwise you have
the opposite problem in the case where the disk isn't being used at the
current time.

> While we're discussing this I would also like to advocate to change the
> behavior for regulator-boot-on to be the same as always-on when it comes
> to regulator_init_complete(), iow regulator-boot-on regulators should
> not be touched by regulator_init_complete(). It makes no sense to have
> different behavior for build in versus module drivers here.

Like I say boot-on is *only* intended to support bootstrapping, if you
want the regulator to be always on then mark it as always on.  If you
want some way of marking the end of userspace init so we can defer
cleanup of unused resources then go do that - it's a change I've
advocated before, it'd help with modular drivers in general.

> I believe we should still leave these on once userspace starts running,
> there is a reason they are marked as regulator-boot-on and the fact that
> we're ready to start running userspace does not take away that reason, to
> me regulator-boot-on means "do not turn off until explicitly told so by
> a driver which (hopefully) knows wtf it is doing".

No, that's not it at all - it just means that either the hardware didn't
support readback or we're working around our own limitations in not
being capable of doing that.  Remember, regulators are reference counted
so with a few exceptions drivers aren't saying "turn this off now"
they're saying "this device doesn't need this regulator right now, turn
it off if you like" and there's no guarantee that a driver will ever be
loaded in the first place.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150116/0f2077f6/attachment.sig>
