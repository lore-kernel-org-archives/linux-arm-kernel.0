From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 15 Feb 2017 20:00:02 +0000
Subject: [PATCH v2 0/5] ARM: add module autoloading support for crypto
 modules
In-Reply-To: <1484154118-22139-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1484154118-22139-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20170215200002.GF27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2017 at 05:01:53PM +0000, Ard Biesheuvel wrote:
> This series wires up the crypto modules that use the ARM 32-bit versions of
> the ARMv8 Crypto Extensions to udev autoloading, by exposing the HWCAP2
> feature bits via the CPU modalias. This is very similar to the arm64
> implementation, with the notable exception that ARM has its CPU feature
> definitions split across HWCAP and HWCAP2.

Note that Aarch64 has:

MODALIAS=cpu:type:aarch64:feature:,0000,0001,0002,0003,0004,0005,0006,0007

which looks weird with the first numeric entry starting with a ','.

Now as for ARM, yes, we have the hwcap feature split across the two
(because HWCAP2 didn't exist originally.)  What I'm concerned about
is that restricting the initial implementation to HWCAP2 bits means
that we'd have to rework all users if we wanted to include the HWCAP
bits later on (consider what the change would be to add HWCAP_x
support to this later on.)

I would much rather we start out now with an offset of 32 on the
numeric value exposed to userspace, so that should we want to extend
it to the HWCAP field, we can do so safely.

While we're stuffing HWCAP2 with new bits, please note that it is
also limited to 32 bits, just like the HWCAP field is.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
