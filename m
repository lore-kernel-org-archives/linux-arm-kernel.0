From: ccross@google.com (Colin Cross)
Date: Mon, 6 Aug 2012 13:41:06 -0700
Subject: [PATCH] ARM: formalize an IPI for CPU wake-ups
In-Reply-To: <037601cd6fc9$f6e5fe30$e4b1fa90$%kim@samsung.com>
References: <alpine.LFD.2.02.1206111152190.23555@xanadu.home>
 <20120611155716.GA18267@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1206111241470.23555@xanadu.home>
 <20120611165115.GB18267@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1206111307550.23555@xanadu.home>
 <4FD62DBB.8070407@codeaurora.org>
 <20120611192519.GF18267@n2100.arm.linux.org.uk>
 <4FE1FB15.3090305@codeaurora.org>
 <0e0201cd5f2f$2c2f6e60$848e4b20$%kim@samsung.com>
 <5016D03D.8010607@codeaurora.org>
 <037601cd6fc9$f6e5fe30$e4b1fa90$%kim@samsung.com>
Message-ID: <CAMbhsRRp429Fkk2-vEixt8OPW699ftVCaG+C83NWLvM2_jkOVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 1, 2012 at 2:42 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Stephen Boyd wrote:
>>
>> On 07/10/12 23:34, Kukjin Kim wrote:
>> > Stephen Boyd wrote:
>> >> Great. Kukjin Kim, can exynos use SGI0? It looks like exynos is the
>> only
>> >> one left to move to SGI0.
>> >>
>> > Yeah, EXYNOS can use SGI0 instead of SGI1 :)
>> >
>> >
>>
>> Russell, can we apply something like this?
>>
> Please feel free to add my ack on following change.
>
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
>

When testing coupled cpuidle on Exynos5, I found that sending an IPI
does not successfully wake up CPU1.  CPU1 is in a wfe with interrupts
masked, not a wfi, so an interrupt is not able to wake it up.  It
tends to wake up anyways because the next time a spin lock is
unlocked, often during a timer interrupt on CPU0, CPU0 executes an sev
which wakes up CPU1.  You can see that the IPI is unnecessary by
removing the gic_raise_softirq and replacing it with dsb_sev().
