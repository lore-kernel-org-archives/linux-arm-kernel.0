From: tony@atomide.com (Tony Lindgren)
Date: Fri, 23 Nov 2012 12:32:27 -0800
Subject: [PATCH] ARM: implement optimized percpu variable access
In-Reply-To: <20121122113401.GC3113@mudshark.cambridge.arm.com>
References: <1352604040-10014-1-git-send-email-robherring2@gmail.com>
 <20121122113401.GC3113@mudshark.cambridge.arm.com>
Message-ID: <20121123203226.GF5279@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Will Deacon <will.deacon@arm.com> [121122 03:43]:
> Hi Rob,
> 
> On Sun, Nov 11, 2012 at 03:20:40AM +0000, Rob Herring wrote:
> > From: Rob Herring <rob.herring@calxeda.com>
> > 
> > Use the previously unused TPIDRPRW register to store percpu offsets.
> > TPIDRPRW is only accessible in PL1, so it can only be used in the kernel.
> > 
> > This saves 2 loads for each percpu variable access which should yield
> > improved performance, but the improvement has not been quantified.
> > 
> > Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> > ---
> >  arch/arm/include/asm/Kbuild   |    1 -
> >  arch/arm/include/asm/percpu.h |   44 +++++++++++++++++++++++++++++++++++++++++
> >  arch/arm/kernel/smp.c         |    3 +++
> >  3 files changed, 47 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/arm/include/asm/percpu.h
> 
> Russell pointed out to me that this patch will break on v6 CPUs if they don't
> have the thread ID registers and we're running with SMP_ON_UP=y. Looking at
> the TRMs, the only case we care about is 1136 < r1p0, but it does indeed break
> there (I have a board on my desk).

Sounds like it will break all omap2420 based systems like Nokia n8x0 :(

FYI those are booting with omap2plus_defconfig with SMP_ON_UP=y.

Regards,

Tony
