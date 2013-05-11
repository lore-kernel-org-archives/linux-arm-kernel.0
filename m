From: peter.maydell@linaro.org (Peter Maydell)
Date: Sat, 11 May 2013 08:51:42 +0100
Subject: [PATCH v3 24/32] arm64: KVM: 32bit GP register access
In-Reply-To: <20130511003630.GD30999@chazy>
References: <1365437854-30214-1-git-send-email-marc.zyngier@arm.com>
 <1365437854-30214-25-git-send-email-marc.zyngier@arm.com>
 <20130502160906.GI20730@arm.com>
 <51892B90.8060706@arm.com> <20130507163303.GH29757@arm.com>
 <20130511003630.GD30999@chazy>
Message-ID: <CAFEAcA8fwdUbLPNH0Y_3VY4MztocBL7uqxf8TZDX=Q8Pvej5bg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 May 2013 01:36, Christoffer Dall <cdall@cs.columbia.edu> wrote:
> That all being said, we can remove the check.  I don't think, however,
> that it being an unlikely thing is a good argument: if we remove the
> check we need to make sure that the VM does whatever the architecture
> dictates, which I assume is to not skip the MMIO instruction and support
> setting the PC to the value returned from an I/O emulation device in
> QEMU.
>
> I think the scenario sounds crazy and is more than anything a sign of a
> bug somewhere, and whether it should be a PABT or a DABT is a judgement
> call, but I chose a PABT because the thing that's weird is jumping to an
> I/O address, it's not that the memory address for the load is
> problematic.

I'm confused -- in your first paragraph you talk about loading
PC from an MMIO region but in the second you talk about jumping
to an MMIO region. This check is catching the former, right?

Loading PC from a device isn't totally unheard of: the VIC (common
on ARM7) has a register which returns "address of the next interrupt
to take", with the intention that the IRQ vector can just have a
single instruction directly loading PC from the VIC register:
http://infocenter.arm.com/help/topic/com.arm.doc.ddi0273a/I1006455.html

Handling "executing code out of an MMIO region" is (a) rather
harder and (b) not necessary IMHO. QEMU's TCG emulation doesn't
support it and we haven't had huge "can't run this guest"
issues as a result.

thanks
-- PMM
