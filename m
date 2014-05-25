From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 25 May 2014 21:09:47 +0200
Subject: [PATCH v2 5/7] ARM: KVM: one_reg coproc set and get BE fixes
In-Reply-To: <CAA3XUr0ELPxFsoQ+FyWXkoMEbOi=2VHGyhx_KU0bUz1ukAKx8w@mail.gmail.com>
References: <1392183693-21238-1-git-send-email-victor.kamensky@linaro.org>
 <1392183693-21238-6-git-send-email-victor.kamensky@linaro.org>
 <20140320011139.GK1297@cbox>
 <CAA3XUr0ELPxFsoQ+FyWXkoMEbOi=2VHGyhx_KU0bUz1ukAKx8w@mail.gmail.com>
Message-ID: <20140525190947.GA23583@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 13, 2014 at 01:11:34PM -0700, Victor Kamensky wrote:
> Hi Christoffer,
> 

[...]

> >> diff --git a/arch/arm/kvm/coproc.c b/arch/arm/kvm/coproc.c
> >> index 78c0885..64b2b94 100644
> >> --- a/arch/arm/kvm/coproc.c
> >> +++ b/arch/arm/kvm/coproc.c
> >> @@ -634,17 +634,61 @@ static struct coproc_reg invariant_cp15[] = {
> >>       { CRn( 0), CRm( 0), Op1( 1), Op2( 7), is32, NULL, get_AIDR },
> >>  };
> >>
> >> -static int reg_from_user(void *val, const void __user *uaddr, u64 id)
> >> +static int reg_from_user64(u64 *val, const void __user *uaddr, u64 id)
> >> +{
> >> +     unsigned long regsize = KVM_REG_SIZE(id);
> >> +     union {
> >> +             u32     word;
> >> +             u64     dword;
> >> +     } tmp = {0};
> >> +
> >> +     if (copy_from_user(&tmp, uaddr, regsize) != 0)
> >> +             return -EFAULT;
> >> +
> >> +     switch (regsize) {
> >> +     case 4:
> >> +             *val = tmp.word;
> >> +             break;
> >> +     case 8:
> >> +             *val = tmp.dword;
> >> +             break;
> >> +     }
> >> +     return 0;
> >> +}
> >
> > instead of allowing this 'packing 32 bit values in 64 bit values and
> > packing two 32 bit values in 64 bit values' kernel implementation'y
> > stuff to be passed to these user-space ABI catering function, I really
> > think you want to make reg_from_user64 deal with 64-bit registers, that
> > is, BUG_ON(KVM_REG_SIZE(id) != 8.
> 
> Example of kernel storing value in u64 but register is 32bit is
> set/get_invariant_cp15. Note this function passes struct coproc_reg
> val field address into reg_to_user_xxx function. Since struct coproc_reg
> is generic structure used to describe both 32bit and 64bit coproc registers
> val type cannot be changed to u32. One may try to describe
> val as union of u32 and u64 but I have concern that it would
> create bunch of 'if (KVM_REG_SIZE(id) == 4) { ... } else {  ..}'
> pieces all over the place. I think it is better to have function that
> just can read/write 32bit register from/to u64 value in kernel.

I know what the kernel does internally.  I just think these functions
become conceptually very complicated to cater to one special case.  You
could deal with this in the caller.  Consider get_invariant_cp15:

static int get_invariant_cp15(u64 id, void __user *uaddr)
{
	struct coproc_params params;
	const struct coproc_reg *r;

	if (!index_to_params(id, &params))
		return -ENOENT;

	r = find_reg(&params, invariant_cp15, ARRAY_SIZE(invariant_cp15));
	if (!r)
		return -ENOENT;

	if (KVM_REG_SIZE(id) == 4) {
		u32 val = r->val;
		ret = reg_to_user32(uaddr, &val, id);
	} else if (KVM_REG_SIZE(id) == 8) {
		ret = reg_to_user32(uaddr, &r->val, id);
	}
	return ret;
}

Did you actually try this approach and see how the code looks?

-Christoffer
