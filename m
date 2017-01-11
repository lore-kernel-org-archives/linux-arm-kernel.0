From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 11 Jan 2017 17:56:49 +0000
Subject: [RFC PATCH 1/2] ARM: vfp - allow kernel mode NEON in softirq
 context
In-Reply-To: <1483991849-32448-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1483991849-32448-1-git-send-email-ard.biesheuvel@linaro.org>
 <1483991849-32448-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20170111175649.GK14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2017 at 07:57:28PM +0000, Ard Biesheuvel wrote:
> This updates the kernel mode NEON handling to allow the NEON to be used
> in softirq context as well as process context. This involves disabling
> softirq processing when the NEON is used in kernel mode in process context,
> and dealing with the situation where 'current' is not the owner of the
> userland context that is present in the NEON register file when the NEON
> is enabled in kernel mode.

I really don't like this idea as-is.

We have cases where kernel code accesses VFP to (eg) save or restore
register state, such as during signal handling.  We assume that this
will not be interrupted by another user, and that if we enable access
to the VFP, it will stay enabled.  If it gets disabled beneath us, then
things won't go well.

For example, consider vfp_sync_hwstate():

vfp_sync_hwstate()
  vfp_state_in_hw() => true
    fpexc read
	softirq happens
		kernel_neon_begin()
		kernel_neon_end()
    fpexc re-enabled
    current register state saved out (corrupting what was there)
    fpexc restored, possible in an enabled state

Or we could have:

vfp_sync_hwstate()
  vfp_state_in_hw() => true
	softirq happens
		kernel_neon_begin()
		kernel_neon_end()
    fpexc read
    fpexc re-enabled
    current register state saved out (corrupting what was there)
    fpexc disabled

Or worse:

vfp_sync_hwstate()
  vfp_state_in_hw() => true
    fpexc read
    fpexc re-enabled
	softirq happens
		kernel_neon_begin()
		kernel_neon_end()
    current register state saved out, blowing up because VFP is
     unexpectedly disabled

So we would need to disable softirqs around every sensitive point in the
VFP support code, and over all VFP instruction emulations for those VFPs
which bounce "difficult" operations to the kernel support code.

> The rationale for this change is that the NEON is shared with the ARMv8
> Crypto Extensions (which are also defined for the AArch32 execution state),
> which can give a huge performance boost (15x) to use cases like mac80211
> CCMP processing, which executes in softirq context.

I think, once the implementation is more correct, this would need to
be re-evaluated, and I'd also like other more general performance
measurements as well (eg, latency.)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
