From: jimmy.rubin@stericsson.com (Jimmy RUBIN)
Date: Mon, 15 Nov 2010 10:52:55 +0100
Subject: [PATCH 01/10] MCDE: Add hardware abstraction layer
In-Reply-To: <1289409276.15905.65.camel@Joe-Laptop>
References: <1289390653-6111-1-git-send-email-jimmy.rubin@stericsson.com>
	<1289390653-6111-2-git-send-email-jimmy.rubin@stericsson.com>
	<1289409276.15905.65.camel@Joe-Laptop>
Message-ID: <F45880696056844FA6A73F415B568C6953604E7105@EXDCVYMBSTM006.EQ1STM.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joe,

Thanks for your input.
See comments below.
 
> Just trivia:
> 
> > diff --git a/drivers/video/mcde/mcde_hw.c
> b/drivers/video/mcde/mcde_hw.c
> 
> []
> 
> > +#define dsi_rfld(__i, __reg, __fld) \
> > +	((dsi_rreg(__i, __reg) & __reg##_##__fld##_MASK) >> \
> > +		__reg##_##__fld##_SHIFT)
> > +#define dsi_wfld(__i, __reg, __fld, __val) \
> > +	dsi_wreg(__i, __reg, (dsi_rreg(__i, __reg) & \
> > +	~__reg##_##__fld##_MASK) | (((__val) <<
> __reg##_##__fld##_SHIFT) & \
> > +		 __reg##_##__fld##_MASK))
> 
> These macros are not particularly readable.
> Perhaps use statement expression macros like:
> 
> #define dsi_rfld(__i, __reg, __fld)
> 		\
> ({
> 			\
> 	const u32 mask = __reg##_#__fld##_MASK;
> 		\
> 	const u32 shift = __reg##_##__fld##_SHIFT;
> 	\
> 	((dsi_rreg(__i, __reg) & mask) >> shift;
> 	\
> })
> 
> #define dsi_wfld(__i, __reg, __fld, __val)
> 	\
> ({
> 			\
> 	const u32 mask = __reg##_#__fld##_MASK;
> 		\
> 	const u32 shift = __reg##_##__fld##_SHIFT;
> 	\
> 	dsi_wreg(__i, __reg,
> 		\
> 		 (dsi_rreg(__i, __reg) & ~mask) | (((__val) <<
> shift) & mask));\
> })

I agree, more readable.
> 
> > +static struct mcde_chnl_state channels[] = {
> 
> Should more static structs be static const?

I think so, we got some strange behavior when we changed the structs to static const. But we will investigate it.

> 
> []
> 
> > +	dev_vdbg(&mcde_dev->dev, "%s\n", __func__);
> 
> If your dev_<level> logging messages use "%s", __func__
> I suggest you use a set of local macros to preface this.
> 
> I don't generally find the function name useful.
> 
> Maybe only use the %s __func__ pair when you are also
> setting verbose debugging.
Alright, will add some local macros for this.

> 
> #ifdef VERBOSE_DEBUG
> #define mcde_printk(level, dev, fmt, args) \
> 	dev_printk(level, dev, "%s: " fmt, __func__, ##args)
> #else
> #define mcde_printk(level, dev, fmt, args) \
> 	dev_printk(level, dev, fmt, args)
> #endif
> 
> #ifdef VERBOSE_DEBUG
> #define mcde_vdbg(dev, fmt, args) \
> 	mcde_printk(KERN_DEBUG, dev, fmt, ##args)
> #else
> #define mcde_vdbg(dev, fmt, args) \
> 	do { if (0) mcde_printk(KERN_DEBUG, dev, fmt, ##args); }
> while (0)
> #endif
> 
> #ifdef DEBUG
> #define mcde_dbg(dev, fmt, args) \
> 	mcde_printk(KERN_DEBUG, dev, fmt, ##args)
> #else
> #define mcde_dbg(dev, fmt, args) \
> 	do { if (0) mcde_printk(KERN_DEBUG, dev, fmt, ##args); }
> while (0)
> #endif
> 
> #define mcde_ERR(dev, fmt, args) \
> 	mcde_printk(KERN_ERR, dev, fmt, ##args)
> #define mcde_warn(dev, fmt, args) \
> 	mcde_printk(KERN_WARNING, dev, fmt, ##args)
> #define mcde_info(dev, fmt, args) \
> 	mcde_printk(KERN_INFO, dev, fmt, ##args)
> 
> > +static void disable_channel(struct mcde_chnl_state *chnl)
> > +{
> > +	int i;
> > +	const struct mcde_port *port = &chnl->port;
> > +
> > +	dev_vdbg(&mcde_dev->dev, "%s\n", __func__);
> > +
> > +	if (hardware_version == MCDE_CHIP_VERSION_3_0_8 &&
> > +				!is_channel_enabled(chnl))
> {
> > +		chnl->continous_running = false;
> 
> It'd be nice to change to continuous_running

Continous_running is normally set to true when a chnl_update is performed.
In disable channel continous_running must be set to false in order to get the hw registers updated in the next chnl_update.

> 
> > +int mcde_dsi_dcs_write(struct mcde_chnl_state *chnl, u8 cmd, u8*
> data, int len)
> > +{
> > +	int i;
> > +	u32 wrdat[4] = { 0, 0, 0, 0 };
> > +	u32 settings;
> > +	u8 link = chnl->port.link;
> > +	u8 virt_id = chnl->port.phy.dsi.virt_id;
> > +
> > +	/* REVIEW: One command at a time */
> > +	/* REVIEW: Allow read/write on unreserved ports */
> > +	if (len > MCDE_MAX_DCS_WRITE || chnl->port.type !=
> MCDE_PORTTYPE_DSI)
> > +		return -EINVAL;
> > +
> > +	wrdat[0] = cmd;
> > +	for (i = 1; i <= len; i++)
> > +		wrdat[i>>2] |= ((u32)data[i-1] << ((i & 3) * 8));
> 
> Ever overrun wrdat?
> Maybe WARN_ON(len > 16, "oops?")
> 
MCDE_MAX_DCS_WRITE is 15 so it will be an early return in that case.

/Jimmy
