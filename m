From: will.deacon@arm.com (Will Deacon)
Date: Fri, 4 Aug 2017 15:58:35 +0100
Subject: [PATCH 1/2] perf/aux: Make aux_{head, wakeup} ring_buffer members
 long
In-Reply-To: <87ini8uci6.fsf@ashishki-desk.ger.corp.intel.com>
References: <1501260863-14687-1-git-send-email-will.deacon@arm.com>
 <87ini8uci6.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <20170804145835.GB6780@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 31, 2017 at 01:28:01PM +0300, Alexander Shishkin wrote:
> Will Deacon <will.deacon@arm.com> writes:
> 
> > The aux_head and aux_wakeup members of struct ring_buffer are defined
> > using the local_t type, despite the fact that they are only accessed via
> > the perf_aux_output_* functions, which cannot race with each other for a
> > given ring buffer.
> >
> > This patch changes the type of the members to long, so we can avoid
> > using the local_* API where it isn't needed.
> 
> Thanks for digging this up! Some minor nits below.
> 
> > @@ -434,12 +434,12 @@ void perf_aux_output_end(struct perf_output_handle *handle, unsigned long size)
> >  		handle->aux_flags |= PERF_AUX_FLAG_OVERWRITE;
> >  
> >  		aux_head = handle->head;
> > -		local_set(&rb->aux_head, aux_head);
> > +		rb->aux_head = aux_head;
> >  	} else {
> >  		handle->aux_flags &= ~PERF_AUX_FLAG_OVERWRITE;
> >  
> > -		aux_head = local_read(&rb->aux_head);
> > -		local_add(size, &rb->aux_head);
> > +		aux_head = rb->aux_head;
> > +		rb->aux_head += size;
> >  	}
> >  
> >  	if (size || handle->aux_flags) {
> > @@ -451,11 +451,11 @@ void perf_aux_output_end(struct perf_output_handle *handle, unsigned long size)
> >  		                     handle->aux_flags);
> >  	}
> >  
> > -	aux_head = rb->user_page->aux_head = local_read(&rb->aux_head);
> > +	aux_head = rb->user_page->aux_head = rb->aux_head;
> >  
> > -	if (aux_head - local_read(&rb->aux_wakeup) >= rb->aux_watermark) {
> > +	if (aux_head - rb->aux_wakeup >= rb->aux_watermark) {
> 
> Can't we just do away with aux_head here:
> 
>   rb->user_page->aux_head = rb->aux_head;
>   if (rb->aux_head - rb->aux_wakeup >= rb->aux_watermark) { ...
> 
> ?
> 
> > @@ -485,14 +485,13 @@ int perf_aux_output_skip(struct perf_output_handle *handle, unsigned long size)
> >  	if (size > handle->size)
> >  		return -ENOSPC;
> >  
> > -	local_add(size, &rb->aux_head);
> > +	rb->aux_head += size;
> >  
> > -	aux_head = rb->user_page->aux_head = local_read(&rb->aux_head);
> > -	if (aux_head - local_read(&rb->aux_wakeup) >= rb->aux_watermark) {
> > +	aux_head = rb->user_page->aux_head = rb->aux_head;
> > +	if (aux_head - rb->aux_wakeup >= rb->aux_watermark) {
> >  		perf_output_wakeup(handle);
> > -		local_add(rb->aux_watermark, &rb->aux_wakeup);
> > -		handle->wakeup = local_read(&rb->aux_wakeup) +
> > -				 rb->aux_watermark;
> > +		rb->aux_wakeup += rb->aux_watermark;
> > +		handle->wakeup = rb->aux_wakeup + rb->aux_watermark;
> >  	}
> >  
> >  	handle->head = aux_head;
> 
> And here I think we don't need aux_head at all.

Agreed on both counts. Will fix for v2.

Will
