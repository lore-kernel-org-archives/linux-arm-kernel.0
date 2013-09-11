From: coosty@163.com (cini)
Date: Wed, 11 Sep 2013 08:58:44 +0800 (CST)
Subject: [PATCH ] ARM: sunxi: Add Emac,SMP and Arch_timer support for
 sunxi A20;Add phy cnt arch timer for ARMv7 support.
In-Reply-To: <522F6964.9060603@elopez.com.ar>
References: <16b7467c.1f121.141089f3d81.Coremail.coosty@163.com>
 <522F6964.9060603@elopez.com.ar>
Message-ID: <22532daa.1421.1410a870d46.Coremail.coosty@163.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>Hi,
>
>El?10/09/13?13:05,?cini?escribi?:
>>
>>?It?has?been?tested?on?a?Cubieboard?2.?To?use?SMP?you?must?set?ARM_ARCH_TIMER?and?ARM_ARCH_TIMER_USE_PHYCNT?when?make?xconfig.
>>?If?you?have?any?questions?or?comments?please?feel?free?to?contact?me.??Have?a?wonderful?day!
>
>First?of?all,?thanks?for?working?on?this!?It?is?very?much?appreciated?:)
>
>Having?said?that,?it?would?be?nice?to?get?properly?split?git?patches,?
>with?a?description?and?signoff?tag.?You?can?read?
>Documentation/SubmittingPatches?on?the?kernel?tree?(I?think?it's?a?bit?
>outdated,?but?it?covers?the?basics),?or?watch?this?video?from?Greg?which?
>explains?it?nicely:
>
>https://www.youtube.com/watch?v=LLBrBBImJt4
>
Thanks for your response.This is my first patch.I will notice the problem you said.

>>?#?On?branch?master
>>?#?Changes?to?be?committed:
>>?#???(use?"git?reset?HEAD?<file>..."?to?unstage)
>>?#
>>?#	new?file:???arch/arm/mach-sunxi/headsmp.S
>>?#	new?file:???arch/arm/mach-sunxi/platform.h
>>?#	new?file:???arch/arm/mach-sunxi/platsmp.c
>
>I?couldn't?find?these?files?on?either?of?your?emails?by?the?way
>
Sorry for thar, I check the patch. as you said,the new files can not found,I will update a new patch including the new files later.?

>Is?this?frequency?correct??I?thought?A20?cores?ran?on?900-something?MHz
A20 manual said the cpu can run 1.2G.


>
>This?will?certainly?not?play?nice?with?multiplatform?kernel.?Is?this?
>something?we?can?fix?on?u-boot?to?use?the?virtual?count?timer?as?the?
>rest?of?the?platforms?do?
>
>Cheers,
>
>EmilioYes,
you are right,Phy Count Register can not be accessed in Non-secure PL1 mode when register CNTHCTL.PL1PCTEN=0.So we can set CNTHCTL.PL1PCTEN=1 in bootloader then ?other multiplatform?kernel should run ok with phy count in any mode.
If kernel want use ?virtual count timer ,bootloader should set register CNTVOFF=0.On the other way,I think we can get a new nvct= vct-vntvoff as clksource, then kernel can work well even if?CNTVOFF does not set to zero ?by bootload, I will give the patch later.?
