From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 25 Aug 2017 22:43:41 +0200 (CEST)
Subject: [PATCH v2 1/1] futex: remove duplicated code and fix UB
In-Reply-To: <20170824094756.GA6346@arm.com>
References: <20170824073105.3901-1-jslaby@suse.cz>
 <20170824094756.GA6346@arm.com>
Message-ID: <alpine.DEB.2.20.1708252243020.2124@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 24 Aug 2017, Will Deacon wrote:
> On Thu, Aug 24, 2017 at 09:31:05AM +0200, Jiri Slaby wrote:
> > +static int futex_atomic_op_inuser(unsigned int encoded_op, u32 __user *uaddr)
> > +{
> > +	unsigned int op =	  (encoded_op & 0x70000000) >> 28;
> > +	unsigned int cmp =	  (encoded_op & 0x0f000000) >> 24;
> > +	int oparg = sign_extend32((encoded_op & 0x00fff000) >> 12, 12);
> > +	int cmparg = sign_extend32(encoded_op & 0x00000fff, 12);
> > +	int oldval, ret;
> > +
> > +	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28)) {
> > +		if (oparg < 0 || oparg > 31)
> > +			return -EINVAL;
> > +		oparg = 1 << oparg;
> > +	}
> > +
> > +	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
> > +		return -EFAULT;
> > +
> > +	ret = arch_futex_atomic_op_inuser(op, oparg, &oldval, uaddr);
> > +	if (ret)
> > +		return ret;
> 
> We could move the pagefault_{disable,enable} calls here, and then remove
> them from the futex_atomic_op_inuser callsites elsewhere in futex.c

Correct, but we can do that after getting this in.

Thanks,

	tglx
