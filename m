From: vinod.koul@intel.com (Vinod Koul)
Date: Sun, 13 Mar 2016 21:29:33 +0530
Subject: [PATCH V14 5/9] dma: qcom_hidma: implement lower level hardware
 interface
In-Reply-To: <56E31CA5.6040106@codeaurora.org>
References: <1454646882-24369-1-git-send-email-okaya@codeaurora.org>
 <1454646882-24369-6-git-send-email-okaya@codeaurora.org>
 <20160311020650.GG11154@localhost>
 <56E2EC1C.6040107@codeaurora.org>
 <20160311163221.GC13211@localhost> <56E2F5EA.10207@codeaurora.org>
 <56E31CA5.6040106@codeaurora.org>
Message-ID: <20160313155933.GD13211@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 11, 2016 at 02:29:41PM -0500, Sinan Kaya wrote:
> On 3/11/2016 11:44 AM, Sinan Kaya wrote:
> > On 3/11/2016 11:32 AM, Vinod Koul wrote:
> >>>>> memcpy(lldev->tre_ring + lldev->tre_write_offset, &tre->tre_local[0],
> >>>>>>>> +	       TRE_SIZE);
> >> This one

I would write this as:

memcpy(lldev->tre_ring + lldev->tre_write_offset,
		&tre->tre_local[0], TRE_SIZE);

To make it look more readable

> >>
> >>>>>>>> +	lldev->tx_status_list[tre->idx].err_code = 0;
> >>>>>>>> +	lldev->tx_status_list[tre->idx].err_info = 0;
> >>>>>>>> +	tre->queued = 1;
> >>>>>>>> +	lldev->pending_tre_count++;
> >>>>
> >>>> Is this the only one without alignment? I couldn't understand what you mean by 
> >>>> above one?
> >> quoting Coding Style:
> >>
> >> Statements longer than 80 columns will be broken into sensible chunks, unless
> >> exceeding 80 columns significantly increases readability and does not hide
> >> information. 
> > 
> >> "Descendants are always substantially shorter than the parent and
> >> are placed substantially to the right."
> >>
> >>
> > 
> > Sorry for my poor English. I never got this rule. 
> > 
> > Which one is a "substantially" right? Can you give me an example?
> > 
> > I need to understand how you'd write this to satisfy the above rule.
> > 
> > like this:
> > 
> > memcpy(lldev->tre_ring + lldev->tre_write_offset, &tre->tre_local[0],
> >        TRE_SIZE);

No

> > 
> > or
> > 
> > memcpy(lldev->tre_ring + lldev->tre_write_offset,
> >        &tre->tre_local[0], TRE_SIZE);

Better or above

> > 
> > or
> > 
> > memcpy(lldev->tre_ring + lldev->tre_write_offset, &tre->tre_local[0],
> > 							   TRE_SIZE);

This doesnt look very readable IMHO, mostly try to use common sense and if
it looks good and easy to read then you might have nailed it :)


> > 
> > or
> > 
> > memcpy(lldev->tre_ring + lldev->tre_write_offset,
> > 	&tre->tre_local[0], 
> > 	TRE_SIZE);
> > 
> so, I looked at other examples in drivers/dma/dw/core.c file...
> 
> I'm seeing two different patterns in the code. One pattern is to align
> the next line to the first character of the first line like I did based
> on the previous review comments.
> 
> 	mem_width = min_t(unsigned int,
>                           data_width, dwc_fast_ffs(mem | len));
> 
> The second example places an extra tab like this.
> 
> 	list_add_tail(&desc->desc_node,
> 			&first->tx_list);
> 
> 
> Based on this example: this is how I'm changing the second one
> 
> +       lldev->tre_write_offset = (lldev->tre_write_offset + HIDMA_TRE_SIZE)
> +                                       % lldev->tre_ring_size;
> +
> 
> I'm still not sure what you want to do with this:
> 
> Is this what you want to do ?
>         memcpy(lldev->tre_ring + lldev->tre_write_offset, &tre->tre_local[0],
> -              HIDMA_TRE_SIZE);
> +               HIDMA_TRE_SIZE);
> 
> I also got flagged before that HIDMA_TRE_SIZE does not start from the first 
> character.
> 
> I have done the renaming. This is all left for me to post a follow up.

OK

-- 
~Vinod
