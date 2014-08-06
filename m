From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 Aug 2014 23:55:03 +0100
Subject: [RFC PATCH] kprobes: arm: enable OPTPROBES for arm 32
In-Reply-To: <1407223697-74911-1-git-send-email-wangnan0@huawei.com>
References: <1407223697-74911-1-git-send-email-wangnan0@huawei.com>
Message-ID: <20140806225503.GV30282@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 05, 2014 at 03:28:17PM +0800, Wang Nan wrote:
> This patch introduce kprobeopt for ARM 32.
> 
> Limitations:
>  - Currently only kernel compiled with ARM ISA is supported.
> 
>  - offset between probe point and kprobe pre_handler must not larger
>     than 64MiB. Masami Hiramatsu suggests replacing 2 words, it will
>     make things complex. Futher patch can make such optimization.

Why 64MiB?  I think you mean +/- 32MiB.

> +static inline int
> +arm_branch_to_addr(unsigned int *pinst, void *src, void *dest)
> +{
> +	unsigned int inst = 0xea000000;
> +	long offset = (unsigned long)(dest) -
> +			((unsigned long)(src) + 8);
> +	if ((offset > 0x3fffffc) || (offset < -0x3fffffc)) {
> +		printk(KERN_WARNING "Failed to instrument %pS to %pS\n", src, dest);
> +		return -EINVAL;
> +	}
> +
> +	inst |= (((unsigned long)offset) >> 2) & (0x00ffffffUL);

So if offset is 0x3fffffc, then inst becomes 0xea000000 |
((0x3fffffc >> 2) & 0x00ffffff), or 0xeaffffff.

If offset is -4, then offset is 0xfffffffc.  So inst becomes 0xea00000 |
((0xfffffffc >> 2) & 0x00ffffff), or 0xeaffffff.

To prove it, let's disassemble this instruction:

00000000 <.text>:
   0:   eafffffc        b       0xfffffff8

Yep, it branches backwards.  

The second point is you don't mean -0x3fffffc - that's not how two's
complement arithmetic works - the branch instruction offset is a
signed integer of 24 bits.  Bit 23 is the sign bit, it's maximum
positive value is 0x7fffff and it's maximum negative value is 0x800000.

Hence, you actually mean here 0x1fffffc (which gives the maximum
forward branch) and -0x2000000 (which gives the maximum backward
branch).

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
