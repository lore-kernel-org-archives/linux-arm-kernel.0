From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 24 Apr 2017 15:03:48 +0100
Subject: [PATCH] arm64: pmuv3: Support v8.1 PMUv3 extension
In-Reply-To: <20170424133929.GA4952@localhost>
References: <1493033503-4712-1-git-send-email-jnair@caviumnetworks.com>
 <20170424125747.GA5767@leverpostej>
 <20170424133929.GA4952@localhost>
Message-ID: <20170424140348.GB5767@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 24, 2017 at 01:39:30PM +0000, Jayachandran C wrote:
> The v8.1 supplement is quite clear on the field definition:
>
> PMUVer, bits [11:8]
> ....
> Defined values are:
>       0000 Performance Monitors extension System registers not implemented.
>       0001 Performance Monitors extension System registers implemented, PMUv3.
>       0100 Performance Monitors extension System registers implemented, PMUv3, with a 16-bit
>            evtCount field, and if EL2 is implemented, the addition of the MDCR_EL2.HPMD bit.
>       1111 IMPLEMENTATION DEFINED form of performance monitors supported, PMUv3 not
>            supported.
>         All other values are reserved.
>         In ARMv8-A the permitted values are 0b0000, 0b0001 and 0b1111.
>         In ARMv8.1 the permitted values are 0b0000, 0b0100 and 0b1111.
>
> I changed the code to strictly do this. We have to exclude 0xf, since that is not PMUv3.
> And we cannot predict what the reserved values will represent, so it is best to skip them
> until they are defined to be PMUv3 compatible.

My understanding is that ID_AA64DFR0.PMUVer is intended to be covered by
the usual ID register principles, and thus at least 0x2-0x7 are reserved
for architected backwards compatible extensions to PMUv3.

See ARM DDI 0487B.a, D7.1.4, "Principles of the ID scheme for fields in
ID registers". It is explicitly stated that the scheme applies to
ID_AA64DFR0.

Per those rules, we should check >= the minimum PMUv3 implemented value,
i.e. val >= 1. Due to both 0x0 and 0xF meaning PMUv3 isn't implemented,
it's not clear if the fields should be treated as if it were signed or
unsigned, and I'm awaiting clarification on this.

Either way, I believe that 0x1-0x7 must all be compatible with baseline
PMUv3 per the ID scheme principles.

Thanks,
Mark.
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
