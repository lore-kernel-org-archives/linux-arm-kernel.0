From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 8 May 2012 14:34:12 +0100
Subject: [PATCH 14/15] drivers/regulators: Enable the ab8500 for Device
 Tree
In-Reply-To: <4FA913BA.30908@linaro.org>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <1336155805-18554-15-git-send-email-lee.jones@linaro.org>
 <20120507170832.GO17002@opensource.wolfsonmicro.com>
 <4FA90BE1.3050304@linaro.org>
 <20120508121940.GL15893@opensource.wolfsonmicro.com>
 <4FA913BA.30908@linaro.org>
Message-ID: <20120508133411.GP15893@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 08, 2012 at 01:38:18PM +0100, Lee Jones wrote:
> On 08/05/12 13:19, Mark Brown wrote:

> >It's been kicking around for review for a little while longer than that
> >(it was waiting for review while Rhyland was on holiday), and in any
> >case half the reason for adding infrastructure is to avoid adding
> >repeated code.

> I'm sorry Mark, but I just don't have the time to read all of the
> mailing lists in order to keep up with, and in-turn use all of the
> new features which might make it upstream. I only use what I see in
> the kernel at time of writing, as I have an entire platform to
> enable and very little time in which to do it.

If you're going to do this you really need to track -next rather than
-rc for actively developed subsystems - it's not just that you're not
using the latest APIs here you're submitting code that won't even
compile against the current subsystem.

> This piece of code plucks pre-defined initialisation values and from
> the Device Tree and uses them to set-up regulator related registers
> on the u8500. See 'struct ab8500_regulator_reg_init
> ab8500_regulator_reg_init' in
> arch/arm/mach-ux500/board-mop500-regulators.c for reference.

Oh, dear.  It's quite hard to associate this with the code especially
not without the binding document.  

Looking at the usage here it looks like most of this stuff shouldn't be
there even with non-DT stuff, we probably don't want to add DT bindings
for those bits.  All the voltage setting is not at all device specific
and can be done using the generic regulator bindings, the forcing on or
off is similarly generic.  There looks to be a large chunk of mode
setting too.  We probably need to scrub the existing magic number stuff
prior to trying to do this.

While looking for the original patch I also noticed that you're not CCing
the mailing list either...  please always CC the subsystem mailing list
on patches.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120508/db5f3efc/attachment.sig>
