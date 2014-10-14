From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 15 Oct 2014 00:36:04 +0100
Subject: [PATCH v4 4/6] ARM: rockchip: add basic smp support for rk3288
In-Reply-To: <1453932.GC4UXrUPRz@phil>
References: <1413231122-1770-1-git-send-email-kever.yang@rock-chips.com>
 <1413231122-1770-5-git-send-email-kever.yang@rock-chips.com>
 <CAD=FV=WGnE3fBfzLGN_x8dFqq4RV=OnVAyUgRQheMiyG4U7TkQ@mail.gmail.com>
 <1453932.GC4UXrUPRz@phil>
Message-ID: <20141014233604.GG27405@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 14, 2014 at 11:23:40PM +0200, Heiko St?bner wrote:
> Am Dienstag, 14. Oktober 2014, 13:24:03 schrieb Doug Anderson:
> > Kever,
> > 
> > On Mon, Oct 13, 2014 at 1:12 PM, Kever Yang <kever.yang@rock-chips.com> 
> wrote:
> > > +       /*
> > > +        * We need to soft reset the cpu when we turn off the cpu power
> > > domain, +        * or else the active processors might be stalled when
> > > the individual +        * processor is powered down.
> > > +        */
> > > +       if (read_cpuid_part_number() != ARM_CPU_PART_CORTEX_A9) {
> > 
> > I haven't done a full review of this patch, but it seems unlikely that
> > your uses of read_cpuid_part_number() and read_cpuid_part() in this
> > patch are correct.  You use both functions and in both cases compare
> > the results to ARM_CPU_PART_CORTEX_A9.
> 
> I think read_cpuid_part() would be the correct one, as it does
> 
> 	read_cpuid_id() & ARM_CPU_PART_MASK
> 
> which in turn should mask the correct parts of the cpuid to match against 
> ARM_CPU_PART_CORTEX_A9 [0].

The clue is the deprecated message.  Clearly the original author did not
even build test their code, or if they did, they ignored the warnings.
Either way, that's a fairly worrying issue which raises the question:
how well was this code tested in the first place?

Note that the above quoted if() evaluates to always-false.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
