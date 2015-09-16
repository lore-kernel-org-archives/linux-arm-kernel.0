From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 16 Sep 2015 09:22:51 -0700
Subject: [PATCH] ARM: multi_v7: Rebuild default configuration on v4.3-rc1
In-Reply-To: <20150915152328.GA25966@ulmo.nvidia.com> (Thierry Reding's
 message of "Tue, 15 Sep 2015 17:23:30 +0200")
References: <1442314300-4714-1-git-send-email-thierry.reding@gmail.com>
 <20150915111257.GR21084@n2100.arm.linux.org.uk>
 <20150915134639.GC2983@ulmo.nvidia.com>
 <20150915142321.GU21084@n2100.arm.linux.org.uk>
 <20150915152328.GA25966@ulmo.nvidia.com>
Message-ID: <7h37yegwpw.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thierry Reding <thierry.reding@gmail.com> writes:

> On Tue, Sep 15, 2015 at 03:23:21PM +0100, Russell King - ARM Linux wrote:
>> [Added Linus]
>> 
>> On Tue, Sep 15, 2015 at 03:46:40PM +0200, Thierry Reding wrote:
>> > On Tue, Sep 15, 2015 at 12:12:57PM +0100, Russell King - ARM Linux wrote:
>> > > On Tue, Sep 15, 2015 at 12:51:40PM +0200, Thierry Reding wrote:
>> > > > From: Thierry Reding <treding@nvidia.com>
>> > > > 
>> > > > It's becoming more and more difficult to update the multi_v7 default
>> > > > configuration because it hasn't been kept in proper order. Typically the
>> > > > workflow to update it would be to do the following:
>> > > 
>> > > If we start regularly updating the defconfigs, it'll annoy Linus,
>> > > because it will create a lot of useless churn, bloating his diffstats
>> > > needlessly.
>> > 
>> > We are already regularly updating defconfigs. It's a natural thing to do
>> > as new features are implemented.
>> > 
>> > > Since the defconfig files are not order specific, it would have been
>> > > a good idea if savedefconfig had sorted the options into alphanumeric
>> > > order propr to outputting them.  That would cut down on the useless
>> > > churn, some of which is in your patch.
>> > 
>> > That would be one solution. But it would also mean that people need to
>> > actually go and check that things are properly sorted. Most of the churn
>> > here doesn't come from the fact that these options have moved in Kconfig
>> > but because people have inserted them in the wrong places. The same
>> > could happen even if savedefconfig sorted options alphanumerically,
>> > because evidently people aren't using the tools properly.
>> 
>> Hardly surprising - if people are going around adding an option to
>> all architectures, they're not going to run 'make savedefconfig' on
>> each and every configuration they find to add that option.  That's
>> far too much work.  It's not that "people aren't using the tools
>> properly" it's that the tools are too much effort when you've got a
>> global change to do.
>
> I don't expect people to do this for every option they add. What I was
> expecting people to do is when they add a new feature to a default
> configuration that they add it in the right place. I'm also not
> advocating for doing this for every default configuration, but the
> multi_v7_defconfig is where pretty much everyone in the ARM world adds
> options. It is also one which /should/ be updated through the ARM SoC
> tree only, so there's technically a way to enforce this.
>
>> However, there's not really anything that can be done about it,
>> because nothing is simpler than concatenating an option to all
>> configs, or adding it using an editor.
>
> It's not that easy. As a platform maintainer I often need to deal with
> the situation where the default configuration needs to be updated with
> the latest options so that "everything works". But because the default
> configuration is all messed up there is no easy way for me to do that,
> because once I have a .config that has all the new options enabled the
> corresponding defconfig has a huge diff compared to the default and it
> takes a ridiculous amount of work to sort out the actual changes.
>
> I doubt that I'm the only one in that position and I think this has the
> potential to make things a little easier for everyone contributing to
> this default configuration.
>
>> > > In fact, most of this patch is pure churn - it's merely moving options
>> > > about.  It provides very little in the way of useful benefit for its
>> > > size.  We need to do better than this.
>> > 
>> > Yes, I know. In fact I stated that in the commit message. But this
>> > really should be a one-time thing.
>> 
>> The fact is, this won't be a one-time thing.  People will continue to
>> add options in random places in these files, and we'll need to "fix"
>> it with useless churn yet again, and again, and again.
>
> Like I said, this file should only ever get modified via the ARM SoC
> tree and hence we should be able to enforce proper updates.
>
>> > If we make it easy for people to
>> > properly update the default configuration there will be less churn
>> > further down the road. The changes that end up in multi_v7 default
>> > configuration patches should be what's generated from the defconfig
>> > output. So unless options get removed from Kconfig there should not
>> > be any unnecessary churn subsequently.
>> 
>> I think you're living in an ideal world...
>> 
>> > As for changes that move options in Kconfig, I think those should be
>> > discouraged. The sane thing to do is order them alphabetically, which
>> > will remove any need to move things around.
>> 
>> ... which is why you re-ordered drivers/gpu/drm/Kconfig, moving
>> bridge/Kconfig after the panel Kconfig, which now resulted in this
>> churn in _this_ churn filled patch:
>> 
>>  CONFIG_DRM=y
>>  # CONFIG_DRM_I2C_CH7006 is not set
>>  # CONFIG_DRM_I2C_SIL164 is not set
>> -CONFIG_DRM_NXP_PTN3460=m
>> -CONFIG_DRM_PARADE_PS8622=m
>>  CONFIG_DRM_NOUVEAU=m
>>  CONFIG_DRM_EXYNOS=m
>> ...
>>  CONFIG_DRM_PANEL_SIMPLE=y
>> +CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=m
>> +CONFIG_DRM_NXP_PTN3460=m
>> +CONFIG_DRM_PARADE_PS8622=m
>>  CONFIG_FB_ARMCLCD=y
>
> The reason for those changes were that bridge drivers were completely
> randomly added in Kconfig. That should've never happened in the first
> place and the changes you mentioned are actually supposed to prevent
> this kind of random additions in the future and keep things properly
> sorted.
>
>> > > > diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
>> > > > index 03deb7fb35e8..56775eb9b9cc 100644
>> > > > --- a/arch/arm/configs/multi_v7_defconfig
>> > > > +++ b/arch/arm/configs/multi_v7_defconfig
>> > > > @@ -12,7 +12,6 @@ CONFIG_MODULE_UNLOAD=y
>> > > >  CONFIG_PARTITION_ADVANCED=y
>> > > >  CONFIG_CMDLINE_PARTITION=y
>> > > >  CONFIG_ARCH_VIRT=y
>> > > > -CONFIG_ARCH_ALPINE=y
>> > > >  CONFIG_ARCH_MVEBU=y
>> > > >  CONFIG_MACH_ARMADA_370=y
>> > > >  CONFIG_MACH_ARMADA_375=y
>> > > > @@ -20,14 +19,15 @@ CONFIG_MACH_ARMADA_38X=y
>> > > >  CONFIG_MACH_ARMADA_39X=y
>> > > >  CONFIG_MACH_ARMADA_XP=y
>> > > >  CONFIG_MACH_DOVE=y
>> > > > +CONFIG_ARCH_ALPINE=y
>> > > 
>> > > This option has moved, and the above two changes are therefore nothing
>> > > but churn.
>> > [...]
>> > 
>> > This and all the below I know already. I went through each and every one
>> > of these options and checked what happened to them. Those listed in the
>> > commit message are the ones that have actually changed. Those not listed
>> > are the ones that have only moved around.
>> 
>> Right, so from me this patch gets a NAK, because it's mostly churn
>> with very little benefit.
>> 
>> Linus has threatened to remove the defconfigs in the past for this
>> kind of stupid churn.  For me to say anything else about this would
>> be re-inviting their removal.
>
> Like I said, I consider the churn a mostly one-time thing. But keeping
> this file properly up to date is going to help prevent it from becoming
> stale and crufty.

As one of the maintainers of multi_v7_defconfig, I'm fully supportive of
avoiding the growing cruftyness of this file, and making it more
maintainable, especially because we have a better opportunity to enforce
it.  IMO, there's a big difference between churn and cleanup for better
maintainability.

Also, I think we've already signficantly cleaned up the ARM defconfig
space compared to when Linus complainted about the churn there.  We're
(mostly) down to the multi*config files and then one sub-arch specific
defconfig per platform, and personally, I don't see a huge amount of
churn there:

$ git diff --shortstat v3.10..v4.3-rc1 arch/arm/configs/
 99 files changed, 3830 insertions(+), 3348 deletions(-)

In fact, one of the ways to continue removing sub-arch specific
defconfigs is to make multi_v7 usable for more platforms, and part of
that is cleaning it up so future changes easier and cause less churn.

If we're really worried about churn, we might need to look elsewhere  ;)

$ git diff --shortstat v3.10..v4.3-rc1 arch/arm/boot/dts/
 1157 files changed, 256438 insertions(+), 19699 deletions(-)

Kevin
