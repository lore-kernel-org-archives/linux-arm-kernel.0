From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 23 Aug 2011 18:17:04 +0100
Subject: ARM processor mode, kernel startup, Hyp / secure state
In-Reply-To: <20051.48809.945431.800543@mariner.uk.xensource.com>
References: <20051.48809.945431.800543@mariner.uk.xensource.com>
Message-ID: <CAHkRjk6N+OeeHZzS9hOnWKEg+aFUJVwT5Vf_PqO0cHv=2_9CnA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ian,

(I'll be on holiday from tomorrow, so not able to follow up until September).

On 23 August 2011 15:52, Ian Jackson <Ian.Jackson@eu.citrix.com> wrote:
> We're looking into porting Xen to the ARM A15 architecture. ?In this
> context, it's necessary to arrange for the Xen hypervisor to be
> entered from the boot loader in an appropriate processor mode.

We had some discussions both with ARM partners and Christoffer and it
is not clear how we go about initialising the Hyp mode. Most SoC
vendors would probably just run Linux in non-secure SVC mode and would
not touch the Hyp mode at all. Linux would issue an SMC to set the
HVBAR (could do HVC but I expect that there is no secure monitor
code). Once this is set, assuming that the Hyp MMU is disabled, Linux
can invoke an HVC and initialise the Hyp mode.

The problem is that the SMC API is specific to a secure monitor
implementation. An alternative would be to ask the vendors to get some
simple Hyp code which would trap access to HVBAR for example and set
it with that value.

> So I propose the following approach:
>
> ?1. The kernel will advertise via ELF notes what modes it may be
> ? ?started in. ?The possible modes will be:
> ? ? ? (i) ? secure monitor mode
> ? ? ? (ii) ?non-secure hypervisor mode
> ? ? ? (iii) non-secure kernel mode
