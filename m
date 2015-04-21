From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 21 Apr 2015 11:07:17 +0100
Subject: [PATCH 2/2] ARM: prefer "bx reg" over "mov pc, reg" for all
 registers
In-Reply-To: <1429607372-7598-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1429607205-7501-1-git-send-email-ard.biesheuvel@linaro.org>
 <1429607372-7598-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150421100717.GS12732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 21, 2015 at 11:09:32AM +0200, Ard Biesheuvel wrote:
> Commit 6ebbf2ce437b (ARM: convert all "mov.* pc, reg" to "bx reg"
> for ARMv6+) replaced all occurrences of 'mov pc, <reg>' with the
> 'ret' macro. However, this macro only emits the 'bx' instruction
> when used with the 'lr' register, but still uses 'mov pc, <reg>'
> for everything else.
> 
> Since ARM/Thumb2 interworking is allowed in the static kernel
> (i.e., inside vmlinux), this is potentially unsafe, since the mov
> instruction will not switch modes based on the Thumb bit.
> 
> So instead, emit the 'bx' instruction in all cases, and not just
> for the 'lr' register.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

NAK.  This is very much intentional, but I'm unable to explain why
publically.  Not every "mov pc, xx" should be a bx instruction.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
