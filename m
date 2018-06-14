From: nm@ti.com (Nishanth Menon)
Date: Thu, 14 Jun 2018 07:46:58 -0500
Subject: [PATCH 2/4] ARM: Introduce ability to enable invalidate of BTB
 with ICIALLU on Cortex-A15 for CVE-2017-5715
In-Reply-To: <2786d17e-1075-e0fb-1864-fb5900e4a2af@gmail.com>
References: <20180612202411.29798-1-nm@ti.com>
 <20180612202411.29798-3-nm@ti.com>
 <6BFD98F8-FACB-43DE-82DC-E0A134D4E1C0@gmail.com>
 <20180613133704.dwytvpj3zeuywooh@kahuna>
 <2786d17e-1075-e0fb-1864-fb5900e4a2af@gmail.com>
Message-ID: <20180614124658.yh6b7bqhd4ybxk4m@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21:36-20180613, Florian Fainelli wrote:
[...]
> >>> c) This workaround applies to only the boot processor. It is important
> >>>   to apply workaround as necessary (context-save-restore) around low
> >>>   power context loss OR additional processors as necessary in either
> >>>   firmware support OR elsewhere in OS.
> >>
> >> About that, I don't know enough of uboot but are there existing PSCI or
> >> other seemingly standard secondary core support in uboot that would make
> >> us go through the same initialization as the boot CPU? If not, is
> >> everything going to be largely implementation specific and
> >> scattered between uboot and the hypervisors or kernel?
> > 
> > in ARMV7 SoCs, unfortunately, we lived in a world of no-exact-standard.
> > even within TI, Few of the SoCs use PSCI, others did implement custom
> > SMC calls (since they existed in an architecture prior to PSCI).
> > 
> >>
> >> FWIW, this is what prompted me to submit this:
> >>
> >> https://patchwork.kernel.org/patch/10453643/
> > 
> > That wont work in a generic manner for precisely the same reason I had to do
> > it with weak function in u-boot (some SoCs will only permit 'mcr
> > p15, 0, r0, c1, c0, 1' in secure world and you need to make a custom smc
> > call to make it happen). Unfortunately, IMHO, at least at this
> > point, there'd be custom implementations per SoC and layers depending on
> > where to implement it.
> 
> It won't work in a generic manner but it will work for some platforms
> where updating the firmware is impractical, and since the bits are write
> ignore if your PL does not allow it, this still seems like a net win for
> platforms where this is effective, and it does take care of Linux doing
> the SMP bring-up of secondary cores as well. That's what we have in our
> downstream tree at least, and I was hoping this could land upstream too.


I think it is clear from Russell's summary that we dont want "may work"
workaround in kernel/bootloaders. in case of u-boot (which this patch is
about), I'd suggest adding the CONFIG_*CVE* input to the Kconfig for the
SoC where you know for sure this works.

Does that sound a fair tradeoff?

-- 
Regards,
Nishanth Menon
