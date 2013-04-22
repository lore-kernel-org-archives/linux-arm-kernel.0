From: will.deacon@arm.com (Will Deacon)
Date: Mon, 22 Apr 2013 17:41:12 +0100
Subject: [RFC PATCH v2 00/13] ARM: DT cpu bindings updates
In-Reply-To: <1366644455-16550-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1366644455-16550-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20130422164112.GB3076@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

On Mon, Apr 22, 2013 at 04:27:22PM +0100, Lorenzo Pieralisi wrote:
> Code relying on the reg property size to be 4-bytes will break when
> dtb compiled for 64-bit kernels are used to boot a 32-bit system so
> kernel code relying on that (bogus) assumption must be updated properly.

So that code currently includes kvmtool, and I think it's unfair to break
it:

	- kvmtool can boot either 32-bit or 64-bit guests under a 64-bit
	  kernel and only AFF0 is exposed by the KVM host (containing the
	  vcpu id). This allows us to use a single cell for the reg
	  property, regardless of the guest payload.

	- It always sets the #address-cells property correctly, so if it
	  passes a 32-bit reg property, then #address-cells will be 0x1

	- This scheme worked fine with older kernels

Why can't we instead allow the kernel to zero extend single-cell CPU reg
properies on 64-bit systems? We can always check them against the logical
map and barf if they don't match what's sitting in the hardware, without
penalising machines which don't make use of the upper bits. Given that
people *will* run 32-bit OSs on 64-bit CPUs (a use-case which we allow), I
don't think penalising 64-bit software is the right thing to do.

Thoughts? I notice Catalin has some patches queued for arm64 which
unconditionally use of_property_read_u64, but I have a patch to honour the
#address-cells property instead.

Will
