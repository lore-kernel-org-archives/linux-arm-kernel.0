From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 8 Dec 2010 11:25:58 +0000
Subject: [PATCH v2 2/3] ARM: omap4: Correct definition of do_wfi()
	forCONFIG_THUMB2_KERNEL
In-Reply-To: <df00a773077a1dac38b7e6b67190d8f9@mail.gmail.com>
References: <1291656937-24992-1-git-send-email-dave.martin@linaro.org>
	<1291656937-24992-3-git-send-email-dave.martin@linaro.org>
	<a86d8e4b47fad17e71d0202f3c469868@mail.gmail.com>
	<AANLkTinPifchS23j5EdrhMBNNdtEfF_KmX=AE9tUiiL=@mail.gmail.com>
	<2080abb418a8d3c651dd41353ef59d25@mail.gmail.com>
	<d9fec68fc0ce14215439c6e753871bc2@mail.gmail.com>
	<AANLkTim-tdF83gnQ-0o0i7bp7QmQHoT_KbZMHrWTE12g@mail.gmail.com>
	<289b46ad4e4f4a05b6636134e446010c@mail.gmail.com>
	<AANLkTi=OC4ydAtrxNK4Jd_CDo9eLayRusOm9CNM_JFei@mail.gmail.com>
	<df00a773077a1dac38b7e6b67190d8f9@mail.gmail.com>
Message-ID: <AANLkTinhmX_mhFAbE+CEmX+TBDn_F6O+KG01L4VqSB2t@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 8, 2010 at 11:10 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
>> -----Original Message-----
>> From: Dave Martin [mailto:dave.martin at linaro.org]
>> Sent: Wednesday, December 08, 2010 4:35 PM
>> To: Santosh Shilimkar
>> Cc: Tony Lindgren; linux-omap at vger.kernel.org; linaro-
>> dev at lists.linaro.org; linux-arm-kernel at lists.infradead.org
>> Subject: Re: [PATCH v2 2/3] ARM: omap4: Correct definition of do_wfi()
>> forCONFIG_THUMB2_KERNEL
>>
>> On Wed, Dec 8, 2010 at 10:45 AM, Santosh Shilimkar
>> <santosh.shilimkar@ti.com> wrote:
>> >> -----Original Message-----
>> >> From: Dave Martin [mailto:dave.martin at linaro.org]
>> >> Sent: Wednesday, December 08, 2010 4:11 PM
>> >> To: Santosh Shilimkar
>> >> Cc: linux-arm-kernel at lists.infradead.org; Tony Lindgren; linux-
>> >> omap at vger.kernel.org; linaro-dev at lists.linaro.org
>> >> Subject: Re: [PATCH v2 2/3] ARM: omap4: Correct definition of
> do_wfi()
>> >> forCONFIG_THUMB2_KERNEL
>> >>
>> >> On Wed, Dec 8, 2010 at 5:59 AM, Santosh Shilimkar
>> >> <santosh.shilimkar@ti.com> wrote:
>> >> > Dave,
>> >> >
>> >> >> -----Original Message-----
>> >> >> From: Santosh Shilimkar [mailto:santosh.shilimkar at ti.com]
>> >> >> Sent: Wednesday, December 08, 2010 11:27 AM
>> >> >> To: Dave Martin
>> >> >> Cc: linux-arm-kernel at lists.infradead.org; Tony Lindgren; linux-
>> >> >> omap at vger.kernel.org; linaro-dev at lists.linaro.org
>> >> >> Subject: RE: [PATCH v2 2/3] ARM: omap4: Correct definition of
>> > do_wfi()
>> >> >> forCONFIG_THUMB2_KERNEL
>> >> >>
>> >> >> > -----Original Message-----
>> >> >> > From: Dave Martin [mailto:dave.martin at linaro.org]
>> >> >> > Sent: Tuesday, December 07, 2010 10:21 PM
>> >> >> > To: Santosh Shilimkar
>> >> >> > Cc: linux-arm-kernel at lists.infradead.org; Tony Lindgren; linux-
>> >> >> > omap at vger.kernel.org; linaro-dev at lists.linaro.org
>> >> >> > Subject: Re: [PATCH v2 2/3] ARM: omap4: Correct definition of
>> >> do_wfi()
>> >> >> > forCONFIG_THUMB2_KERNEL
>> >> >> >
>> >> >> > Hi,
>> >> >> >
>> >> >> > On Tue, Dec 7, 2010 at 6:28 AM, Santosh Shilimkar
>> >> >> > <santosh.shilimkar@ti.com> wrote:
>> >> >> > > Dave,
>> >> >
>> >> > [.....]
>> >> >>
>> >> >> > So anything inside #ifdef CONFIG_THUMB2_KERNEL can assume
>> > v7/Thumb-2
>> >> >> > capable (and hence reasonably new) tools.
>> >> >> >
>> >> >> > I'll follow up shortly with a patch to the generic ARM Kconfig
> to
>> >> make
>> >> >> > this explicit, so that ARCH_OMAP2 and THUMB2_KERNEL can't
>> >> accidentally
>> >> >> > be configured together.
>> >> >> >
>> >> >> sure
>> >> >
>> >> > When you are doing the changes can you please check if you could
>> build
>> >> > the THUMB2 kernel with omap2plus_defconfig. I suspect the build
> will
>> >> > fail.
>> >>
>> >> With my Kconfig patch, kconfig won't let you turn on Thumb-2 in that
>> >> configuration:
>> >>
>> >>
>> >
>>
> http://lists.arm.linux.org.uk/lurker/message/20101207.165737.0897658f.en.h
>> >> tml
>> >>
>> >> If you want to turn on Thumb-2, you must disable ARCH_OMAP2 first.
> ?If
>> >> my understanding is correct, this is the right behaviour.
>> >>
>> >>
>> > Ofcourse it will build with ARCH_OMAP2 disabled :) (ARMv6 dependency)
>> > In other words, I wanted to say that "omap2plus_defconfig" can't
>> > be used as is to build THUMB kernel binary.
>>
>> Well, yes, that's another way of looking at it. ?Anyway, I think this
>> is the intended result -- is it OK for you?
>>
> Should be ok considering you can't do much with it. But I let Tony comment
> on it.

Well, it depends on what you're trying to do.  We can't combine
Thumb-2 with a combined omap kernel intended to support omap2.  But in
linaro for example we are targeting v7+ only for the kernel and
userspace, so we already build the kernel for v7 and don't include the
OMAP2 support; instead we target OMAP3/4.  I believe the situation for
Ubuntu is similar.  In our case, including the omap2 support wouldn't
be useful, since the userspace won't run on that platform anyway...

So really, my concerns are that a) the generic rules for
CONFIG_THUMB2_KERNEL are correct, and b) the omap tree works well with
this configuration to the maximum extent possible.  Obviously, mixing
ARCH_OMAP2 with THUMB2_KERNEL _isn't_ possible even in theory, so I
don't consider it a failure if that combination isn't supported.

Cheers
---Dave
