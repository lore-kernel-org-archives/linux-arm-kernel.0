From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 1 Oct 2013 10:26:30 +0100
Subject: Status of ARM FIQ?
In-Reply-To: <F5184659D418E34EA12B1903EE5EF5FD8538E865F6@seldmbx02.corpusers.net>
References: <F5184659D418E34EA12B1903EE5EF5FD8538E865F6@seldmbx02.corpusers.net>
Message-ID: <20131001092623.GA2640@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 30, 2013 at 08:48:15PM +0200, Bird, Tim wrote:
> I'm working through some proposals for contract work for the Consumer
> Electronics Workgroup, and one of them involves use of ARM FIQ
> as a debug activator.  I have heard a rumor that FIQ mode is not being
> included in some modern ARM CPUs.
> 
> Is there any truth to this?  Can someone give me a pointer to information
> about this?

All CPUs implement FIQ, except for the M-class CPUS in v7 onwards (which
don't have an MMU, and thus could only run ucLinux).


As to whether you can use FIQ, "it depends":

Since the introduction of the Security Extensions in v6Z / v7,
FIQ can be repurposed as a private interrupt for the Secure World, so
if there is resident Secure World software, it may be impossible for
Linux to use FIQ.

Whether this does or doesn't apply depends on the SoC, and on how
it has been integrated and set up.  Consumer device SoCs, especially
anything coming to you via a mobile provider, will likely have this
restriction.  Dev boards may be a bit more relaxed.


John Stultz has been working on the FIQ debugger for Android and may
have some ideas.

I believe that the Virtualisation extensions allow virtual FIQs to be
delivered to the guest, so that KVM could send fake FIQs to guests even
if the KVM host cannot itself use FIQ.  I'm a bit hazy on this though,
and haven't played with it.

Cheers
---Dave
