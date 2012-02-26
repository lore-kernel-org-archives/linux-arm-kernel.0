From: olof@lixom.net (Olof Johansson)
Date: Sun, 26 Feb 2012 13:57:00 -0800
Subject: [PATCH v3 05/10] ARM: tegra: rework Tegra secondary CPU core
 bringup
In-Reply-To: <CAMbhsRRkkjfymL=uDt+phM2sLunbypQRUhjZ=DHSO4y9Ko4NJA@mail.gmail.com>
References: <1328831277-21002-1-git-send-email-pdeschrijver@nvidia.com>
 <1328831277-21002-6-git-send-email-pdeschrijver@nvidia.com>
 <CAMbhsRRkkjfymL=uDt+phM2sLunbypQRUhjZ=DHSO4y9Ko4NJA@mail.gmail.com>
Message-ID: <20120226215700.GC11189@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Feb 20, 2012 at 03:04:57PM -0800, Colin Cross wrote:
> On Thu, Feb 9, 2012 at 3:47 PM, Peter De Schrijver
> <pdeschrijver@nvidia.com> wrote:
> > Prepare the Tegra secondary CPU core bringup code for other Tegra variants.
> > The reset handler is also generalized to allow for future introduction of
> > powersaving modes which turn off the CPU cores.
> >
> > Based on work by:
> >
> > Scott Williams <scwilliams@nvidia.com>
> > Chris Johnson <cwj@nvidia.com>
> > Colin Cross <ccross@android.com>
> >
> > Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> > ---
> <snip>
> 
> > diff --git a/arch/arm/mach-tegra/headsmp.S b/arch/arm/mach-tegra/headsmp.S
> > index b5349b2..7973f1c 100644
> > --- a/arch/arm/mach-tegra/headsmp.S
> > +++ b/arch/arm/mach-tegra/headsmp.S
> 
> <snip>
> 
> > @@ -47,15 +64,116 @@ ENTRY(v7_invalidate_l1)
> > ? ? ? ? mov ? ? pc, lr
> > ?ENDPROC(v7_invalidate_l1)
> >
> > +
> > ?ENTRY(tegra_secondary_startup)
> > - ? ? ? msr ? ? cpsr_fsxc, #0xd3
> > ? ? ? ? bl ? ? ?v7_invalidate_l1
> > - ? ? ? mrc ? ? p15, 0, r0, c0, c0, 5
> > - ? ? ? ?and ? ?r0, r0, #15
> > - ? ? ? ?ldr ? ? r1, =0x6000f100
> > - ? ? ? ?str ? ? r0, [r1]
> > -1: ? ? ?ldr ? ? r2, [r1]
> > - ? ? ? ?cmp ? ? r0, r2
> > - ? ? ? ?beq ? ? 1b
> > + ? ? ? mov32 ? r0, 0xC5ACCE55
> > + ? ? ? mcr ? ? p14, 0, r0, c7, c12, 6
> 
> One minor nit, you should comment that this is enabling coresight.

Since it's trivial, I did it when I applied the patch here instead of having
Peter respin or add it separately.


-Olof
