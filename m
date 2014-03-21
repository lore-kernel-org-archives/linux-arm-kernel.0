From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 21 Mar 2014 20:11:27 +0100
Subject: [PATCH 61/62] ARM: sunxi: fix build for THUMB2_KERNEL
In-Reply-To: <CAL_JsqL_XkF6VRAJdgRmZvX6uud3S8OqvzoTqc9hy2PNDUv5kw@mail.gmail.com>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-62-git-send-email-arnd@arndb.de>
 <CAL_JsqKaL4W_bjozC_hTmZ9439pqh8f8pHU25H5CNdf8hQZtOg@mail.gmail.com>
 <201403201159.35842.arnd@arndb.de>
 <CAL_JsqL_XkF6VRAJdgRmZvX6uud3S8OqvzoTqc9hy2PNDUv5kw@mail.gmail.com>
Message-ID: <20140321191127.GS27873@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 21, 2014 at 10:54:49AM -0500, Rob Herring wrote:
> >
> > .arm
> > ENTRY(sun6i_secondary_startup)
> >         ARM_BE8(setend   be ) /* I suppose we need this too */
> >         msr     cpsr_fsxc, #0xd3
> >         ldr     r0, =secondary_startup
> >         bx      r0
> >
> > (I'm a bit confused about when to use what branch instruction, so
> > forgive me if the above doesn't make sense)
> >
> >> Also, secondary_startup takes care of making sure the core is in SVC
> >> mode, so this function shouldn't be needed in the first place.
> >
> > I'd rather not change this part, unless Maxime can confirm that it's
> > not necessary. I would assume that it's there for a reason otherwise.
> 
> That often proves to not be the case. :) Initial SOC code is whatever
> we've failed to delete from vendor BSP code.

Yep, it definitely looks like it.

> Looking at the review comments adding SMP boot, there was discussion
> about entering in HYP mode and that being dependent on u-boot support,
> but nothing whether this was needed or not. So it appears to me we
> probably enter the kernel in the reset default of secure supervisor
> mode and this code is a nop. This code would not work if it was HYP
> mode. So when u-boot does correctly setup HYP mode, this code will be
> broken (although other parts of smp_ops will be too).

Actually, we don't have any proper bootloader support for this SoC,
and we're stuck with Allwinner's bootloader.

Bootloader support will come eventually, but I wouldn't worry too much
about HYP for now. And whenever we will have such a bootloader, we
will use PSCI, so we won't need to worry about it either.

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140321/9abe1377/attachment-0001.sig>
