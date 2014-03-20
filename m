From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 19 Mar 2014 20:01:23 -0700
Subject: [PATCH v2 5/7] ARM: KVM: one_reg coproc set and get BE fixes
In-Reply-To: <CAA3XUr2GT3M=-q2wnBBGmj+bYpoo1akKoiGdDqhPoYFsPmiebQ@mail.gmail.com>
References: <1392183693-21238-1-git-send-email-victor.kamensky@linaro.org>
 <1392183693-21238-6-git-send-email-victor.kamensky@linaro.org>
 <20140320011139.GK1297@cbox>
 <CAA3XUr2GT3M=-q2wnBBGmj+bYpoo1akKoiGdDqhPoYFsPmiebQ@mail.gmail.com>
Message-ID: <20140320030123.GN1297@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 19, 2014 at 06:48:07PM -0700, Victor Kamensky wrote:
> Hi Christoffer,
> 
> Appreciate your time and review comments.
> Please see response inline.
> 
> On 19 March 2014 18:11, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> > On Tue, Feb 11, 2014 at 09:41:31PM -0800, Victor Kamensky wrote:
> >> Fix code that handles KVM_SET_ONE_REG, KVM_GET_ONE_REG ioctls to work in BE
> >> image. Before this fix get/set_one_reg functions worked correctly only in
> >> LE case - reg_from_user was taking 'void *' kernel address that actually could
> >> be target/source memory of either 4 bytes size or 8 bytes size, and code copied
> >> from/to user memory that could hold either 4 bytes register, 8 byte register
> >> or pair of 4 bytes registers.
> >>
> >> For example note that there was a case when 4 bytes register was read from
> >> user-land to kernel target address of 8 bytes value. Because it was working
> >> in LE, least significant word was memcpy(ied) and it just worked. In BE code
> >> with 'void *' as target/source 'val' type it is impossible to tell whether
> >> 4 bytes register from user-land should be copied to 'val' address itself
> >> (4 bytes target) or it should be copied to 'val' + 4 (least significant word
> >> of 8 bytes value). So first change was to introduce strongly typed
> >> functions, where type of target/source 'val' is strongly defined:
> >>
> >> reg_from_user64 - reads register from user-land to kernel 'u64 *val'
> >>                   address; register size could be 4 or 8 bytes
> >> reg_from_user32 - reads register(s) from user-land to kernel 'u32 *val'
> >>                   address; note it could be one or two 4 bytes registers
> >> reg_to_user64 -   writes reigster from kernel 'u64 *val' address to
> >
> > s/reigster/register/
> >
> >>                   user-land register memory; register size could be
> >>                   4 or 8 bytes
> >> ret_to_user32 -   writes register(s) from kernel 'u32 *val' address to
> >>                   user-land register(s) memory; note it could be
> >>                   one or two 4 bytes registers
> >
> > If we are really going to keep this scheme, then please add these
> > comments to functions themselves.
> >
> >>
> >> All places where reg_from_user, reg_to_user functions were used, were changed
> >> to use either corresponding 64 or 32 bit variant of functions depending on
> >> type of source/target kernel memory variable.
> >>
> >> In case of 'u64 *val' and register size equals 4 bytes, reg_from_user64
> >> and reg_to_user64 work only with least siginificant word of target/source
> >> kernel value.
> >>
> >> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
> >> ---
> >>  arch/arm/kvm/coproc.c | 94 +++++++++++++++++++++++++++++++++++++--------------
> >>  1 file changed, 69 insertions(+), 25 deletions(-)
> >>
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
> >
> > If the kernel stores what user space sees as a 32-bit register in a
> > 64-bit register, then let the caller deal with this mess.
> >
> > If the kernel stores what user space sees as a 64-bit register in two
> > 32-bit registers, then let the caller deal with that mess.
> >
> > Imagine someone who hasn't been through the development of this code
> > seeing these two functions for the first time without having read your
> > commit message, I think the margin for error here is too large.
> >
> > If you can share these functions like Alex suggests, then that would
> > make for a much cleaner function API as well.
> 
> During LCA14 I had discussion with Alex about changing and sharing
> one_reg endianness functions with ppc code and with V8 side as well ...
> Alex  outlined how it should be done and showed me ppc side of this
> code. He asked me to check with you before I start moving into this
> direction. I could not catch you during remaining LCA14 days. But
> now it looks you are on the same page ...

yeah, sorry, lots of stuff happening at Linaro Connect always.  I am all
for sharing this code.

> 
> Let me try to rework code along Alex's suggestion and see how
> it will look like. I will take in account your above suggestions and will
> try to clean 64/32 bit overload. Since it will have bigger scope and
> shared with ppc side I wonder maybe I should pull this patch out of
> this series and handle it as later additions.
> 

I think you should have that as a preparatory patch series on which this
series depends.

Thanks,
-Christoffer
