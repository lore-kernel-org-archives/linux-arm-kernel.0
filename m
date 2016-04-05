From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 05 Apr 2016 10:26:32 -0700
Subject: [PATCH v1 2/2] rockchip: power-domain: support qos save and
 restore
In-Reply-To: <57031B80.1080602@rock-chips.com>
References: <1458285444-31129-1-git-send-email-zhangqing@rock-chips.com>
 <3121335.t9IV1BMS6Y@phil> <57031B80.1080602@rock-chips.com>
Message-ID: <1635549.vLcbezZjHC@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Elaine,

Am Dienstag, 5. April 2016, 09:57:20 schrieb Elaine Zhang:
> Thanks for your replay.
> For your questions, I also have the same concerns.
> 
> On 04/02/2016 12:19 AM, Heiko Stuebner wrote:
> > Am Freitag, 1. April 2016, 10:33:45 schrieb Elaine Zhang:
> >> I agree with most of your modifications.
> >> Except, the u32 *qos_save_regs below
> > 
> > you're right. I didn't take that into account when my open-coding my
> > idea.> 
> > A bit more below:
> >> On 04/01/2016 12:31 AM, Heiko Stuebner wrote:
> >>> Hi Elaine,
> >>> 
> >>> Am Freitag, 18. M?rz 2016, 15:17:24 schrieb Elaine Zhang:
> >>>> support qos save and restore when power domain on/off.
> >>>> 
> >>>> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> >>> 
> >>> overall looks nice already ... some implementation-specific comments
> >>> below.>
> >>> 
> >>>> ---
> >>>> 
> >>>>    drivers/soc/rockchip/pm_domains.c | 87
> >>>> 
> >>>> +++++++++++++++++++++++++++++++++++++-- 1 file changed, 84
> >>>> insertions(+),
> >>>> 3 deletions(-)
> >>>> 
> >>>> diff --git a/drivers/soc/rockchip/pm_domains.c
> >>>> b/drivers/soc/rockchip/pm_domains.c index 18aee6b..c5f4be6 100644
> >>>> --- a/drivers/soc/rockchip/pm_domains.c
> >>>> +++ b/drivers/soc/rockchip/pm_domains.c
> >>>> @@ -45,10 +45,21 @@ struct rockchip_pmu_info {
> >>>> 
> >>>>    	const struct rockchip_domain_info *domain_info;
> >>>>    
> >>>>    };
> >>>> 
> >>>> +#define MAX_QOS_NODE_NUM	20
> >>>> +#define MAX_QOS_REGS_NUM	5
> >>>> +#define QOS_PRIORITY		0x08
> >>>> +#define QOS_MODE		0x0c
> >>>> +#define QOS_BANDWIDTH		0x10
> >>>> +#define QOS_SATURATION		0x14
> >>>> +#define QOS_EXTCONTROL		0x18
> >>>> +
> >>>> 
> >>>>    struct rockchip_pm_domain {
> >>>>    
> >>>>    	struct generic_pm_domain genpd;
> >>>>    	const struct rockchip_domain_info *info;
> >>>>    	struct rockchip_pmu *pmu;
> >>>> 
> >>>> +	int num_qos;
> >>>> +	struct regmap *qos_regmap[MAX_QOS_NODE_NUM];
> >>>> +	u32 qos_save_regs[MAX_QOS_NODE_NUM][MAX_QOS_REGS_NUM];
> >>> 
> >>> struct regmap **qos_regmap;
> >>> u32 *qos_save_regs;
> >> 
> >> when we save and restore qos registers we need save five regs for every
> >> qos. like this :
> >> for (i = 0; i < pd->num_qos; i++) {
> >> 
> >> 		regmap_read(pd->qos_regmap[i],
> >> 		
> >> 			    QOS_PRIORITY,
> >> 			    &pd->qos_save_regs[i][0]);
> >> 		
> >> 		regmap_read(pd->qos_regmap[i],
> >> 		
> >> 			    QOS_MODE,
> >> 			    &pd->qos_save_regs[i][1]);
> >> 		
> >> 		regmap_read(pd->qos_regmap[i],
> >> 		
> >> 			    QOS_BANDWIDTH,
> >> 			    &pd->qos_save_regs[i][2]);
> >> 		
> >> 		regmap_read(pd->qos_regmap[i],
> >> 		
> >> 			    QOS_SATURATION,
> >> 			    &pd->qos_save_regs[i][3]);
> >> 		
> >> 		regmap_read(pd->qos_regmap[i],
> >> 		
> >> 			    QOS_EXTCONTROL,
> >> 			    &pd->qos_save_regs[i][4]);
> >> 	
> >> 	}
> >> 
> >> so we can not define qos_save_regs like u32 *qos_save_regs;,
> >> and apply buff like
> >> pd->qos_save_regs = kcalloc(pd->num_qos * MAX_QOS_REGS_NUM,
> >> sizeof(u32),
> >> GFP_KERNEL);
> > 
> > so how about simply swapping indices and doing it like
> > 
> > u32 *qos_save_regs[MAX_QOS_REGS_NUM];
> > 
> > for (i = 0; i < MAX_QOS_REGS_NUM; i++) {
> > 
> > 	qos_save_regs[i] = kcalloc(pd->num_qos, sizeof(u32));
> > 	/* error handling here */
> > 
> > }
> > 
> > ...
> > 
> > 		regmap_read(pd->qos_regmap[i],
> > 		
> > 			    QOS_SATURATION,
> > 			    &pd->qos_save_regs[3][i]);
> > 
> > ...
> 
> I agree with you on this modification.
> 
> > Asked the other way around, how did you measure to set MAX_QOS_REGS_NUM
> > to 20? From looking at the rk3399 TRM, it seems there are only 38 QoS
> > generators on the SoC in general (24 on the rk3288 with PD_VIO having a
> > maximum of 9 qos generators), so preparing for 20 seems a bit overkill
> > ;-)
> About the MAX_QOS_NODE_NUM I also have some uncertaibty.
> Although there are only 38 QoS on the RK3399(24 on the rk3288),but not
> all of the pd need to power on/off.So not all QOS need save and restore.
> So about the MAX_QOS_NODE_NUM, what do you suggest.

if we go the way outlined above, we don't need MAX_QOS_NODE_NUM, as the 
driver will be counting the real number of qos nodes and allocate needed 
structs dynamically - problem solved :-D


> MAX_QOS_REGS_NUM is 5 because the QOS register is just 5 need save and
> restore.

yep, that is no problem and expected.


Heiko
