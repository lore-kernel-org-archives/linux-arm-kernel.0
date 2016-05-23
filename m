From: rafael@kernel.org (Rafael J. Wysocki)
Date: Mon, 23 May 2016 22:16:41 +0200
Subject: Crash after 'reboot' due to 9be4fd2c7723a
In-Reply-To: <20160523182807.GY19428@n2100.arm.linux.org.uk>
References: <CAOMZO5A62LgnyT0sQw5N-xeHaD0nSGTjAFxUx=_6OpUm02robA@mail.gmail.com>
 <CAJZ5v0hX1dZ+79-KCyumf57o02WKivxcRLJ1Zi8akrqu_2CZEQ@mail.gmail.com>
 <CAOMZO5CD08cX0yDBZTdFV+iwgr__fjSaaWvgjimotr5L1yrbaQ@mail.gmail.com>
 <2148724.oQlEHos3jS@vostro.rjw.lan>
 <20160523182807.GY19428@n2100.arm.linux.org.uk>
Message-ID: <CAJZ5v0ipPVsZmu+RVfrPChA7banMGFNsfMt=if0V3XfVdstRNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 23, 2016 at 8:28 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Sat, May 21, 2016 at 02:56:20AM +0200, Rafael J. Wysocki wrote:
>> The root of the problem seems to be arch_irq_work_raise() and specifically
>> the __smp_cross_call function that appears to have problems.
>
> We've been through this before.  The bottom line is that on ARM, there
> is major wide-spread understanding that we want to be able to run a
> kernel compiled for SMP on uniprocessor hardware.
>
> This is something that's been going for years, and has worked fine for
> years.
>
> Now, someone has introduced this irq work stuff.  Great.  But they
> haven't considered that people want to be able to run a SMP kernel
> on UP hardware which _may_ have no hardware present which is capable
> of raising IPIs.
>
> I don't know what the situation is with the platform concerned here,
> I don't know whether it uses the GIC (presumably, because it doesn't
> NULL-pointer ref on calling smp_cross_call(), it is using the GIC.)
> If so, the GIC isn't delivering the IPI because the IPI hardware is
> missing.
>
> Now, whether we could detect whether the GIC is IPI capable, I've
> no idea, I don't have such a platform I could run tests on.  People
> don't give me hardware anymore now that arm-soc is split off from
> core ARM maintanence - it all goes into Linaro build farms.  So I'm
> powerless to help here.
>
> My attitude towards this is that it's a core kernel problem: the
> core kernel is assuming that it can raise IPIs even on non-SMP
> capable hardware.  Much non-SMP hardware doesn't have that ability.
> While folk can try to push it into arch code, my feeling is that it
> really needs to have a generic solution, even if it's some generic
> solution that architectures in this situation can plug into.

Well, this particular case isn't about IPIs at all.

irq_work_queue() can work without IPIs and it works like that on other
ARM platforms where SMP kernels are run on UP hardware (without IPI
support).

Something seems to be missing in kernel config or similar here, but I
can't really say what it is right away.
