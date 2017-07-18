From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 18 Jul 2017 14:52:26 -0400
Subject: [PATCH] nvme: Acknowledge completion queue on each iteration
In-Reply-To: <20170718143617.GA7613@localhost.localdomain>
References: <1500330983-27501-1-git-send-email-okaya@codeaurora.org>
 <20170717224551.GA1496@localhost.localdomain>
 <6d10032c-35ec-978c-6b8f-1ab9c07adf7f@codeaurora.org>
 <20170717225615.GB1496@localhost.localdomain>
 <79413407294645f0e1252112c3435a29@codeaurora.org>
 <20170718143617.GA7613@localhost.localdomain>
Message-ID: <dada875c-ed69-0126-8e83-78a564e6b4bd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/18/2017 10:36 AM, Keith Busch wrote:
> On Mon, Jul 17, 2017 at 07:07:00PM -0400, okaya at codeaurora.org wrote:
>> Maybe, I need to understand the design better. I was curious why completion
>> and submission queues were protected by a single lock causing lock
>> contention.
> Ideally the queues are tied to CPUs, so you couldn't have one thread
> submitting to a particular queue-pair while another thread is reaping
> completions from it. Such a setup wouldn't get lock contention.

I do see that the NVMe driver is creating a completion interrupt on
each CPU core for the completions. No problems with that. 

However, I don't think you can guarantee that there will always be a single
CPU core targeting one submission queue especially with asynchronous IO.

Lock contention counters from CONFIG_LOCK_STAT are pointing to nvmeq->lock
in my FIO tests.

Did I miss something?

> 
> Some machines have so many CPUs, though, that sharing hardware queues
> is required. We've experimented with separate submission and completion
> locks for such cases, but I've never seen an improved performance as a
> result.
> 

I have also experimented with multiple locks with no significant gains. 
However, I was curious if somebody else had a better implementation than mine.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
