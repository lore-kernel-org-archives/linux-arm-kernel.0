From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 Aug 2014 23:57:19 +0100
Subject: [RFC PATCH] kprobes: arm: enable OPTPROBES for arm 32
In-Reply-To: <1407335003.3006.38.camel@linaro1.home>
References: <1407223697-74911-1-git-send-email-wangnan0@huawei.com>
 <1407335003.3006.38.camel@linaro1.home>
Message-ID: <20140806225719.GW30282@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 06, 2014 at 03:23:23PM +0100, Jon Medhurst (Tixy) wrote:
> On Tue, 2014-08-05 at 15:28 +0800, Wang Nan wrote:
> > +static inline int
> > +arm_branch_to_addr(unsigned int *pinst, void *src, void *dest)
> > +{
> > +	unsigned int inst = 0xea000000;
> > +	long offset = (unsigned long)(dest) -
> > +			((unsigned long)(src) + 8);
> > +	if ((offset > 0x3fffffc) || (offset < -0x3fffffc)) {
> > +		printk(KERN_WARNING "Failed to instrument %pS to %pS\n", src, dest);
> > +		return -EINVAL;
> > +	}
> > +
> > +	inst |= (((unsigned long)offset) >> 2) & (0x00ffffffUL);
> > +	*pinst = inst;
> > +	return 0;
> > +}
> > +
> 
> This looks remarkably similar to the code in arch/arm/kernel/insn.c so I
> think you can probably just use the existing arm_gen_branch() function.

Which would be a better idea as the version found in insn.c is not
buggy.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
