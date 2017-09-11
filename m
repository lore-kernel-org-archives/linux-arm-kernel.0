From: horms@verge.net.au (Simon Horman)
Date: Mon, 11 Sep 2017 09:39:36 +0200
Subject: [PATCH v3 0/3] ARM: renesas: Enable SMP on R-Car E2
In-Reply-To: <20170901084243.GB14918@verge.net.au>
References: <1504255066-5103-1-git-send-email-geert+renesas@glider.be>
 <20170901084243.GB14918@verge.net.au>
Message-ID: <20170911073936.GA19090@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 01, 2017 at 10:42:44AM +0200, Simon Horman wrote:
> On Fri, Sep 01, 2017 at 10:37:43AM +0200, Geert Uytterhoeven wrote:
> >         Hi all,
> > 
> > This patch series enables SMP on R-Car E2 (r8a7794).
> > The main hurdle here is that R-Car Gen2 boot loaders do not initialize the
> > arch_timer CNTVOFF register, which thus needs workarounds on Linux.
> > 
> >   - The first patch adds a definition for MON_MODE, as suggested by Marc
> >     Zyngier,
> >   - The second patch makes sure CNTVOFF is initialized for boot and
> >     secondary Cortex-A15 and Cortex-A7 CPU cores, like is already done
> >     for the boot Cortex-A7 CPU core.  Without this, the ARM arch timer
> >     does not work on secondary CPU cores.
> >     This patch depends on "[PATCH v2] ARM: shmobile: rcar-gen2: Correct
> >     arch timer frequency on RZ/G1E".
> >   - The third patch adds the required infrastructure (APMU device node
> >     and corresponding enable-method) to DT.
> >     Obviously this must not be applied on a branch that does not contain
> >     the first two patches!
> > 
> > Due to dependencies, I think it is easiest if the ARM maintainers provide
> > their Acked-by for patch 1, so the whole series can go in through Simon's
> > Renesas tree.
> 
> Thanks Geert, this merge strategy is fine by me.

This patch-set has been floating around one form or another for quite
some time now and this version is now well over a week old.

I've gone ahead and applied the first two patches for v4.15:
* ARM: Add definition for monitor mode
* ARM: shmobile: rcar-gen2: Make sure CNTVOFF is initialized on CA7/15

I will push those to the devel branch of the renesas tree later today.

I would like to deffer the third and last patch until v4.16 to avoid
an awkward branch dependency on the above - the branches are different
even though the tree is the same. Please resubmit this patch once the
above dependencies are present in an rc release, which at this stage
I expect to be v4.15-rc1.

* ARM: dts: r8a7794: Add SMP support
