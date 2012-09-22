From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 22 Sep 2012 15:17:14 +0200
Subject: [PATCH 2/5] ARM: Add interface for registering and calling
 firmware-specific operations
In-Reply-To: <20120922062322.GA6264@quad.lixom.net>
References: <1347524018-19301-1-git-send-email-t.figa@samsung.com>
 <CAH9JG2XFVzyZH8rsBogVYRdD4dzWpKjX8JAQw0Sf7qJqgueqAg@mail.gmail.com>
 <20120922062322.GA6264@quad.lixom.net>
Message-ID: <2370637.l5XxG4tm0Y@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Kyungmin,

On Friday 21 of September 2012 23:23:22 Olof Johansson wrote:
> On Sat, Sep 22, 2012 at 03:01:56PM +0900, Kyungmin Park wrote:
> > On 9/22/12, Olof Johansson <olof@lixom.net> wrote:
> > > On Thu, Sep 13, 2012 at 10:13:35AM +0200, Tomasz Figa wrote:
> > >> +#define call_firmware_op(op, ...)					\
> > >> +	((firmware_ops->op) ? firmware_ops->op(__VA_ARGS__) : 0)
> > > 
> > > I think this will cause sparse warnings for
> > > call_firmware_op(cpu_boot_reg) if there are no ops defined, since
> > > the '0' isn't annotated as __iomem. And you can't annotate it since
> > > the other function pointers don't need it.
> > > 
> > > I think you might be better off with stub functions as fallbacks
> > > instead of allowing and checking for NULL here.
> > 
> > do you mean like this?
> > 
> > #Ifdef CONFIG_ARM_FIRMWARE
> > #define call_firmware_op(op, ...) ((firmware_ops->op) ?
> > firmware_ops->op(__VA_ARGS__) : 0)
> > #else
> > #define call_firmware_op(op, ...) do { } while (0)
> > #endif
> > 
> > No problem to modify it.
> 
> To get the types and return values right you still need to do something
> like:
> 
> #define call_firmware_op(op, ...) (firmware_ops->op(__VA_ARGS))
> 
> And then, in firmware.c:
> 
> static int default_do_idle(void)
> {
> 	return 0;
> }
> 
> static default_cpu_boot(int cpu)
> {
> 	return;
> }
> 
> static void __iomem *default_cpu_boot_reg(int cpu)
> {
> 	return (void __iomem *)0;
> }
> 
> static const struct firmware_ops default_firmware_ops = {
> 	.do_idle = default_do_idle,
> 	.cpu_boot = default_cpu_boot,
> 	.cpu_boot_reg = default_cpu_boot_reg,
> }

Thanks for pointing this out. I will address it in next version of the 
series.

Also it might be useful to be able to check if an operation was provided, 
so maybe an unimplemented operation should return an error value (which one 
would be the most appropriate? -ENOSYS?)? What do you think?

Best regards,
Tomasz Figa
