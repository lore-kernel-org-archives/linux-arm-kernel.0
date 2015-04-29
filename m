From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 29 Apr 2015 09:58:36 -0400 (EDT)
Subject: [RFC] arm: pick the r2 passed DTB over the appended one
In-Reply-To: <5540A0DA.9060409@keymile.com>
References: <1429880030-21473-1-git-send-email-valentin.longchamp@keymile.com>
 <alpine.LFD.2.11.1504282315320.1582@knanqh.ubzr>
 <5540A0DA.9060409@keymile.com>
Message-ID: <alpine.LFD.2.11.1504290929090.1582@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 29 Apr 2015, Valentin Longchamp wrote:

> On 04/29/2015 05:50 AM, Nicolas Pitre wrote:
> > On Fri, 24 Apr 2015, Valentin Longchamp wrote:
> > 
> >> Uncompressing Linux... done, booting the kernel.
> >> e5943000
> > 
> > Where is this value from? This looks like an ARM opcode ("ldr r3, [r4]").
> 
> This value that I print out actually is the content of the memory pointed by the
> r2 register, printed from __vet_atags (head-common.S)
> 
> It can very well be an ARM opcode from the kernel binary since the r2 register
> does not point to a DTB but to some other location.

What is the value of r2 at that point?

> I now have further debugged this and I now understand why it does not work as I
> expect it: I have noticed that (at least with our kernel and our system) this
> code gets executed twice. This is has the consequence for the case where the DTB
> is appended and atags are passed to r2, my check is valid the first time this
> code is run. However, the second time, r8 (pointer to atags/dtb) was updated
> with r6 (pointer to _edata/appended dtb), which means that my additional check
> will cause the code to jump to dtb_check_done. So the DTB is not copied over
> with the rest of the kernel binary, because r6, r10 and sp and not "relocated"
> past the dtb !
> 
> Now my question is: is this normal that this code is executed twice or is a
> problem on our side ? If it is normal, I need to add further checks. If not, I
> would rather keep my implementation roughly as it is and rather troubleshoot
> this "double execution".

The double execution is "normal".  The code checks if itself and the 
compressed payload is in the way of the decompressed kernel. If it is 
then it relocates itself to avoid being overwritten. Once relocated, 
execution starts over again to keep things simple.

When a DTB is appended to zImage, then it has to be relocated alongside 
the compressed payload for the same reasons. For this, we need to 
determine the actual size of the DTB. That's where r6 is adjusted to 
pretend the DTB is part of the actual zImage.

Yet if CONFIG_ARM_ATAG_DTB_COMPAT is set, this has to be performed 
before the relocation as it may well change the size of the DTB.

Now, to fix your test, you'd simply have to augment it with:

+		cmp	r6, r8		@ is r8 pointing to the appended DTB?
+		beq	1f
		ldr	lr, [r8, #0]	@ conventionaly passed dtb ?
		cmp	lr, r1
		beq	dtb_check_done	@ yes, do not manage it
+1:


Nicolas
