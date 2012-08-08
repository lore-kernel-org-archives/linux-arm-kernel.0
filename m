From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 8 Aug 2012 12:34:54 +0530
Subject: [PATCH] ARM: formalize an IPI for CPU wake-ups
In-Reply-To: <20120807170026.GH18957@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.02.1206111241470.23555@xanadu.home>
 <20120611165115.GB18267@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1206111307550.23555@xanadu.home>
 <4FD62DBB.8070407@codeaurora.org>
 <20120611192519.GF18267@n2100.arm.linux.org.uk>
 <4FE1FB15.3090305@codeaurora.org>
 <0e0201cd5f2f$2c2f6e60$848e4b20$%kim@samsung.com>
 <5016D03D.8010607@codeaurora.org>
 <037601cd6fc9$f6e5fe30$e4b1fa90$%kim@samsung.com>
 <CAMbhsRRp429Fkk2-vEixt8OPW699ftVCaG+C83NWLvM2_jkOVw@mail.gmail.com>
 <20120807170026.GH18957@n2100.arm.linux.org.uk>
Message-ID: <CAMQu2gy7go1MUA4cJtqjtcGc4SADVVTcn5C7gR5UCO_WrCH+pQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 7, 2012 at 10:30 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Aug 06, 2012 at 01:41:06PM -0700, Colin Cross wrote:
>> When testing coupled cpuidle on Exynos5, I found that sending an IPI
>> does not successfully wake up CPU1.  CPU1 is in a wfe with interrupts
>> masked, not a wfi, so an interrupt is not able to wake it up.  It
>> tends to wake up anyways because the next time a spin lock is
>> unlocked, often during a timer interrupt on CPU0, CPU0 executes an sev
>> which wakes up CPU1.  You can see that the IPI is unnecessary by
>> removing the gic_raise_softirq and replacing it with dsb_sev().
>
> That's good news; that supports my assertion that the SMP bringup code
> we see on various platforms as copies from the Realview code was done
> without much thought about what is actually required.
>
> It's good that you're looking into this, and fixing the code on the CPUs
> you have access to.  I rather wish we'd made it a requirement for people
> to _document_ the actual bringup conditions in the kernel for their
> hardware before we accepted their SMP support code.
>
Movement to SGI0 for all ARM platform was also discussed when I
was trying to fix the "Unknown IPI message 0x1" warning with patch [1]

For OMAP too, the SGI0 works.

Regards
Santosh

[1 ] http://lists.infradead.org/pipermail/linux-arm-kernel/2011-January/038430.html
