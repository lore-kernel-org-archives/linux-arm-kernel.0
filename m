From: quentin.perret@arm.com (Quentin Perret)
Date: Mon, 10 Sep 2018 17:15:33 +0100
Subject: [PATCH v2] firmware: arm_scmi: add a getter for power of
 performance states
In-Reply-To: <20180910160638.GA14835@e107155-lin>
References: <20180903102439.24012-1-quentin.perret@arm.com>
 <20180910160638.GA14835@e107155-lin>
Message-ID: <20180910161530.izm4l22clxqktetn@queper01-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 10 Sep 2018 at 17:06:38 (+0100), Sudeep Holla wrote:
> On Mon, Sep 03, 2018 at 11:24:39AM +0100, Quentin Perret wrote:
> > The SCMI protocol can be used to get power estimates from firmware
> > corresponding to each performance state of a device. Although these power
> > costs are already managed by the SCMI firmware driver, they are not
> > exposed to any external subsystem yet.
> > 
> > Fix this by adding a new get_power() interface to the exisiting perf_ops
> > defined for the SCMI protocol.
> > 
> > Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> > ---
> > v2: rebased on 4.19-rc2
> > ---
> >  drivers/firmware/arm_scmi/perf.c | 28 ++++++++++++++++++++++++++++
> >  include/linux/scmi_protocol.h    |  4 ++++
> >  2 files changed, 32 insertions(+)
> > 
> > diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
> > index 721e6c57beae..272abd2cb3f0 100644
> > --- a/drivers/firmware/arm_scmi/perf.c
> > +++ b/drivers/firmware/arm_scmi/perf.c
> > @@ -421,6 +421,33 @@ static int scmi_dvfs_freq_get(const struct scmi_handle *handle, u32 domain,
> >  	return ret;
> >  }
> >  
> > +static int scmi_dvfs_power_get(const struct scmi_handle *handle, u32 domain,
> > +			       unsigned long *freq, unsigned long *power)
> 
> I feel the name "power_get" gives me feeling that it refers to instant
> power than the computed value. At least in scmi interface, freq_get
> provides current value of running frequency. I am not sure of the
> consistency in the naming in other subsystems.

Right, I see your point.

> Does it makes sense to name it "scmi_dvfs_est_power_get" as it actually
> refers to estimated power cost ?

"scmi_dvfs_est_power_get" sounds good to me.

> > +{
> > +	struct scmi_perf_info *pi = handle->perf_priv;
> > +	struct perf_dom_info *dom;
> > +	unsigned long opp_freq;
> > +	int idx, ret = -EINVAL;
> > +	struct scmi_opp *opp;
> > +
> > +	dom = pi->dom_info + domain;
> > +	if (!dom)
> > +		return -EIO;
> > +
> > +	for (opp = dom->opp, idx = 0; idx < dom->opp_count; idx++, opp++) {
> > +		opp_freq = opp->perf * dom->mult_factor;
> > +		if (opp_freq < *freq)
> > +			continue;
> > +
> > +		*freq = opp_freq;
> > +		*power = opp->power;
> > +		ret = 0;
> > +		break;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> >  static struct scmi_perf_ops perf_ops = {
> >  	.limits_set = scmi_perf_limits_set,
> >  	.limits_get = scmi_perf_limits_get,
> > @@ -431,6 +458,7 @@ static struct scmi_perf_ops perf_ops = {
> >  	.device_opps_add = scmi_dvfs_device_opps_add,
> >  	.freq_set = scmi_dvfs_freq_set,
> >  	.freq_get = scmi_dvfs_freq_get,
> > +	.power_get = scmi_dvfs_power_get,
> 
> same here s/.power_get/.est_power_get/
> 
> >  };
> >  
> >  static int scmi_perf_protocol_init(struct scmi_handle *handle)
> > diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
> > index f4c9fc0fc755..2ecbd2c5a249 100644
> > --- a/include/linux/scmi_protocol.h
> > +++ b/include/linux/scmi_protocol.h
> > @@ -91,6 +91,8 @@ struct scmi_clk_ops {
> >   *	to sustained performance level mapping
> >   * @freq_get: gets the frequency for a given device using sustained frequency
> >   *	to sustained performance level mapping
> > + * @power_get: gets the power dissipated for a given performance domain at a
> 
> s/power dissipated/estimated power cost/

Ack for the two remarks above.
I'll spin a v3 soon.

Thanks!
Quentin
