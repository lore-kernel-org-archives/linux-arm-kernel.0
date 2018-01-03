From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed, 3 Jan 2018 11:39:16 -0800
Subject: [RESEND PATCH v2 07/15] ASoC: qcom: q6asm: Add support to memory
 map and unmap
In-Reply-To: <4d1d17df-71a4-2896-29c1-9d033a2f3711@linaro.org>
References: <20171214173402.19074-1-srinivas.kandagatla@linaro.org>
 <20171214173402.19074-8-srinivas.kandagatla@linaro.org>
 <20180102054852.GP478@tuxbook>
 <4d1d17df-71a4-2896-29c1-9d033a2f3711@linaro.org>
Message-ID: <20180103193916.GZ478@tuxbook>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 03 Jan 08:26 PST 2018, Srinivas Kandagatla wrote:

> Thanks for your review comments.
> 
> On 02/01/18 05:48, Bjorn Andersson wrote:
> > On Thu 14 Dec 09:33 PST 2017, srinivas.kandagatla at linaro.org wrote:
[..]
> > > +int q6asm_unmap_memory_regions(unsigned int dir, struct audio_client *ac)
> > > +{
> > > +	struct audio_port_data *port;
> > > +	int cnt = 0;
> > > +	int rc = 0;
> > > +
> > > +	mutex_lock(&ac->cmd_lock);
> > > +	port = &ac->port[dir];
> > > +	if (!port->buf) {
> > > +		mutex_unlock(&ac->cmd_lock);
> > > +		return 0;
> > 
> > Put a label right before the mutex_unlock below and return rc instead of
> > 0, then you can replace these two lines with "goto unlock"
> > 
> > > +	}
> > > +	cnt = port->max_buf_cnt - 1;
> > 
> > What if we mapped 1 period? Why shouldn't we enter the unmap path?
> > 
> It would enter into unmap path, as cnt  would be 0 for 1 period.
> 

You're right, I missed the = in the comparison, but I don't see a reason
to subtract 1. It seems like the max_buf_cnt might have been used
differently in the past?

I suggest that you drop the - 1 and change the comparison to cnt > 0, if
nothing else to not confuse me if I read this code again ;)

> > > +	if (cnt >= 0) {
[..]
> > > +int q6asm_map_memory_regions(unsigned int dir, struct audio_client *ac,
> > > +			     dma_addr_t phys,
> > > +			     unsigned int period_sz, unsigned int periods)
[..]
> > > +		ac->port[dir].max_buf_cnt = 0;
> > > +		kfree(buf);
> > > +		ac->port[dir].buf = NULL;
> > 
> > These operations are done without holding cmd_lock.
> > 
> I will revisit such instances where the buf is not protected.
> 

NB. I got the impression that cmd_lock was actually the port_lock in
most places.

Regards,
Bjorn
