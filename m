From: vinod.koul@intel.com (Koul, Vinod)
Date: Tue, 23 Aug 2011 10:50:14 +0530
Subject: [PATCH 16/18] dmaengine/amba-pl08x: Add support for sg len
	greater than one for slave transfers
In-Reply-To: <4E532B19.6000103@st.com>
References: <cover.1311936523.git.viresh.kumar@st.com>
	<5d691ab0c4f447c9f324213d8d740ac61d1739a1.1311936524.git.viresh.kumar@st.com>
	<20110814083618.GE4986@n2100.arm.linux.org.uk>
	<4E4CCF7B.8060704@st.com>
	<20110821083306.GA12028@n2100.arm.linux.org.uk>
	<4E532B19.6000103@st.com>
Message-ID: <1314076814.22120.17.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-08-23 at 09:52 +0530, Viresh Kumar wrote:
> On 8/21/2011 2:03 PM, Russell King - ARM Linux wrote:
> >> > I am not sure if i get this completely. In memcpy, we still don't support
> >> > more than one sg. We have created a new member in txd, which keeps track of
> >> > data (addresses, len).
> > Yes, but we shouldn't need to translate it into any kind of scatterlist.
> > 
> 
> Ok. I way out is keeping two separate variables in txd, list for slave transfers,
> and pointer to single element for memcpy. And that looks to be even bad to me.
> Why waste memory, for second variable. Or create union of both.
> 
> One more thing, we can actually have scatter gather in memcpy too in future. This will be
> helpful then also. But surely that's something not implemented currently.
> 
There are few points for consideration:
1) Clients will calls tx_submit() and submit the descriptors, this
should push your descriptor to queued list
2) On issue_pending() you need to push the queued descriptors to dmac.
If your hardware can transfer multiple descriptors, then you should use
this and push all available descriptors to hardware.

This way you ensure optimal performance and give LLI for memcpy even
when you think API is not available.

If there are some use cases where we need scatterlist support for
memcpy, and if above doesn't satisfy, should be okay to add it.


-- 
~Vinod
