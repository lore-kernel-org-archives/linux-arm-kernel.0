From: dnelson@redhat.com (Dean Nelson)
Date: Mon, 11 Jun 2018 06:22:14 -0500
Subject: [PATCH] net: thunderx: prevent concurrent data re-writing by
 nicvf_set_rx_mode
In-Reply-To: <20180610.123551.885190586229525170.davem@davemloft.net>
References: <20180608092759.28059-1-Vadim.Lomovtsev@caviumnetworks.com>
 <20180610.123551.885190586229525170.davem@davemloft.net>
Message-ID: <036618ae-887f-44b5-2b39-451b81191cc1@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/10/2018 02:35 PM, David Miller wrote:
> From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
> Date: Fri,  8 Jun 2018 02:27:59 -0700
> 
>> +	/* Save message data locally to prevent them from
>> +	 * being overwritten by next ndo_set_rx_mode call().
>> +	 */
>> +	spin_lock(&nic->rx_mode_wq_lock);
>> +	mode = vf_work->mode;
>> +	mc = vf_work->mc;
>> +	vf_work->mc = NULL;

If I'm reading this code correctly, I believe nic->rx_mode_work.mc will
have been set to NULL before the lock is dropped by
nicvf_set_rx_mode_task() and acquired by nicvf_set_rx_mode().


>> +	spin_unlock(&nic->rx_mode_wq_lock);
> 
> At the moment you drop this lock, the memory behind 'mc' can be
> freed up by:
> 
>> +	spin_lock(&nic->rx_mode_wq_lock);
>> +	kfree(nic->rx_mode_work.mc);

So the kfree() will be called with a NULL pointer and quickly return.


> 
> And you'll crash when you dereference it above via
> __nicvf_set_rx_mode_task().
> 

I believe the call to kfree() in nicvf_set_rx_mode() is there to free
up a mc_list that has been allocated by nicvf_set_rx_mode() during a
previous callback to the function, one that has not yet been processed
by nicvf_set_rx_mode_task().

In this way only the last 'unprocessed' callback to nicvf_set_rx_mode()
gets processed should there be multiple callbacks occurring between the
times the nicvf_set_rx_mode_task() runs.

In my testing with this patch, this is what I see happening.
