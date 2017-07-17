From: okaya@codeaurora.org (okaya at codeaurora.org)
Date: Mon, 17 Jul 2017 19:07:00 -0400
Subject: [PATCH] nvme: Acknowledge completion queue on each iteration
In-Reply-To: <20170717225615.GB1496@localhost.localdomain>
References: <1500330983-27501-1-git-send-email-okaya@codeaurora.org>
 <20170717224551.GA1496@localhost.localdomain>
 <6d10032c-35ec-978c-6b8f-1ab9c07adf7f@codeaurora.org>
 <20170717225615.GB1496@localhost.localdomain>
Message-ID: <79413407294645f0e1252112c3435a29@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-07-17 18:56, Keith Busch wrote:
> On Mon, Jul 17, 2017 at 06:46:11PM -0400, Sinan Kaya wrote:
>> Hi Keith,
>> 
>> On 7/17/2017 6:45 PM, Keith Busch wrote:
>> > On Mon, Jul 17, 2017 at 06:36:23PM -0400, Sinan Kaya wrote:
>> >> Code is moving the completion queue doorbell after processing all completed
>> >> events and sending callbacks to the block layer on each iteration.
>> >>
>> >> This is causing a performance drop when a lot of jobs are queued towards
>> >> the HW. Move the completion queue doorbell on each loop instead and allow new
>> >> jobs to be queued by the HW.
>> >
>> > That doesn't make sense. Aggregating doorbell writes should be much more
>> > efficient for high depth workloads.
>> >
>> 
>> Problem is that code is throttling the HW as HW cannot queue more 
>> completions until
>> SW get a chance to clear it.
>> 
>> As an example:
>> 
>> for each in N
>> (
>> 	blk_layer()
>> )
>> ring door bell
>> 
>> HW cannot queue new job until N x blk_layer operations are processed 
>> and queue
>> element ownership is passed to the HW after the loop. HW is just 
>> sitting idle
>> there if no queue entries are available.
> 
> If no completion queue entries are available, then there can't possibly
> be any submission queue entries for the HW to work on either.

Maybe, I need to understand the design better. I was curious why 
completion and submission queues were protected by a single lock causing 
lock contention.

I was treating each queue independently. I have seen slightly better 
performance by an early doorbell. That was my explanation.
