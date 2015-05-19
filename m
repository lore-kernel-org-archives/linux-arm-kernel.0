From: lznuaa@gmail.com (Zhi Li)
Date: Tue, 19 May 2015 10:52:23 -0500
Subject: [PATCH 1/2] ARM: imx: enable smp for i.MX7D
In-Reply-To: <20150519150852.GI2067@n2100.arm.linux.org.uk>
References: <1431378955-991-1-git-send-email-Frank.Li@freescale.com>
 <20150519025758.GK1071@dragon>
 <CAHrpEqTwwb0P1wE+AOYVPgPz8=tBbEKn92amWaoN63GPOJxRgw@mail.gmail.com>
 <20150519150852.GI2067@n2100.arm.linux.org.uk>
Message-ID: <CAHrpEqSGQ4G-nkCporLee5fw0fFtB5+m3dJK2dGdYDd2R+rKrw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 19, 2015 at 10:08 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, May 19, 2015 at 09:52:54AM -0500, Zhi Li wrote:
>> On Mon, May 18, 2015 at 9:57 PM, Shawn Guo <shawnguo@kernel.org> wrote:
>> >> diff --git a/arch/arm/mach-imx/headsmp.S b/arch/arm/mach-imx/headsmp.S
>> >> index de5047c..95467c7 100644
>> >> --- a/arch/arm/mach-imx/headsmp.S
>> >> +++ b/arch/arm/mach-imx/headsmp.S
>> >> @@ -29,3 +29,8 @@ ENTRY(v7_secondary_startup)
>> >>       set_diag_reg
>> >>       b       secondary_startup
>> >>  ENDPROC(v7_secondary_startup)
>> >> +
>> >> +ENTRY(ca7_secondary_startup)
>> >> +     bl      v7_invalidate_l1
>> >> +     b       secondary_startup
>> >> +ENDPROC(ca7_secondary_startup)
>> >
>> > v7_secondary_startup doesn't work for you?
>>
>> Yes,
>> v7_secondary_startup check debug register and cause halt.
>
> A better question is, why do we have the diagnostic register setting at
> platform level... and should we move it into the core SMP code so that
> we can guarantee that all CPUs are setup the same.  I guess there are
> problems on big.LITTLE systems where we have to deal with different CPU
> types.

This code was added in below commit. I agree it is good at moving into
the core SMP
Code. But this patch just want to enable smp at i.MX7 only.

commit 087bb28329f3ccda4e50cb4cf297542d7e773e20
Author: Shawn Guo <shawn.guo@linaro.org>
Date:   Tue Apr 16 22:11:19 2013 +0800

    ARM: imx: replicate the diagnostic register of boot cpu into secondary cores

    The diagnostic register holds the errata bits.  Mostly bootloader
    does not bring up secondary cores, so that when errata bits are set
    in bootloader, they are set only for boot cpu.  But on a SMP
    configuration, it should be equally done on every single core.
    Set up the diagnostic register for secondary cores by replicating
    the register from boot cpu.

    Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
    Acked-by: Dirk Behme <dirk.behme@de.bosch.com>

>
> A separate issue is the v7_invalidate_l1, and looking at this again, I
> wonder whether the v7_flush_dcache_louis in __v7_setup is really the
> right thing to be doing there.  At that point, the caches are disabled,
> so we're not using them.  Any dirty cache lines at that point would be
> inaccessible to the CPU, and so would be a bug.

But why we have to do that. I remember we meet random crash without
v7_invalidate_l1.

> I think that should
> become v7_invalidate_l1, which would then elimiante all the platforms
> which are doing this local hack.

I think this is good.
What can I do for this patch?

>
> In fact, on CPUs prior to ARMv6, we have always invalidated the caches,
> rather than asking them to write back dirty cache lines.
>
> --
> FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
> according to speedtest.net.
