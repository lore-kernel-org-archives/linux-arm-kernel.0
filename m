From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Tue, 17 Jun 2014 08:08:29 +0530
Subject: [PATCH v2 2/3] arm: exynos: Add MCPM call-back functions
In-Reply-To: <20140423161325.GB1243@e102568-lin.cambridge.arm.com>
References: <1397239311-27717-6-git-send-email-a.kesavan@samsung.com>
 <1398147435-3122-1-git-send-email-a.kesavan@samsung.com>
 <535650AE.90501@linaro.org>
 <alpine.LFD.2.11.1404221129150.980@knanqh.ubzr>
 <5356C134.8070707@linaro.org>
 <alpine.LFD.2.11.1404221540540.980@knanqh.ubzr>
 <20140423161325.GB1243@e102568-lin.cambridge.arm.com>
Message-ID: <CAM4voa=Lv3xpHfHVcua1jpajEY1XPrXKK=vS4-_3r+etmB4DDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

On Wed, Apr 23, 2014 at 9:43 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Tue, Apr 22, 2014 at 08:56:23PM +0100, Nicolas Pitre wrote:
>>
>> [ Moved Lorenzo up in the addressee list to get his attention ]
>
> Sorry for the delay in replying.
>
>> On Tue, 22 Apr 2014, Daniel Lezcano wrote:
>>
>> > On 04/22/2014 05:40 PM, Nicolas Pitre wrote:
>> > > On Tue, 22 Apr 2014, Daniel Lezcano wrote:
>> > >
>> > > > On 04/22/2014 08:17 AM, Abhilash Kesavan wrote:
>> > > > > +/*
>> > > > > + * The common v7_exit_coherency_flush API could not be used because of the
>> > > > > + * Erratum 799270 workaround. This macro is the same as the common one (in
>> > > > > + * arch/arm/include/asm/cacheflush.h) except for the erratum handling.
>> > > > > + */
>> > > > > +#define exynos_v7_exit_coherency_flush(level) \
>> > > > > +     asm volatile( \
>> > > > > +     "stmfd  sp!, {fp, ip}\n\t"\
>> > > > > +     "mrc    p15, 0, r0, c1, c0, 0   @ get SCTLR\n\t" \
>> > > > > +     "bic    r0, r0, #"__stringify(CR_C)"\n\t" \
>> > > > > +     "mcr    p15, 0, r0, c1, c0, 0   @ set SCTLR\n\t" \
>> > > > > +     "isb\n\t"\
>> > > > > +     "bl     v7_flush_dcache_"__stringify(level)"\n\t" \
>> > > > > +     "clrex\n\t"\
>> > > > > +     "mrc    p15, 0, r0, c1, c0, 1   @ get ACTLR\n\t" \
>> > > > > +     "bic    r0, r0, #(1 << 6)       @ disable local coherency\n\t" \
>> > > > > +     /* Dummy Load of a device register to avoid Erratum 799270 */ \
>> > > >
>> > > > Wouldn't make sense to add the erratum in the Kconfig and re-use it in the
>> > > > generic v7_exit_coherency_flush macro instead of redefining it ?
>> > >
>> > > The implementation of the erratum (the dummy device register load) is
>> > > platform specific I'm afraid.
>> > >
>> > > Is TC2 also concerned by this erratum, or is this Samsung specific?
>> >
>> > Sounds like it is ARM Cortex-A15MP specific:
>> >
>> > http://infocenter.arm.com/help/topic/com.arm.doc.epm028090/cortex_a15_mpcore_software_developers_errata_notice_r2_v12.pdf
>> >
>> > Page 31.
>>
>> The condition for hitting the erratum is: "The L2 cache block has been
>> idle for 256 or more cycles with no memory requests from any core, no
>> external snoops, and no ACP requests".
>>
>> Given that the operation that almost immediately precedes the
>> problematic mcr is a call to v7_flush_dcache_louis or
>> v7_flush_dcache_all, is this possible that the condition for the erratum
>> could ever be met?
>
> Yes, if we execute out of the I-cache (no-data accesses) I think this might be
> triggered.
>
> On a side note, the errata affects also the setting of SMP bit
> (__v7_ca15mp_setup and cpu_v7_do_resume) but we do nothing there (it
> is a different situation though, MMU there is off and D-cache off...but
> I-cache is allowed to be on, so I am actually checking if we should be doing
> something there too).
>
>> If no then we should document that v7_exit_coherency_flush(() is safe
>> against erratum 799270 and use it here.
>
> Eh, I wish we could use it safely, I am currently investigating and will get
> back to you asap.

Have you been able to come to a conclusion regarding the necessity of
the erratum workaround ? We are currently carrying the workaround in
the merged exynos back-end.

Regards,
Abhilash
>
> Lorenzo
>
>> > > > > +     "ldr    r4, [%0]\n\t" \
>> > > > > +     "and    r4, r4, #0\n\t" \
>> > > > > +     "orr    r0, r0, r4\n\t" \
>> > > > > +     "mcr    p15, 0, r0, c1, c0, 1   @ set ACTLR\n\t" \
>> > > > > +     "isb\n\t" \
>> > > > > +     "dsb\n\t" \
>> > > > > +     "ldmfd  sp!, {fp, ip}" \
>> > > > > +     : \
>> > > > > +     : "Ir" (S5P_INFORM0) \
>> > > > > +     : "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7", \
>> > > > > +       "r9", "r10", "lr", "memory")
>> > > >
>>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
