From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 12 Jun 2014 13:57:03 +0200
Subject: Kconfig fails: big select-based circular dependency
In-Reply-To: <20140612113445.GF23430@n2100.arm.linux.org.uk>
References: <20140607090944.GL23430@n2100.arm.linux.org.uk>
 <20140612094745.GD23430@n2100.arm.linux.org.uk>
 <6077426.uLBS643pC0@wuerfel>
 <20140612113445.GF23430@n2100.arm.linux.org.uk>
Message-ID: <CAMuHMdV0F_FhtJwrzJLbxTbQPKs1XzR=Yb0wjMw2TBuXNPObpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 12, 2014 at 1:34 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>> > > drivers/gpu/drm/panel/Kconfig:19:       symbol DRM_PANEL_LD9040 depends on DRM_PANEL
>> > > drivers/gpu/drm/panel/Kconfig:1:        symbol DRM_PANEL is selected by DRM_IMX_LDB
>> > > drivers/staging/imx-drm/Kconfig:35:     symbol DRM_IMX_LDB depends on MFD_SYSCON
>> > > drivers/mfd/Kconfig:722:        symbol MFD_SYSCON is selected by POWER_RESET_KEYSTONE
>>
>> We have 10 drivers doing 'select MFD_SYSCON' and 9 drivers doing
>> 'depends on MFD_SYSCON'. Either one would work if we did those
>> consistently, here the problem is really mixing the two.
>
> Indeed - we need clear policies on this stuff, because as we get different
> platforms doing different things (as is the case in this scenario), we are
> only going to see an increase in this problem.
>
> Also, I don't think we should do just one change to break this loop - this
> is a sign of a much bigger disease.  We are heading towards the situation
> where adding just one 'select' or 'depends on' statement between two symbols,
> thereby adding just one more dependency to an already tightly linked graph
> can cause a circular dependency.
>
> We need to stop this behaviour ASAP, and kill off as many of these
> ill-considered or wrong dependencies as possible, otherwise we're risking
> Kconfig becoming unmaintainable.
>
> Whenever we see a new 'select' statment appearing in a patch for something
> which is not a utility symbol, we need to ask what the justification is
> for it being there, and evaluate whether it's reasonable (ideally, this
> should be detailed in the commit log.)
>
> (I define a utility symbol as one whose primary purpose is to be selected.)

"primary purpose".

Should we have a better separation between select and depends, i.e.
should kconf plainly reject both being used on the same symbol?

Is it ever valid to have a symbol that's both selected and used with depends on?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
