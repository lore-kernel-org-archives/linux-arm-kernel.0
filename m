From: luc.vanoostenryck@gmail.com (Luc Van Oostenryck)
Date: Thu, 29 Jun 2017 16:55:22 +0200
Subject: [PATCH] arm64: fix endianness annotation for 'struct jit_ctx'
 and friends
In-Reply-To: <20170629100835.GE14607@arm.com>
References: <20170628145803.24543-1-luc.vanoostenryck@gmail.com>
 <20170629100835.GE14607@arm.com>
Message-ID: <20170629145521.5wrrmqgvbikdnapk@ltop.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 29, 2017 at 11:08:36AM +0100, Will Deacon wrote:
> Happy to take this via the arm64 tree, along with the other sparse fixes
> (modulo review comments).

For info, together with the other endianness fixes I sent, this
fixes all the 'easy to fix' endianness annotations.

It remains:
- 2 or 3 small issues, just needing a cast, maybe with __force.
- Problems with probes. Those could probably be fixed
  by redefining [k]probe_opcode_t as __le32 instead of u32
  but I didn't looked at the consequences.
- 3 or 4 'impossible to solve properly by design' where things
  like the following is done:
	if (kvm_vcpu_is_be(vcpu)) {
		switch (len) {
		case 1:
			return data & 0xff;
		case 2:
			return be16_to_cpu(data & 0xffff);
		case 4:
			return be32_to_cpu(data & 0xffffffff);
		default:
			return be64_to_cpu(data);
		}
	} else {
		...
  This is done for kvm emulate & the kvm vgics


Cheers,
-- Luc
