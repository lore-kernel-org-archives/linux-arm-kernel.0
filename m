From: olof@lixom.net (Olof Johansson)
Date: Mon, 17 Jun 2013 15:21:11 -0700
Subject: [PATCH 1/3] ARM: mach-moxart: add MOXA ART SoC files
In-Reply-To: <CACmBeS1xNgc=TN3ZdhhHS0K+SMU+Zc1cvH7VXQHiTye=Ufoj8Q@mail.gmail.com>
References: <1371040448-28742-1-git-send-email-jonas.jensen@gmail.com>
 <1371040448-28742-2-git-send-email-jonas.jensen@gmail.com>
 <20130612224235.GA8146@quad.lixom.net>
 <CACmBeS1xNgc=TN3ZdhhHS0K+SMU+Zc1cvH7VXQHiTye=Ufoj8Q@mail.gmail.com>
Message-ID: <20130617222111.GA13266@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jun 14, 2013 at 04:33:29PM +0200, Jonas Jensen wrote:
> Hi,
> 
> Thanks for the replies.
> 
> What isn't commented below should already be fixed. I'll resubmit the
> entire set when it looks like there's nothing left to amend.
> 
> On 13 June 2013 00:42, Olof Johansson <olof@lixom.net> wrote:
> > You should provide a commit message, ideally with a short introduction of the
> > platform.
> 
> Will do. I was thinking I should do that, this is the first time I
> used git format-patch / git send-email.
> 
> >> +++ b/arch/arm/configs/moxart_uc7112lx_defconfig
> >
> > It'd be nice to keep the defconfig generic, and make sure to enable all boards
> > in it -- we're generally OK with adding one defconfig per platform upstream but
> > not more.
> 
> Since MACH_UC7112LX is the only board right now, how can it "enable all boards"?

Yeah, that was more with respect to future use of the defconfig. So keeping it
generic in name for now (moxart_defconfig) is really all I am asking for.

> One way I can think of is to remove CONFIG_MACH_UC7112LX=y from
> defconfig and have it (and all future boards) "default y" in
> arch/arm/mach-moxart/Kconfig.

Enabling it in the defconfig is just fine, no need to change anything there at
this time.

> I focus on a single hardware, UC-7112-LX. There's at least one more
> board with only minor differences (RAM / flash size). But for now,
> MACH_UC7112LX is the one I have access to and can test. I think
> UC-7110 is already supported, that it would boot, just copy
> arch/arm/boot/dts/moxart-uc7112lx.dts and modify ranges for RAM and
> MTD. I want to leave this in a state where remaining hardware can
> easily be added, albeit by someone that isn't me :)

Sure, that's a fair stance.

> > If you multiplatform enable this, then you need to have a check in
> > moxart_idle_init() to make sure you're running on a moxart soc. Otherwise this
> > will still be called and override the arm_pm_idle setting on other platforms as
> > well.
> 
> I can't find a good example of how other platforms do this, is a DT
> lookup an accepted solution? :
> 
> static const struct of_device_id moxart_match[] = {
>        { .compatible = "moxa,moxart" },
>        { }
> };
> 
> static int __init moxart_idle_init(void)
> {
>     struct device_node *node;
> 
>     node = of_find_matching_node(NULL, moxart_match);
>     if (!node)
>         return -ENODEV;
> 
>     arm_pm_idle = moxart_idle;
>     return 0;
> }
> 
> arch_initcall(moxart_idle_init);

Easiest of all is if you have a "moxa,moxart" compatible field as the
most-specific one for your machine, then you can just do:

...
{
	if (!of_machine_is_compatible("moxa,moxart"))
		return -ENODEV;

	arm_pm_idle = moxart_idle;
	return 0;
}

-Olof
