From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 7 Jan 2011 21:15:02 +0800
Subject: Bug in arch-mmp board selection
In-Reply-To: <AANLkTi=SX-KmcmP-cNN-59D+rSABQmSHEPQaYF0WFbGg@mail.gmail.com>
References: <AANLkTi=SX-KmcmP-cNN-59D+rSABQmSHEPQaYF0WFbGg@mail.gmail.com>
Message-ID: <AANLkTimCasesYnoGL1tYX-Lz9fhk4im1bg_ntKrkO-bC@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 5, 2011 at 12:57 PM, Mark F. Brown <mark.brown314@gmail.com> wrote:
> Hi Eric,
>
> PXA168 and PXA910 are based on PJ1 which is an ARMv5 compatible architecture
> MMP2 is a based on PJ4 which configured as ARMv6 currently (there are
> ARMv7 versions as well)
>
> Currently all SoCs are selectable under the "PXA168/910/MMP2" menu
> option which allows you to then select PXA168, PXA910, and MMP2 boards
> for one image. If you build this configuration this error occurs:
>
> ?AS ? ? ?arch/arm/kernel/entry-armv.o
> arch/arm/kernel/entry-armv.S: Assembler messages:
> arch/arm/kernel/entry-armv.S:212: Error: selected processor does not
> support `clrex'
> arch/arm/kernel/entry-armv.S:244: Error: selected processor does not
> support `clrex'
> arch/arm/kernel/entry-armv.S:302: Error: selected processor does not
> support `clrex'
> arch/arm/kernel/entry-armv.S:338: Error: selected processor does not
> support `clrex'
> make[1]: *** [arch/arm/kernel/entry-armv.o] Error 1
> make: *** [arch/arm/kernel] Error 2
>
> I am aware we can resolve this by adding KConfig rules to prevent this
> scenario, but it leads to a deeper question. Why does selecting the
> board in turn select the CPU type instead of the user enabling the CPU
> type and then providing a set of boards for selection?
>

Because the board knows which SoC it's using, and the logic behind
this is - if you select the board, the board select everything else applicable.

And you are right, it's not able to select all boards in mach-mmp/ to
make them built into a single image at this moment. However, that's
possible theoretically. And that's the reason I'm keeping two separate
_defconfig for pxa168_ and mmp2_.

> e.g.
> config MACH_ZYLONITE2
> ? ? ? ?bool "Marvell's PXA168 Zylonite2 Development Board"
> ? ? ? --> select CPU_PXA168
>
