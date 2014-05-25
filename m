From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 25 May 2014 20:26:01 +0200
Subject: [PATCH v3 13/14] ARM64: KVM: set and get of sys registers in BE
 case
In-Reply-To: <CAA3XUr0PigqiPwxUEMLvFoOaA8EzJfSteavqU4X1WoXSP2F4eA@mail.gmail.com>
References: <1399997646-4716-1-git-send-email-victor.kamensky@linaro.org>
 <1399997646-4716-14-git-send-email-victor.kamensky@linaro.org>
 <87lhu4hhou.fsf@approximate.cambridge.arm.com>
 <CAA3XUr0PigqiPwxUEMLvFoOaA8EzJfSteavqU4X1WoXSP2F4eA@mail.gmail.com>
Message-ID: <20140525182601.GA23711@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 14, 2014 at 07:18:26AM -0700, Victor Kamensky wrote:
> On 14 May 2014 01:45, Marc Zyngier <marc.zyngier@arm.com> wrote:

[...]

> >>
> >> -static int reg_from_user(void *val, const void __user *uaddr, u64 id)
> >> +static int reg_from_user(u64 *val, const void __user *uaddr, u64 id)
> >>  {
> >> -     /* This Just Works because we are little endian. */
> >> -     if (copy_from_user(val, uaddr, KVM_REG_SIZE(id)) != 0)
> >> +     unsigned long regsize = KVM_REG_SIZE(id);
> >> +
> >> +     BUG_ON(regsize != 8);
> >
> > I haven't had time to review this series just yet, but this bit just
> > sends chivers down my spine.
> >
> > regsize is derived from id, which comes from a struct one_reg, which is
> > directly provided by userspace. Here, you're trusting the luser to give
> > you 8 as a size, and panic the kernel if not.
> >
> > As much as I'd like to qualify this as only being a slightly undesirable
> > effect, I think it deserves a NAK.
> 
> Fair enough. I agree. Good catch! I was following on Christoffer's comments
> at [1], but I have not thought it through. Please advise should I come back to
> previous version as in [2] or just ignore any sizes other than 8 without
> having BUG_ON?
> 
> Thanks,
> Victor
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-March/241815.html
> [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-February/231891.html
> 
If the ABI doesn't define an ID for your arch (which is what I was
saying in my comment), simply return -EINVAL, but don't do BUG_ON(...).

-Christoffer
