From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 16 Nov 2018 16:05:11 -0700
Subject: [PATCH v1 2/5] perf cs-etm: Avoid stale branch samples when
 flush packet
In-Reply-To: <1541912383-19915-3-git-send-email-leo.yan@linaro.org>
References: <1541912383-19915-1-git-send-email-leo.yan@linaro.org>
 <1541912383-19915-3-git-send-email-leo.yan@linaro.org>
Message-ID: <20181116230511.GB25258@xps15>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 11, 2018 at 12:59:40PM +0800, Leo Yan wrote:
> At the end of trace buffer handling, function cs_etm__flush() is invoked
> to flush any remaining branch stack entries.  As a side effect, it also
> generates branch sample, because the 'etmq->packet' doesn't contains any
> new coming packet but point to one stale packet after packets swapping,
> so it wrongly makes synthesize branch samples with stale packet info.
> 
> We could review below detailed flow which causes issue:
> 
>   Packet1: start_addr=0xffff000008b1fbf0 end_addr=0xffff000008b1fbfc
>   Packet2: start_addr=0xffff000008b1fb5c end_addr=0xffff000008b1fb6c
> 
>   step 1: cs_etm__sample():
> 	sample: ip=(0xffff000008b1fbfc-4) addr=0xffff000008b1fb5c
> 
>   step 2: flush packet in cs_etm__run_decoder():
> 	cs_etm__run_decoder()
> 	  `-> err = cs_etm__flush(etmq, false);
> 	sample: ip=(0xffff000008b1fb6c-4) addr=0xffff000008b1fbf0
> 
> Packet1 and packet2 are two continuous packets, when packet2 is the new
> coming packet, cs_etm__sample() generates branch sample for these two
> packets and use [packet1::end_addr - 4 => packet2::start_addr] as branch
> jump flow, thus we can see the first generated branch sample in step 1.
> At the end of cs_etm__sample() it swaps packets so 'etm->prev_packet'=
> packet2 and 'etm->packet'=packet1, so far it's okay for branch sample.
> 
> If packet2 is the last one packet in trace buffer, even there have no
> any new coming packet, cs_etm__run_decoder() invokes cs_etm__flush() to
> flush branch stack entries as expected, but it also generates branch
> samples by taking 'etm->packet' as a new coming packet, thus the branch
> jump flow is as [packet2::end_addr - 4 =>  packet1::start_addr]; this
> is the second sample which is generated in step 2.  So actually the
> second sample is a stale sample and we should not generate it.
> 
> This patch is to add new argument 'new_packet' for cs_etm__flush(), we
> can pass 'true' for this argument if there have a new packet, otherwise
> it will pass 'false' for the purpose of only flushing branch stack
> entries and avoid to generate sample for stale packet.

Very good explanation, thanks for taking the time to write this.

> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/cs-etm.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index fe18d7b..f4fa877 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -955,7 +955,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq)
>  	return 0;
>  }
>  
> -static int cs_etm__flush(struct cs_etm_queue *etmq)
> +static int cs_etm__flush(struct cs_etm_queue *etmq, bool new_packet)
>  {
>  	int err = 0;
>  	struct cs_etm_auxtrace *etm = etmq->etm;
> @@ -989,6 +989,20 @@ static int cs_etm__flush(struct cs_etm_queue *etmq)
>  
>  	}
>  
> +	/*
> +	 * If 'new_packet' is false, this time call has no a new packet
> +	 * coming and 'etmq->packet' contains the stale packet which is
> +	 * set at the previous time with packets swapping.  In this case
> +	 * this function is invoked only for flushing branch stack at
> +	 * the end of buffer handling.
> +	 *
> +	 * Simply to say, branch samples should be generated when every
> +	 * time receive one new packet; otherwise, directly bail out to
> +	 * avoid generate branch sample with stale packet.
> +	 */
> +	if (!new_packet)
> +		return 0;
> +
>  	if (etm->sample_branches &&
>  	    etmq->prev_packet->sample_type == CS_ETM_RANGE) {
>  		err = cs_etm__synth_branch_sample(etmq);
> @@ -1075,7 +1089,7 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
>  					 * Discontinuity in trace, flush
>  					 * previous branch stack
>  					 */
> -					cs_etm__flush(etmq);
> +					cs_etm__flush(etmq, true);
>  					break;
>  				case CS_ETM_EMPTY:
>  					/*
> @@ -1092,7 +1106,7 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
>  
>  		if (err == 0)
>  			/* Flush any remaining branch stack entries */
> -			err = cs_etm__flush(etmq);
> +			err = cs_etm__flush(etmq, false);

I understand what you're doing and it will yield the correct results.  What I'm
not sure about is if we wouldn't be better off splitting cs_etm__flush()
in order to reduce the complexity of the main decoding loop.  That is rename
cs_etm__flush() to something like cs_etm__trace_on() and spin off a new
cs_etm__end_block().  

It does introduce a little bit of code duplication but I think we'd win in terms
of readability and flexibility.

Thanks,
Mathieu


>  	}
>  
>  	return err;
> -- 
> 2.7.4
> 
