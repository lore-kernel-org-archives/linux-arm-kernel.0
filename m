From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 9 May 2012 13:23:48 +0100
Subject: [PATCH] ARM: decompressor: Fix mmu mapping for non-DRAM
 address space.
In-Reply-To: <CAMQu2gzmZ1Af4sAxoT9WS_akY1gBrqffKE84rnbM_EUK8V8NHQ@mail.gmail.com>
References: <1336398149-26153-1-git-send-email-santosh.shilimkar@ti.com>
 <20120508124116.GE17798@arm.com>
 <CAMQu2gxXB4GyddjrcKWwJ=KXx=MoDs7DdwhbOY85qkVJ1Vv3wA@mail.gmail.com>
 <20120508215554.GA18980@n2100.arm.linux.org.uk>
 <CAMQu2gzmZ1Af4sAxoT9WS_akY1gBrqffKE84rnbM_EUK8V8NHQ@mail.gmail.com>
Message-ID: <20120509122348.GA30632@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2012 at 02:20:28PM +0530, Shilimkar, Santosh wrote:
> The only change done common code is  clearing 'XN' bit for DRAM
> region in page table entries. The other change of setting the DACR
> register is done in ARMv7 specific code.

Yes, XN is an ARMv6+ thing.  Before ARMv5, it was implementation defined.

Some implementations used the bit to mean "allow writes to update the
cache".  Other implementations labelled this bit as "should be zero"
while others labelled it as "should be one".

The upshot of this is, we know that having this bit as '1' means that
all the CPUs we support today work.  I would be _very_ concerned to
change this bit to zero as we _really_ don't know how the pre-ARMv6
CPUs would react.

The solution to this is pretty simple - if ARMv6+ needs a different
base section mapping value, then we need to extract that from the code
and pass in the base section mapping value.

I'll sort out a patch later today for this.
