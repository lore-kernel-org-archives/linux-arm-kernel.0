From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Aug 2012 16:33:31 +0100
Subject: kernel entry for thumb2-only cpus
In-Reply-To: <CAKGA1b=UBEf783egzoKqyXipfgziOy7QremNbFoz_i+r1X_9hQ@mail.gmail.com>
References: <alpine.LFD.2.02.1208060026460.5231@xanadu.home>
 <CAKGA1b=Pxif=4qSvK-Odmunbm_T6LjWP_CXid_v2VNmpuyHLDA@mail.gmail.com>
 <20120806190856.GA1120@n2100.arm.linux.org.uk>
 <CAKGA1b=Np8+RMwgQEzwxdJcL6AjC4qiv1Jyq0bTTa_dHCeLokA@mail.gmail.com>
 <20120806194016.GB1120@n2100.arm.linux.org.uk>
 <CAKGA1b=hMZD3nd2sjXzR89-wX4BotxZwHOkkiLFoEL_CSS4zug@mail.gmail.com>
 <alpine.LFD.2.02.1208061829510.5231@xanadu.home>
 <CAKGA1bnJCSaVcErs3R8U3ZjQkhMmZAZPM=2P2R7udVc80ZmoDQ@mail.gmail.com>
 <alpine.LFD.2.02.1208061935380.5231@xanadu.home>
 <CAKGA1b=UBEf783egzoKqyXipfgziOy7QremNbFoz_i+r1X_9hQ@mail.gmail.com>
Message-ID: <20120808153330.GM18957@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 07, 2012 at 05:34:15PM -0500, Matt Sealey wrote:
> Just because there is a ton of absolutely awful, broken firmware code out there
> doesn't mean it can and will always be the case, and Linux policy should not
> be dictated on an architecture basis on a few bad eggs, especially if it means
> developers in the big wide world have to jump through hoops. Surely it is just
> as good for Linux to loudly advocate the correct solutions in firmware and
> implement the workarounds anyway, like a device quirk, rather than just out and
> out say "firmwares suck, ignore what they did, do it again. We don't trust them
> and never will."

Sadly, firmware developers have taught us time and time and time and time
again that they can not be trusted.  You may be the single one who can be
trusted to validate their stuff properly, but you would be in a severe
minority if that is true.

Many firmware developers do the barest minimum that's required.  Once their
job is done, that's the end of the development cycle and nothing further
happens, not even for bugs.

We've seen this time and time again.  We see it with corrupted ATAG lists,
we see it with bad memory tags passed to the kernel that the kernel has to
then screw around with to fix up the broken firmware developers crap.
Let me show you the crappy workarounds that we have:

static void __init
fixup_clep7312(struct tag *tags, char **cmdline, struct meminfo *mi)
{
        mi->nr_banks=1;
        mi->bank[0].start = 0xc0000000;
        mi->bank[0].size = 0x01000000;
}
static void __init
fixup_edb7211(struct tag *tags, char **cmdline, struct meminfo *mi)
{
        /*
         * Bank start addresses are not present in the information
         * passed in from the boot loader.  We could potentially
         * detect them, but instead we hard-code them.
         *
         * Banks sizes _are_ present in the param block, but we're
         * not using that information yet.
         */
        mi->bank[0].start = 0xc0000000;
        mi->bank[0].size = 8*1024*1024;
        mi->bank[1].start = 0xc1000000;
        mi->bank[1].size = 8*1024*1024;
        mi->nr_banks = 2;
}
static void __init
fortunet_fixup(struct tag *tags, char **cmdline, struct meminfo *mi)
{
...
        memmap.bank[0].size = ip->ram_size;
        *mi = memmap;
}
static void __init mahimahi_fixup(struct tag *tags, char **cmdline,
                                  struct meminfo *mi)
{
        mi->nr_banks = 2;
        mi->bank[0].start = PHYS_OFFSET;
        mi->bank[0].node = PHYS_TO_NID(PHYS_OFFSET);
        mi->bank[0].size = (219*1024*1024);
        mi->bank[1].start = MSM_HIGHMEM_BASE;
        mi->bank[1].node = PHYS_TO_NID(MSM_HIGHMEM_BASE);
        mi->bank[1].size = MSM_HIGHMEM_SIZE;
}
static void __init msm7x30_fixup(struct tag *tag, char **cmdline,
                struct meminfo *mi)
{
        for (; tag->hdr.size; tag = tag_next(tag))
                if (tag->hdr.tag == ATAG_MEM && tag->u.mem.start == 0x200000) {
                        tag->u.mem.start = 0;
                        tag->u.mem.size += SZ_2M;
                }
}
static void __init msm8960_fixup(struct tag *tag, char **cmdline,
                struct meminfo *mi)
{
        for (; tag->hdr.size; tag = tag_next(tag))
                if (tag->hdr.tag == ATAG_MEM &&
                                tag->u.mem.start == 0x40200000) {
                        tag->u.mem.start = 0x40000000;
                        tag->u.mem.size += SZ_2M;
                }
}
static void __init msm8x60_fixup(struct tag *tag, char **cmdline,
                struct meminfo *mi)
{
        for (; tag->hdr.size; tag = tag_next(tag))
                if (tag->hdr.tag == ATAG_MEM &&
                                tag->u.mem.start == 0x40200000) {
                        tag->u.mem.start = 0x40000000;
                        tag->u.mem.size += SZ_2M;
                }
}
static void __init sapphire_fixup(struct tag *tags, char **cmdline,
                                  struct meminfo *mi)
{
        int smi_sz = parse_tag_smi((const struct tag *)tags);

