From: broonie@kernel.org (Mark Brown)
Date: Mon, 5 Aug 2013 23:06:39 +0100
Subject: [PATCH RFC 10/13] ASoC: kirkwood-t5325: add DAPM links between
 codec and cpu DAI
In-Reply-To: <20130805203202.GX23006@n2100.arm.linux.org.uk>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
 <E1V641A-0004lv-DM@rmk-PC.arm.linux.org.uk>
 <20130805112733.GY9858@sirena.org.uk>
 <20130805113310.GU23006@n2100.arm.linux.org.uk>
 <20130805144054.GE9858@sirena.org.uk>
 <20130805145644.GV23006@n2100.arm.linux.org.uk>
 <20130805203202.GX23006@n2100.arm.linux.org.uk>
Message-ID: <20130805220639.GB26637@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 05, 2013 at 09:32:02PM +0100, Russell King - ARM Linux wrote:

> which is similar to what's in Liam's driver.  However, There is no
> .dpcm_playback member in mainline ASoC.

OK, that's interesting...  presumably there's some other framework
changes need upstreaming here, I've really not been paying attention to
any out of tree code here.

> So, let's summarise this.  You're saying that I'm doing it all wrong in
> my driver creating those widgets and paths.  Yet, the widgets and paths
> are exactly what Liam creates in his driver.

Including the CPU<->CODEC paths?  Huh, so it seems.  That wasn't
required in any of the previous out of tree DPCM systems I've worked on
in the past.  Something's changed somewhere along the line here...

If those are required they really should be created by the framework in
the same way as we do for CODEC<->CODEC links, it's not at all sensible
to have to supply them twice and like I say it's just asking for problems.

> Not only that, but we have even more duplicated widgets created with this
> method, even with the hack from this patch set.

> snd_soc_dapm_new_dai_widgets: creating playback widget Playback:Playback
>   for dai d81247c0 dapm d8263f10 (playback_widget  was   (null), new c05ab080)
> snd_soc_dapm_new_dai_widgets: creating playback widget Playback:Playback
>   for dai d81247c0 dapm d8263c70 (playback_widget was c05ab080, new d8fe2b40)

OK, that's not good.  

> It seems Liam's commit needs to be reverted to fix that.  Whether that's
> correct or not, I've no idea.

Needs a closer look I think.

> Plus, when I try to set things up as Liam has, the result doesn't work,
> because of the widget naming scheme having no disambiguation.

That's easy enough to sidestep for now.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130805/74e0948a/attachment.sig>
