From: jan.glauber@caviumnetworks.com (Jan Glauber)
Date: Tue, 14 Nov 2017 15:19:36 +0100
Subject: RCU stall with high number of KVM vcpus
In-Reply-To: <e8e1af91-b755-e04e-6ab4-c47b570c9fe0@arm.com>
References: <20171113131000.GA10546@hc>
 <2832f775-3cbe-d984-fe4f-e018642b6f1d@arm.com>
 <20171113173552.GA13282@hc>
 <7dda7be2-f392-8056-d4d3-372bb867729a@arm.com>
 <20171113184046.GA14678@hc>
 <e8e1af91-b755-e04e-6ab4-c47b570c9fe0@arm.com>
Message-ID: <20171114141936.GA21650@hc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 14, 2017 at 01:30:07PM +0000, Marc Zyngier wrote:
> On 13/11/17 18:40, Jan Glauber wrote:
> > On Mon, Nov 13, 2017 at 06:11:19PM +0000, Marc Zyngier wrote:
> >> On 13/11/17 17:35, Jan Glauber wrote:
> >>> On Mon, Nov 13, 2017 at 01:47:38PM +0000, Marc Zyngier wrote:
> > 
> > [...]
> > 
> >>>> Please elaborate. Messed in what way? Corrupted? The guest crashing? Or
> >>>> is that a tooling issue?
> >>>
> >>> Every vcpu that oopses prints one line in parallel, so I get blocks like:
> >>> [58880.179814] [<ffff000008084b98>] ret_from_fork+0x10/0x18
> >>> [58880.179834] [<ffff000008084b98>] ret_from_fork+0x10/0x18
> >>> [58880.179847] [<ffff000008084b98>] ret_from_fork+0x10/0x18
> >>> [58880.179873] [<ffff000008084b98>] ret_from_fork+0x10/0x18
> >>> [58880.179893] [<ffff000008084b98>] ret_from_fork+0x10/0x18
> >>> [58880.179911] [<ffff000008084b98>] ret_from_fork+0x10/0x18
> >>> [58880.179917] [<ffff000008084b98>] ret_from_fork+0x10/0x18
> >>> [58880.180288] [<ffff000008084b98>] ret_from_fork+0x10/0x18
> >>> [58880.180303] [<ffff000008084b98>] ret_from_fork+0x10/0x18
> >>> [58880.180336] [<ffff000008084b98>] ret_from_fork+0x10/0x18
> >>> [58880.180363] [<ffff000008084b98>] ret_from_fork+0x10/0x18
> >>> [58880.180384] [<ffff000008084b98>] ret_from_fork+0x10/0x18
> >>> [58880.180415] [<ffff000008084b98>] ret_from_fork+0x10/0x18
> >>> [58880.180461] [<ffff000008084b98>] ret_from_fork+0x10/0x18
> >>>
> >>> I can send the full log if you want to have a look.
> >>
> >> Sure, send that over (maybe not over email though).
> > 
> > Here is the guest dmesg:
> > http://paste.ubuntu.com/25955682/
> 
> Yeah, that's because all the vcpus are getting starved at the same time,
> and spitting out interleaved traces... Not very useful anyway, as I
> think this is only a consequence of what's happening on the host.
> 
> > 
> > And the host dmesg as it might have been too big for the lists:
> > http://paste.ubuntu.com/25955699/
> 
> And that one doesn't show much either, apart from indicating that
> something is keeping the lock for itself. Drat.
> 
> We need to narrow down the problem, or make it appear on more common HW.
> Let me know if you've managed to reproduce it with non-VHE and/or on TX-1.

It also shows up when I disable VHE (CONFIG_ARM64_VHE). I'll try
enabling some tracepoints next.

--Jan
