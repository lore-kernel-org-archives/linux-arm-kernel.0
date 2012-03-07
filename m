From: tony@atomide.com (Tony Lindgren)
Date: Tue, 6 Mar 2012 18:28:09 -0800
Subject: [PATCH] ARM: OMAP2+: gpmc-smsc911x: only register regulator
 for first instance
In-Reply-To: <87sjhlnq96.fsf@ti.com>
References: <1331080771-30687-1-git-send-email-khilman@ti.com>
 <20120307004405.GC12083@atomide.com> <87sjhlnq96.fsf@ti.com>
Message-ID: <20120307022809.GD12083@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@ti.com> [120306 17:07]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> > * Kevin Hilman <khilman@ti.com> [120306 16:07]:
> >> commit e4b0b2cbbb (ARM: OMAP2+: gpmc-smsc911x: add required smsc911x
> >> regulators) added regulators which are registered during
> >> gpmc_smsc911x_init().  However, some platforms (OMAP3/Overo) have more
> >> than one instance of the SMSC911x and result in attempting to register
> >> the same regulator more than once which causes a panic().
> >> 
> >> Fix this by only registering the regulator when the platform_data id
> >> field is zero, indicating its the first instance.
> >> 
> >> Cc: Matt Porter <mporter@ti.com>
> >> Signed-off-by: Kevin Hilman <khilman@ti.com>
> >> ---
> >> Fix needed for v3.3.
> >> Applies on top of Tony's fixes branch.
> >> 
> >>  arch/arm/mach-omap2/gpmc-smsc911x.c |   11 +++++++----
> >>  1 file changed, 7 insertions(+), 4 deletions(-)
> >> 
> >> diff --git a/arch/arm/mach-omap2/gpmc-smsc911x.c b/arch/arm/mach-omap2/gpmc-smsc911x.c
> >> index bbb870c..4d6f1c6 100644
> >> --- a/arch/arm/mach-omap2/gpmc-smsc911x.c
> >> +++ b/arch/arm/mach-omap2/gpmc-smsc911x.c
> >> @@ -101,10 +101,13 @@ void __init gpmc_smsc911x_init(struct omap_smsc911x_platform_data *board_data)
> >>  
> >>  	gpmc_cfg = board_data;
> >>  
> >> -	ret = platform_device_register(&gpmc_smsc911x_regulator);
> >> -	if (ret < 0) {
> >> -		pr_err("Unable to register smsc911x regulators: %d\n", ret);
> >> -		return;
> >> +	if (!gpmc_cfg) {
> >
> > Shouldn't this be !gpmc_cfg->id instead..
> 
> doh, of course.  Updated patch below.

Thanks, applying into fixes.

Regards,

Tony
