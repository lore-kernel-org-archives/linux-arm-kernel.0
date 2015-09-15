From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 Sep 2015 15:23:21 +0100
Subject: [PATCH] ARM: multi_v7: Rebuild default configuration on v4.3-rc1
In-Reply-To: <20150915134639.GC2983@ulmo.nvidia.com>
References: <1442314300-4714-1-git-send-email-thierry.reding@gmail.com>
 <20150915111257.GR21084@n2100.arm.linux.org.uk>
 <20150915134639.GC2983@ulmo.nvidia.com>
Message-ID: <20150915142321.GU21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Added Linus]

On Tue, Sep 15, 2015 at 03:46:40PM +0200, Thierry Reding wrote:
> On Tue, Sep 15, 2015 at 12:12:57PM +0100, Russell King - ARM Linux wrote:
> > On Tue, Sep 15, 2015 at 12:51:40PM +0200, Thierry Reding wrote:
> > > From: Thierry Reding <treding@nvidia.com>
> > > 
> > > It's becoming more and more difficult to update the multi_v7 default
> > > configuration because it hasn't been kept in proper order. Typically the
> > > workflow to update it would be to do the following:
> > 
> > If we start regularly updating the defconfigs, it'll annoy Linus,
> > because it will create a lot of useless churn, bloating his diffstats
> > needlessly.
> 
> We are already regularly updating defconfigs. It's a natural thing to do
> as new features are implemented.
> 
> > Since the defconfig files are not order specific, it would have been
> > a good idea if savedefconfig had sorted the options into alphanumeric
> > order propr to outputting them.  That would cut down on the useless
> > churn, some of which is in your patch.
> 
> That would be one solution. But it would also mean that people need to
> actually go and check that things are properly sorted. Most of the churn
> here doesn't come from the fact that these options have moved in Kconfig
> but because people have inserted them in the wrong places. The same
> could happen even if savedefconfig sorted options alphanumerically,
> because evidently people aren't using the tools properly.

Hardly surprising - if people are going around adding an option to
all architectures, they're not going to run 'make savedefconfig' on
each and every configuration they find to add that option.  That's
far too much work.  It's not that "people aren't using the tools
properly" it's that the tools are too much effort when you've got a
global change to do.

However, there's not really anything that can be done about it,
because nothing is simpler than concatenating an option to all
configs, or adding it using an editor.

> > In fact, most of this patch is pure churn - it's merely moving options
> > about.  It provides very little in the way of useful benefit for its
> > size.  We need to do better than this.
> 
> Yes, I know. In fact I stated that in the commit message. But this
> really should be a one-time thing.

The fact is, this won't be a one-time thing.  People will continue to
add options in random places in these files, and we'll need to "fix"
it with useless churn yet again, and again, and again.

> If we make it easy for people to
> properly update the default configuration there will be less churn
> further down the road. The changes that end up in multi_v7 default
> configuration patches should be what's generated from the defconfig
> output. So unless options get removed from Kconfig there should not
> be any unnecessary churn subsequently.

I think you're living in an ideal world...

> As for changes that move options in Kconfig, I think those should be
> discouraged. The sane thing to do is order them alphabetically, which
> will remove any need to move things around.

... which is why you re-ordered drivers/gpu/drm/Kconfig, moving
bridge/Kconfig after the panel Kconfig, which now resulted in this
churn in _this_ churn filled patch:

 CONFIG_DRM=y
 # CONFIG_DRM_I2C_CH7006 is not set
 # CONFIG_DRM_I2C_SIL164 is not set
-CONFIG_DRM_NXP_PTN3460=m
-CONFIG_DRM_PARADE_PS8622=m
 CONFIG_DRM_NOUVEAU=m
 CONFIG_DRM_EXYNOS=m
...
 CONFIG_DRM_PANEL_SIMPLE=y
+CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=m
+CONFIG_DRM_NXP_PTN3460=m
+CONFIG_DRM_PARADE_PS8622=m
 CONFIG_FB_ARMCLCD=y

> > > diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> > > index 03deb7fb35e8..56775eb9b9cc 100644
> > > --- a/arch/arm/configs/multi_v7_defconfig
> > > +++ b/arch/arm/configs/multi_v7_defconfig
> > > @@ -12,7 +12,6 @@ CONFIG_MODULE_UNLOAD=y
> > >  CONFIG_PARTITION_ADVANCED=y
> > >  CONFIG_CMDLINE_PARTITION=y
> > >  CONFIG_ARCH_VIRT=y
> > > -CONFIG_ARCH_ALPINE=y
> > >  CONFIG_ARCH_MVEBU=y
> > >  CONFIG_MACH_ARMADA_370=y
> > >  CONFIG_MACH_ARMADA_375=y
> > > @@ -20,14 +19,15 @@ CONFIG_MACH_ARMADA_38X=y
> > >  CONFIG_MACH_ARMADA_39X=y
> > >  CONFIG_MACH_ARMADA_XP=y
> > >  CONFIG_MACH_DOVE=y
> > > +CONFIG_ARCH_ALPINE=y
> > 
> > This option has moved, and the above two changes are therefore nothing
> > but churn.
> [...]
> 
> This and all the below I know already. I went through each and every one
> of these options and checked what happened to them. Those listed in the
> commit message are the ones that have actually changed. Those not listed
> are the ones that have only moved around.

Right, so from me this patch gets a NAK, because it's mostly churn
with very little benefit.

Linus has threatened to remove the defconfigs in the past for this
kind of stupid churn.  For me to say anything else about this would
be re-inviting their removal.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
