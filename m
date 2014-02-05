From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 05 Feb 2014 14:07:36 +0100
Subject: [PATCH 1/3] clk: rcar-h2: fix sd0/sd1 divisor table
In-Reply-To: <52F23166.1030609@codethink.co.uk>
References: <1391537858-28593-1-git-send-email-william.towle@codethink.co.uk>
 <52F226A0.5070301@codethink.co.uk> <52F23166.1030609@codethink.co.uk>
Message-ID: <2298259.CqC51XrMZM@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,

On Wednesday 05 February 2014 12:41:10 Ben Dooks wrote:
> On 05/02/14 11:55, Ben Dooks wrote:
> > On 05/02/14 10:56, Laurent Pinchart wrote:
> >> On Tuesday 04 February 2014 18:17:36 William Towle wrote:
> >>> The clk_div_table for cpg_sd01_div_table[] concurs with the manual
> >>> but not with values found in the device itself (which are also the
> >>> same as the ones in arch/arm/mach-shmobile/clock-r8a7790.c).
> >>> 
> >>> Update the clk-rcar-gen2.c driver to have the same table as the one
> >>> used by the mach-shmobile driver which work once further issues are
> >>> fixed in the clk-rcar-gen2.c driver.
> >>> 
> >>> Part of the fix for the following error where the driver reports the
> >>> 
> >>> output as 1MHz but is really 97.5MHz:
> >>>      sh_mobile_sdhi ee100000.sd: mmc0 base at 0xee100000 clock rate 1
> >>> MHz
> >>> 
> >>> [ben.dooks at codethink.co.uk: updated patch description]
> >>> Signed-off-by: William Towle <william.towle@codethink.co.uk>
> >>> Reviewed-by: Ben Dooks <ben.dooks@codethink.co.uk>
> >>> ---
> >>> 
> >>>   drivers/clk/shmobile/clk-rcar-gen2.c |    2 ++
> >>>   1 file changed, 2 insertions(+)
> >>> 
> >>> diff --git a/drivers/clk/shmobile/clk-rcar-gen2.c
> >>> b/drivers/clk/shmobile/clk-rcar-gen2.c index a59ec21..df4a1e6 100644
> >>> --- a/drivers/clk/shmobile/clk-rcar-gen2.c
> >>> +++ b/drivers/clk/shmobile/clk-rcar-gen2.c
> >>> @@ -170,6 +170,8 @@ static const struct clk_div_table
> >>> cpg_sdh_div_table[] =
> >>> { };
> >>> 
> >>>   static const struct clk_div_table cpg_sd01_div_table[] = {
> >>> 
> >>> +    {  0,  2 }, {  1,  3 }, {  2,  4 }, {  3,  6 },
> >>> +    {  4,  8 },
> >>> 
> >>>       {  5, 12 }, {  6, 16 }, {  7, 18 }, {  8, 24 },
> >>>       { 10, 36 }, { 11, 48 }, { 12, 10 }, {  0,  0 },
> >> 
> >> With this applied the only difference between the sdh and sd0/1 dividers
> >> tables would be the { 12, 10 } entry, available for sd0/1 only. Given
> >> that the hardware does not match the documentation, could you check
> >> whether that entry is supported by sdh as well ? If so we could merge the
> >> two tables. Otherwise this patch looks good, could you please just
> >> reformat the table to avoid the mostly empty line in the middle ?
> > 
> > I would like feedback from Renesas on this issue if possible. I can
> > have a quick try at setting the clock value to 10 in u-boot and scope
> > it out and see what happens.
> > 
> > Magnus or Morimoto-san, is there a chance this could be reviewed by
> > someone in Renesas who has knowledge of the hardware block?
> > 
> > [PS, added Kuninori Morimoto to this[
> 
> I got William to do a quick test with the following u-boot command
> 	mw.l 0xE6150074 0xCCC
> 
> sdhi0 showed 156MHz output, and it seemed to work. So there is a
> distinct possibility that the sdh clock also supports setting 12
> for a /10

Thank you for trying it out. I'd like feedback from Renesas as well, assuming 
we don't get a "don't do that or it will cause the universe to collapse - 
woops, too late" nack, let's respin this patch and merge the two tables 
instead.

-- 
Regards,

Laurent Pinchart
