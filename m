From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 1 Jun 2015 22:45:25 +0100
Subject: [PATCH] ARM: Enter CPU in ARM state for cpu_resume
In-Reply-To: <1433190120-27798-1-git-send-email-sboyd@codeaurora.org>
References: <1433190120-27798-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150601214525.GT2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 01, 2015 at 01:22:00PM -0700, Stephen Boyd wrote:
> The standard boot protocol on ARM requires CPUs to be entered in
> the ARM state, unless they don't support the ARM instruction set
> (see Documentation/arm/Booting). On THUMB2 kernels, we assume
> the firmware can determine what state to enter the kernel in, but
> some firmwares don't honor the thumb bit. Make the cpu_resume
> symbol an ARM symbol, so that firmwares that honor the thumb bit
> will enter the kernel in ARM state and firmwares that don't honor
> the thumb bit will be able to enter the kernel in ARM state
> without more changes.
> 
> This fixes a problem reported by Kevin Hilman where the ifc6410 
> fails to boot for THUMB2 kernels because the platform's firmware
> always enters the kernel in ARM mode from deep idle states.

Please do this differently.  The default should be (as we do with
the SMP secondary entry path) to assume that the firmware does the
right thing.

So, if we want an ARM-mode entry point, please use:

+		.arm
+ENTRY(cpu_resume_arm)
+ THUMB(	badr	r9, 1f		)	@ Kernel is entered in ARM.
+ THUMB(	bx	r9		)	@ If this is a Thumb-2 kernel,
+ THUMB(	.thumb			)	@ switch to Thumb now.
+ THUMB(1:			)

Don't forget an ENDPROC() for the new symbol.  Buggy platforms then
use cpu_resume_arm instead of cpu_resume.

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
