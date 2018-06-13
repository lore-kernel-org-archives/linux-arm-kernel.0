From: nm@ti.com (Nishanth Menon)
Date: Wed, 13 Jun 2018 08:24:33 -0500
Subject: [U-Boot] [RFC PATCH 0/2] ARM: v7: Enable basic framework for
 supporting bits for CVE-2017-5715
In-Reply-To: <20180613100803.GB17671@n2100.armlinux.org.uk>
References: <20180125214559.27570-1-nm@ti.com>
 <CAOMZO5CcEf=EhFWknKmCXXLJPOgx=65jLH+X1OAGkg5VxBGVew@mail.gmail.com>
 <CAGo_u6qyf1Z+zSG-17TYRDPzG8V_0_-nk1F15HB4tPyT9rbUYQ@mail.gmail.com>
 <20180612214049.GA17671@n2100.armlinux.org.uk>
 <20180612215834.wrnfrb57ed3uxexa@kahuna>
 <20180613100803.GB17671@n2100.armlinux.org.uk>
Message-ID: <20180613132433.ho3o4uorfewgmytj@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:08-20180613, Russell King - ARM Linux wrote:
> On Tue, Jun 12, 2018 at 04:58:34PM -0500, Nishanth Menon wrote:
> > On 21:40-20180612, Russell King - ARM Linux wrote:
> > [...]
> > > > I started respinning the series, while there is definitely a use of
> > > > implementing in u-boot,
> > > > I am starting to wonder if we should also be doing this in kernel.
> > > 
> > > How does the kernel set the bit when the kernel is running in non-secure
> > > mode, when the ACTLR is read-only in that mode?
> > 
> > For OMAP5/DRA7 SMP systems, I just posted a patch that seems to resolve
> > it:
> > https://patchwork.kernel.org/patch/10461273/
> > 
> > This'd be similar in implementation to ARM erratum 801819 workaround
> > that needs two pieces (u-boot + kernel). I am not really worried about
> > OMAP5/DRA7 since they should'nt loose context in Low power modes.
> > Other SoCs need to be aware of the constraints.
> > 
> > /me wishes PSCI was a standard during ARMv7, but it was'nt... So
> > legacy v7 SoCs have implementations that are kind of different (even
> > smc calling conventions vary).
> 
> It may seem to be an easy way out (do everything in the kernel) but
> have you considered that the secure world is also vulnerable?

Yes, we have.

> If the IBE bit is not set in the secure world, then the secure world
> is not implementing the workarounds, and therefore the non-secure
> world has the possibility to use the Spectre vulnerabilities to
> exploit the secure world with enough effort and knowledge.
> 
> You really need to _also_ fix these vulnerabilities in the secure
> world, which includes setting the IBE bit there.

Correct, but, unfortunately, this is NOT always the case / not necessary in
some cases. Example:

On General purpose (GP) devices such as in OMAP, ROM owns the secure APIs,
there is no override of secure world APIs possible. In such cases, we
have to see if there is anything that needs to be protected. in case of
GP devices, there are no secure assets to protect and any SMC calls are
just support services provided by ROM.

a) updating secure side is not possible
b) secure side updates is not necessary since there are no critical run time
   services provided by ROM.

On devices such as Keystone 2 (TI) generation, yes, we do have ability
to update secure side and must be done as well.

-- 
Regards,
Nishanth Menon