        mi->nr_banks = 1;
        mi->bank[0].start = PHYS_OFFSET;
        mi->bank[0].node = PHYS_TO_NID(PHYS_OFFSET);
        if (smi_sz == 32) {
                mi->bank[0].size = (84*1024*1024);
        } else if (smi_sz == 64) {
                mi->bank[0].size = (101*1024*1024);
        } else {
                /* Give a default value when not get smi size */
                smi_sz = 64;
                mi->bank[0].size = (101*1024*1024);
        }
}
static void __init trout_fixup(struct tag *tags, char **cmdline,
                               struct meminfo *mi)
{
        mi->nr_banks = 1;
        mi->bank[0].start = PHYS_OFFSET;
        mi->bank[0].size = (101*1024*1024);
}
static void __init fixup_corgi(struct tag *tags, char **cmdline,
                               struct meminfo *mi)
{
        sharpsl_save_param();
        mi->nr_banks=1;
        mi->bank[0].start = 0xa0000000;
        if (machine_is_corgi())
                mi->bank[0].size = (32*1024*1024);
        else
                mi->bank[0].size = (64*1024*1024);
}
void __init eseries_fixup(struct tag *tags, char **cmdline, struct meminfo *mi)
{
        mi->nr_banks=1;
        mi->bank[0].start = 0xa0000000;
        if (machine_is_e800())
                mi->bank[0].size = (128*1024*1024);
        else
                mi->bank[0].size = (64*1024*1024);
}
static void __init fixup_poodle(struct tag *tags, char **cmdline,
                                struct meminfo *mi)
{
        sharpsl_save_param();
        mi->nr_banks=1;
        mi->bank[0].start = 0xa0000000;
        mi->bank[0].size = (32*1024*1024);
}
static void __init spitz_fixup(struct tag *tags, char **cmdline,
                               struct meminfo *mi)
{
        sharpsl_save_param();
        mi->nr_banks = 1;
        mi->bank[0].start = 0xa0000000;
        mi->bank[0].size = (64*1024*1024);
}
static void __init fixup_tosa(struct tag *tags, char **cmdline,
                              struct meminfo *mi)
{
        sharpsl_save_param();
        mi->nr_banks=1;
        mi->bank[0].start = 0xa0000000;
        mi->bank[0].size = (64*1024*1024);
}
static void __init smdk2413_fixup(struct tag *tags, char **cmdline,
                                  struct meminfo *mi)
{
        if (tags != phys_to_virt(S3C2410_SDRAM_PA + 0x100)) {
                mi->nr_banks=1;
                mi->bank[0].start = 0x30000000;
                mi->bank[0].size = SZ_64M;
        }
}
static void __init vstms_fixup(struct tag *tags, char **cmdline,
                               struct meminfo *mi)
{
        if (tags != phys_to_virt(S3C2410_SDRAM_PA + 0x100)) {
                mi->nr_banks=1;
                mi->bank[0].start = 0x30000000;
                mi->bank[0].size = SZ_64M;
        }
}

Spot a pattern there?  The one which stands out to me is that boot loaders
can not get the trivial task of passing the simple information about where
the RAM is in the system to the kernel right.

Many boot loaders for _years_ have not been able to get the very very
trivially simple issue of passing the right machine ID value in r1 to the
kernel either.

History has taught us time and time and time again that firmware can
not be trusted in *any* *way* and we have plenty of proof to back that
up.

Have we tried to push the onus back on firmware people?  I've tried damned
hard to the extent of preventing some of these work-arounds getting into
mainline, but the sole result of that was that mainline would not work on
those platforms; it didn't make a blind bit of difference to the firmware
on the platforms.  It didn't magically cause the firmware to get fixed in
any way.  We just ended up with a detrimental situation to everyone because
mainline just didn't work on those platforms.

So please, stop telling us what we should and shouldn't do with firmware.
We've learnt by the action of firmware developers how to treat them, and
that's how we're going to treat them.  They have earned our distrust.  In
order for that to change, they must change, and they must _earn_ our trust
that they _can_ be trusted to do a good job.  Until then...
