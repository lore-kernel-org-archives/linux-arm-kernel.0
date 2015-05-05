From: stripathi@apm.com (Suman Tripathi)
Date: Tue, 5 May 2015 11:25:14 +0530
Subject: [PATCH v3 1/2] libahci: Add support to handle HOST_IRQ_STAT as
 edge trigger latch.
In-Reply-To: <20150504182618.GG1971@htj.duckdns.org>
References: <1430667220-23477-1-git-send-email-stripathi@apm.com>
 <1430667220-23477-2-git-send-email-stripathi@apm.com>
 <20150504154726.GA1971@htj.duckdns.org>
 <CAOHikRCZimsE+_-6dqTiCT6qRTFLp9VGt6=WHWA_Z86GBn+WRg@mail.gmail.com>
 <20150504182618.GG1971@htj.duckdns.org>
Message-ID: <CAOHikRBeM3MYohDgYgbLL1uhZp+Ch4hS+eduDVbx759321=EHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tejun,

On Mon, May 4, 2015 at 11:56 PM, Tejun Heo <tj@kernel.org> wrote:
> Hello,
>
> On Mon, May 04, 2015 at 10:13:11PM +0530, Suman Tripathi wrote:
>> AFAIK clearing host_irq_stat means we have handled port interrupts .
>> Now for our case we still have interrupts left because it didn't get
>> detected on
>> first ahci_port_intr.  So you  mean to handle that residual irq in the
>> next cycle (i mean next call intr handler ) ??
>
> Heh, I think we're talking past each other.  For level triggered IRQs,
> the latched IRQ bits should be cleared after handling the events;
> otherwise, the latched bits are gonna get set immediately as the
> events are still pending.  Also, this doesn't lose any events as
> they're level triggered latches - if any event is pending, the IRQ is
> gonna be raised again.
>
> Edge triggered latches are the other way around.  You should clear the
> latches before actually handling and clearing the events.  The pending
> events won't trigger the latches again as it's edge-triggered and the
> events which happens after this irq handling starts won't get lost as
> they'll be latched for the next round.

Yeah it's very simple. The clearing of irq_stat needs to move up.
That's it. tried and it worked. Thanks a lot !!
Just a quick question : Why edge trigger handling is not yet present
in libahci yet? I mean no one has used it yet ??

>
> Thanks.
>
> --
> tejun



-- 
Thanks,
with regards,
Suman Tripathi
