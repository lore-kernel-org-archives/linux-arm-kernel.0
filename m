From: broonie@kernel.org (Mark Brown)
Date: Mon, 26 May 2014 11:38:07 +0100
Subject: RFC: representing sdio devices oob interrupt, clks, etc. in
 device tree
In-Reply-To: <53824294.1090609@redhat.com>
References: <CAGb2v64VZac2KvAALrScecN89sRnBQoDrKxKMvkte+3G04NXeA@mail.gmail.com>
 <537DE1AA.5050606@redhat.com> <537E31F7.1030505@gmail.com>
 <537F1148.3010102@redhat.com>
 <20140523112239.GB12304@sirena.org.uk>
 <537F3610.3050104@redhat.com>
 <20140523162718.GE22111@sirena.org.uk>
 <53806F26.6050706@redhat.com>
 <20140525123452.GS22111@sirena.org.uk>
 <53824294.1090609@redhat.com>
Message-ID: <20140526103807.GV22111@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 25, 2014 at 09:20:52PM +0200, Hans de Goede wrote:
> On 05/25/2014 02:34 PM, Mark Brown wrote:

> > Why is that a problem - if we have no driver for the device there is no
> > point in powering it up in the first place is there?

> Well the driver may show up later, so if we only do the power-up once we have
> a driver, this means we need to re-check if we need to do the powerup later.

Sure.  Does that seem like a problem?

> Also the mmc people are very much against specifying a driver, as that is
> something which should be probed not specified. I agree with them I've
> already seen boards were more or less standardized sdio modules from different
> vendors are used, they have various standard sdio powerup related things, like
> an enable signal in standard places, but different editions of the boards
> have different sdio modules soldered on, using different drivers.

If the device isn't specified then presumably it'll power up with the
default sequence so we shouldn't need to worry about overriding anything
until we've powered up and enumerated.  The only time that there's a
problem and would need to specify exactly what the device is in the DTS
is if we need the custom sequence prior to being able to do that at
which point I don't see much option.

> I know that the DT is an ABI, and I'm not arguing for removing support for
> the simple-sdio-powerup compatible from the kernel when a more complex
> case arrives, nor am I arguing to remove it from the DT for existing working
> boards. The idea behind the simple-sdio-powerup compatible is that it makes
> the simple powerup behavior opt-in. So if a new board comes along which
> requires something more complex, the people working on this can do what ever
> they want / need without the simple powerup code getting in the way, as
> long as they don't *add* the simple-sdio-powerup compatible to their *new*
> DT file.

I don't understand why not powering the device up would be a sensible
default or why other OSs would also choose to implement things that way.
It would seem more natural that we would have the custom override in
place for things that need special handling, not the other way around -
I think that's really the difference between what we're saying.  My
expectation would be that we do the standard case by default and then
have the complex cases override rather than the other way around, that
way the standard case just works with no effort.

> Basically the idea behind the simple-sdio-powerup compatible is to make
> the worst case scenario for more complex boards to be the scenario which
> we have today, i.e. no support for sdio powerup at all, rather then having
> something in place which actually may get in the way, making things worse
> then they are today.

Well, if things aren't going to work either way for these devices
without extra stuff it seems it doesn't much matter but it helps the
simple case to have things default to working.  If we're in the case
where we've got a DT that just describes a slot and says to probe it
then powering the slot up seems sensible; if we're in the case where we
have explicit information on what's in the slot then that gives us an
opportunity to key custom behaviour off that explict information.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140526/b3cea728/attachment.sig>
