From: viresh.kumar@st.com (viresh kumar)
Date: Wed, 27 Apr 2011 11:29:49 +0530
Subject: [PATCH 1/6] dmaengine/dw_dmac: Replace spin_lock_bh with	irqsave
	variants
In-Reply-To: <20110426203306.GC17290@n2100.arm.linux.org.uk>
References: <e52c8e679fbf3007cf7e5e4bcfc86ea208a09d7c.1303123511.git.viresh.kumar@st.com>
	<4DAD2AE9.7060106@st.com>
	<20110426203306.GC17290@n2100.arm.linux.org.uk>
Message-ID: <4DB7B0D5.5050504@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/27/2011 02:03 AM, Russell King - ARM Linux wrote:
> On Tue, Apr 19, 2011 at 11:55:45AM +0530, viresh kumar wrote:
>> This must have been added in dw_dma_chan instead :(
>> Will resend it.
> 
> Even that doesn't work.  It has to be a local variable.

Hello,

There are two kinds of locks taken in dw_dmac: spin_lock_bh and spin_lock.
spin_lock_bh is taken from routines called from external drivers and spin_lock
taken inside tasklet.
For reasons mentioned earlier, spin_lock_bh has to be replaced with spin_lock_irqsave.

Now, Is simple spin_lock() sufficient inside tasklet?? As dma API's can be called
from interrupt context (which will try to take spin_lock_irqsave).

I think spin_lock must be replaced with irqsave variants, even in tasklet.
Now if we do that, do we need this tasklet at all??

-- 
viresh
