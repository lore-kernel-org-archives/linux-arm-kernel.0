From: leo.yan@linaro.org (leo.yan at linaro.org)
Date: Sun, 18 Nov 2018 14:38:48 +0800
Subject: [PATCH v1 2/5] perf cs-etm: Avoid stale branch samples when
 flush packet
In-Reply-To: <20181116230511.GB25258@xps15>
References: <1541912383-19915-1-git-send-email-leo.yan@linaro.org>
 <1541912383-19915-3-git-send-email-leo.yan@linaro.org>
 <20181116230511.GB25258@xps15>
Message-ID: <20181118063848.GA8751@leoy-ThinkPad-X240s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 16, 2018 at 04:05:11PM -0700, Mathieu Poirier wrote:

[...]

> > -static int cs_etm__flush(struct cs_etm_queue *etmq)
> > +static int cs_etm__flush(struct cs_etm_queue *etmq, bool new_packet)
> >  {
> >  	int err = 0;
> >  	struct cs_etm_auxtrace *etm = etmq->etm;
> > @@ -989,6 +989,20 @@ static int cs_etm__flush(struct cs_etm_queue *etmq)
> >  
> >  	}
> >  
> > +	/*
> > +	 * If 'new_packet' is false, this time call has no a new packet
> > +	 * coming and 'etmq->packet' contains the stale packet which is
> > +	 * set at the previous time with packets swapping.  In this case
> > +	 * this function is invoked only for flushing branch stack at
> > +	 * the end of buffer handling.
> > +	 *
> > +	 * Simply to say, branch samples should be generated when every
> > +	 * time receive one new packet; otherwise, directly bail out to
> > +	 * avoid generate branch sample with stale packet.
> > +	 */
> > +	if (!new_packet)
> > +		return 0;
> > +
> >  	if (etm->sample_branches &&
> >  	    etmq->prev_packet->sample_type == CS_ETM_RANGE) {
> >  		err = cs_etm__synth_branch_sample(etmq);
> > @@ -1075,7 +1089,7 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
> >  					 * Discontinuity in trace, flush
> >  					 * previous branch stack
> >  					 */
> > -					cs_etm__flush(etmq);
> > +					cs_etm__flush(etmq, true);
> >  					break;
> >  				case CS_ETM_EMPTY:
> >  					/*
> > @@ -1092,7 +1106,7 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
> >  
> >  		if (err == 0)
> >  			/* Flush any remaining branch stack entries */
> > -			err = cs_etm__flush(etmq);
> > +			err = cs_etm__flush(etmq, false);
> 
> I understand what you're doing and it will yield the correct results.  What I'm
> not sure about is if we wouldn't be better off splitting cs_etm__flush()
> in order to reduce the complexity of the main decoding loop.  That is rename
> cs_etm__flush() to something like cs_etm__trace_on() and spin off a new
> cs_etm__end_block().  
> 
> It does introduce a little bit of code duplication but I think we'd win in terms
> of readability and flexibility.

Thanks for reviewing, Mathieu.

I agree with your suggestion to split cs_etm__flush() into two
functions,  will spin this patch with the suggestion in next
series for reviewing.

Thanks,
Leo Yan
