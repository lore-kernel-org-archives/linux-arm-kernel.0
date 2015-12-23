From: contact@paulk.fr (Paul Kocialkowski)
Date: Wed, 23 Dec 2015 12:50:20 +0100
Subject: [PATCH 3/6] regulator: lp872x: Remove warning about invalid DVS
 GPIO
In-Reply-To: <20151223114126.GR16023@sirena.org.uk>
References: <1450868319-20513-1-git-send-email-contact@paulk.fr>
 <1450868319-20513-4-git-send-email-contact@paulk.fr>
 <20151223114126.GR16023@sirena.org.uk>
Message-ID: <1450871420.2648.6.camel@collins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le mercredi 23 d?cembre 2015 ? 11:41 +0000, Mark Brown a ?crit :
> On Wed, Dec 23, 2015 at 11:58:36AM +0100, Paul Kocialkowski wrote:
> > Some devices don't hook the DVS pin to a GPIO but to ground or VCC.
> > In those cases, it is not a problem to have no DVS GPIO.
> 
> I would expect the driver at least needs to know how the pins or
> strapped, or otherwise have configuration for ignoring the input on the
> pins.  This just deletes the warnings, it doesn't have any handling for
> this case that I can see.

When the DVS GPIO is invalid, lp872x_init_dvs jumps to the
set_default_dvs_mode label, which instructs the chip not to use the DVS
pin at all and do it all in software instead (by clearing the
LP8720_EXT_DVS_M bit in the LP872X_GENERAL_CFG register).

That is reflected later in the code, when setting the bucks (the DVS pin
only applies to the bucks) by checking for the LP8720_EXT_DVS_M bit on
the LP872X_GENERAL_CFG register (in lp872x_select_buck_vout_addr) to
decide whether to use software or hardware DVS selection.

As far as I understood, everything goes well when the GPIO is invalid.

-- 
Paul Kocialkowski, Replicant developer

Replicant is a fully free Android distribution running on several
devices, a free software mobile operating system putting the emphasis on
freedom and privacy/security.

Website: https://www.replicant.us/
Blog: https://blog.replicant.us/
Wiki/tracker/forums: https://redmine.replicant.us/

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151223/0f470692/attachment.sig>
