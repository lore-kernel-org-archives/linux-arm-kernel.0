From: will.deacon@arm.com (Will Deacon)
Date: Fri, 17 Feb 2017 14:00:01 +0000
Subject: [PATCH 07/10] perf: Directly pass PERF_AUX_* flags to
 perf_aux_output_end
In-Reply-To: <8737fdj5q0.fsf@ashishki-desk.ger.corp.intel.com>
References: <1485540470-11469-1-git-send-email-will.deacon@arm.com>
 <1485540470-11469-8-git-send-email-will.deacon@arm.com>
 <8737fdj5q0.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <20170217140001.GD15431@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 17, 2017 at 03:40:23PM +0200, Alexander Shishkin wrote:
> Will Deacon <will.deacon@arm.com> writes:
> 
> > @@ -485,7 +485,8 @@ int intel_bts_interrupt(void)
> >  		return handled;
> >  
> >  	perf_aux_output_end(&bts->handle, local_xchg(&buf->data_size, 0),
> > -			    !!local_xchg(&buf->lost, 0));
> > +			    local_xchg(&buf->lost, 0) ?
> > +			    PERF_AUX_FLAG_OVERWRITE : 0);
> 
> Heh, this one would have taken some time to debug. :)

Don't worry, this isn't a bug fix! This patch changes the prototype for
perf_aux_output_end so that it takes the flag instead of a "bool truncated"
parameter, so this is just fixing up the callers at the same time.

Will
