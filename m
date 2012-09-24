From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Sep 2012 23:40:21 +0100
Subject: [PATCH v3 RESEND 05/17] ARM: LPAE: support 64-bit virt_to_phys
 patching
In-Reply-To: <alpine.LFD.2.02.1209241826260.6667@xanadu.home>
References: <1348242975-19184-1-git-send-email-cyril@ti.com>
 <1348242975-19184-6-git-send-email-cyril@ti.com>
 <20120924151305.GA14198@arm.com>
 <alpine.LFD.2.02.1209241152540.6667@xanadu.home> <5060C9C6.8080900@ti.com>
 <alpine.LFD.2.02.1209241709200.6667@xanadu.home>
 <CAHkRjk74aHMNZxOVgsQo-NTm33ALZPVeiPAP5amCdBdF4-yjWw@mail.gmail.com>
 <alpine.LFD.2.02.1209241826260.6667@xanadu.home>
Message-ID: <20120924224021.GJ26454@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 24, 2012 at 06:32:22PM -0400, Nicolas Pitre wrote:
> We don't want to limit lowmem.  The lowmem is very precious memory and 
> we want to maximize its size.  In that case it is probably best to 
> implement a real patchable 64-bit addition rather than artificially 
> restricting the lowmem size.

You don't need to.  You can solve the V->P translation like this:

        movw    %hi, #0xVWXY            @ fixup
        adds    %lo, %lo, #offset       @ fixup
        adc     %hi, %hi, #0

which is probably the simplest way to do the fixup - keep the existing
fixup code, and add support for that movw instruction.  And that will
work across any 4GB boundary just fine (we won't have more than 4GB of
virtual address space on a 32-bit CPU anyway, so we only have to worry
about one carry.)

And the P->V translation is truncating anyway, so that is just:

	sub	%lo, %lo, #offset

and nothing more.
