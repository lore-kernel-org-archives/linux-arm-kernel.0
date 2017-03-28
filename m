From: broonie@kernel.org (Mark Brown)
Date: Tue, 28 Mar 2017 17:47:54 +0100
Subject: [RFC 4/8] regulator: core: Check enabling bypass respects
 constraints
In-Reply-To: <1490704781.3546.57.camel@nxp.com>
References: <cover.1490199005.git.leonard.crestez@nxp.com>
 <1edff9bc610969b0c53fa1080d5db021c8e00b2d.1490199005.git.leonard.crestez@nxp.com>
 <20170324125212.vikgekqxsnu7htzl@sirena.org.uk>
 <1490704781.3546.57.camel@nxp.com>
Message-ID: <20170328164754.z2c2ttovs3sxbcos@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 28, 2017 at 03:39:41PM +0300, Leonard Crestez wrote:
> On Fri, 2017-03-24 at 12:52 +0000, Mark Brown wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> > to the supply.??Usually bypass is used for low power retention modes
> > with different settings to those used in normal operation that wouldn't
> > be desired in normal operation, if we were going to have constraints for
> > this I'd expect a separate set used during bypass.

> In this particular case it's not possible to set constraints on the parent
> regulator so that both ldo-enable and ldo-bypass modes work. The maximum allowed
> voltage for ldo-bypass is lower than the minimum required to support the chip at
> max frequency wit ldo-enable.

If things are really so sensitive that you can't bypass without lowering
the voltage then it's hard to see how you can safely transition into and
out of bypass mode.  

> I'm not sure I understand why you are against applying constraints to the parent
> when in bypass mode, it seems like the obvious thing to do if you want to
> support flexible configuration. The check I introduced is probably not enough to
> cover all cases, for example it would still be possible to explicitly change
> parent voltage afterwards.

To repeat what I said previously the whole point of bypassing is to not
do regulation and generally the constraints in the unregulated idle case
are substantially more relaxed.  This would break use cases relying on
the existing behaviour which wouldn't expect to affect the parent
voltage at all, either stopping things working or making them less
efficient by needlessly regulating the voltage down which defeats the
main point of bypassing.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170328/d6a45c00/attachment.sig>
