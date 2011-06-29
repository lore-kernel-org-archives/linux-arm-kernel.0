From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 29 Jun 2011 15:00:59 +0100
Subject: [PATCHv2] omap2+: pm: cpufreq: Fix loops_per_jiffy calculation
In-Reply-To: <CAMbhsRRBhT5YX6E4Nkyvns5YykqzqV3-g4JhR2KPcxBhj0ABww@mail.gmail.com>
References: <1308923618-5333-1-git-send-email-premi@ti.com>
	<CAMbhsRQUKBZbC3jJt8XpjTW2n7uA529D6G0g4eT5iLEHn2iNLg@mail.gmail.com>
	<20110628225523.GA23312@n2100.arm.linux.org.uk>
	<CAMbhsRQjMmXrULVmFg9CoM0wzZ29wcHqEaT480NaDhB8hHEKZg@mail.gmail.com>
	<20110628231711.GC23312@n2100.arm.linux.org.uk>
	<CAMbhsRQUg75R=1TvqYwgcF5eCSFq3WFaAg7EsJ=yaT9VgcfJNA@mail.gmail.com>
	<20110628234621.GD23312@n2100.arm.linux.org.uk>
	<CAMbhsRRBhT5YX6E4Nkyvns5YykqzqV3-g4JhR2KPcxBhj0ABww@mail.gmail.com>
Message-ID: <20110629140059.GE23312@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 28, 2011 at 04:59:57PM -0700, Colin Cross wrote:
> On Tue, Jun 28, 2011 at 4:46 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Tue, Jun 28, 2011 at 04:37:08PM -0700, Colin Cross wrote:
> >> I don't think it affects bogomips - loops_per_jiffy can still be
> >> calibrated and updated by cpufreq, udelay just wont use them.
> >
> > No, you can't avoid it. ?__delay(), udelay(), and the global
> > loops_per_jiffy are all linked together - for instance this is how
> > the spinlock code has a 1s timeout:
> >
> > static void __spin_lock_debug(raw_spinlock_t *lock)
> > {
> > ? ? ? ?u64 loops = loops_per_jiffy * HZ;
> > ? ? ? ?int print_once = 1;
> >
> > ? ? ? ?for (;;) {
> > ? ? ? ? ? ? ? ?for (i = 0; i < loops; i++) {
> > ? ? ? ? ? ? ? ? ? ? ? ?if (arch_spin_trylock(&lock->raw_lock))
> > ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?return;
> > ? ? ? ? ? ? ? ? ? ? ? ?__delay(1);
> > ? ? ? ? ? ? ? ?}
> >
> > which goes wrong for all the same reasons you're pointing out about
> > udelay(). ?So just restricting your argument to udelay() is not
> > realistic.
> >
> 
> True, there are a few other users of loops_per_jiffy and __delay, but
> it looks like __spin_lock_debug is the only one worth worrying about,
> and it's timing is not as critical as udelay - worst case here is that
> the warning occurs after 250 ms instead of 1s.  Leaving
> loops_per_jiffy and __delay intact, and fixing udelay, would still be
> a net gain.

Other users of loops_per_jiffy are incorrect in any case:

static inline void omap_hsmmc_reset_controller_fsm(struct omap_hsmmc_host *host,                                                   unsigned long bit)
{
        unsigned long i = 0;
        unsigned long limit = (loops_per_jiffy *
                                msecs_to_jiffies(MMC_TIMEOUT_MS));
...
        if (mmc_slot(host).features & HSMMC_HAS_UPDATED_RESET) {
                while ((!(OMAP_HSMMC_READ(host->base, SYSCTL) & bit))
                                        && (i++ < limit))
                        cpu_relax();
        }

Is rubbish.

static void omap_write_buf_pref(struct mtd_info *mtd,
                                        const u_char *buf, int len)
{
...
                /* wait for data to flushed-out before reset the prefetch */
                tim = 0;
                limit = (loops_per_jiffy *
                                        msecs_to_jiffies(OMAP_NAND_TIMEOUT_MS));                while (gpmc_read_status(GPMC_PREFETCH_COUNT) && (tim++ < limit))                        cpu_relax();

Another load of rubbish.

static int flush(struct pl022 *pl022)
{
        unsigned long limit = loops_per_jiffy << 1;

        dev_dbg(&pl022->adev->dev, "flush\n");
        do {
                while (readw(SSP_SR(pl022->virtbase)) & SSP_SR_MASK_RNE)
                        readw(SSP_DR(pl022->virtbase));
        } while ((readw(SSP_SR(pl022->virtbase)) & SSP_SR_MASK_BSY) && limit--);

Yet more...

static int flush(struct driver_data *drv_data)
{
        unsigned long limit = loops_per_jiffy << 1;

        void __iomem *reg = drv_data->ioaddr;

        do {
                while (read_SSSR(reg) & SSSR_RNE) {
                        read_SSDR(reg);
                }
        } while ((read_SSSR(reg) & SSSR_BSY) && --limit);

and...

sound/soc/samsung/i2s.c:
#define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)
        /* Be patient */
        val = msecs_to_loops(1) / 1000; /* 1 usec */
        while (--val)
                cpu_relax();

even worse.

#define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)
static int s3c2412_snd_lrsync(struct s3c_i2sv2_info *i2s)
{
        u32 iiscon;
        unsigned long loops = msecs_to_loops(5);

        while (--loops) {
                iiscon = readl(i2s->regs + S3C2412_IISCON);
                if (iiscon & S3C2412_IISCON_LRINDEX)
                        break;

                cpu_relax();
        }

It just goes on...

And strangely the major offender of this stuff are ARM drivers, not other
peoples stuff and not stuff in drivers/staging.

So I don't think its sane to ignore loops_per_jiffy and __delay, and just
concentrate on udelay().
