From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 13 May 2014 16:30:26 +0200
Subject: [PATCHv2 1/4] of: make of_update_property() usable earlier in
 the boot process
In-Reply-To: <CAL_JsqLNnLjeo2tM=z5bcn4DJD_5-uFRGkk6wAWnvGZyo9Y7pg@mail.gmail.com>
References: <1399975839-5311-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1399975839-5311-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAL_JsqLNnLjeo2tM=z5bcn4DJD_5-uFRGkk6wAWnvGZyo9Y7pg@mail.gmail.com>
Message-ID: <20140513163026.18a0fa61@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Rob Herring,

On Tue, 13 May 2014 09:00:02 -0500, Rob Herring wrote:

> > However, it forgot to do the same for of_update_property(), which if
> > used early in the boot process (before core_initcalls have been
> > called), tries to call sysfs_remove_bin_file(), and crashes:
> 
> It actually crashes or just the warning? It would be good to give the
> crash backtrace.

It crashes after the warning. The crash trace is:

Unable to handle kernel NULL pointer dereference at virtual address 0000003c
pgd = c0004000
[0000003c] *pgd=00000000
Internal error: Oops: 5 [#1] SMP ARM
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W     3.15.0-rc1-00127-g1d7e7b2-dirty #423
task: c10ad4d8 ti: c10a2000 task.ti: c10a2000
PC is at kernfs_find_ns+0x8/0xf0
LR is at kernfs_find_and_get_ns+0x30/0x48
pc : [<c0103834>]    lr : [<c010394c>]    psr: 600001d3
sp : c10a3f34  ip : 00000073  fp : 00000000
r10: 00000000  r9 : cfffc240  r8 : cfdf2980
r7 : cf812c00  r6 : 00000000  r5 : 00000000  r4 : c10b45e0
r3 : c10ad4d8  r2 : 00000000  r1 : cf812c00  r0 : 00000000
Flags: nZCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c53c7d  Table: 0000404a  DAC: 00000015
Process swapper/0 (pid: 0, stack limit = 0xc10a2240)
Stack: (0xc10a3f34 to 0xc10a4000)
3f20:                                              c10b45e0 00000000 00000000
3f40: cf812c00 c010394c 00000063 cf812c00 00000001 cf812c00 cfdf29ac c03932cc
3f60: 00000063 cf812bc0 cfdf29ac cf812c00 ffffffff c03943f8 cfdf2980 c0104468
3f80: cfdf2a04 cfdf2980 cf812bc0 c06634b0 c10aa3c0 c0394da4 c10f74dc cfdf2980
3fa0: cf812bc0 c0647248 c10aa3c0 ffffffff c10de940 c10aa3c0 ffffffff c0640934
3fc0: ffffffff ffffffff c06404ec 00000000 00000000 c06634b0 00000000 10c53c7d
3fe0: c10aa434 c06634ac c10ae4c8 0000406a 414fc091 00008070 00000000 00000000
[<c0103834>] (kernfs_find_ns) from [<00000001>] (0x1)
Code: e5c89001 eaffffcf e92d40f0 e1a06002 (e1d023bc) 
---[ end trace 3406ff24bd97382f ]---
Kernel panic - not syncing: Attempted to kill the idle task!
---[ end Kernel panic - not syncing: Attempted to kill the idle task!

> > To fix this problem, we simply skip the sysfs related calls in
> > of_update_property(), and rely on of_init() to fix up things when it
> > will be called, exactly as is done in of_add_property() and
> > of_remove_property().
> >
> > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > Fixes: 75b57ecf9d1d1e17d099ab13b8f48e6e038676be ('of: Make device nodes kobjects so they show up in sysfs')
> 
> Humm, I didn't know about this new tag. This doesn't quite match what
> SubmittingPatches says. It should be 12 digits of commit hash and
> double quotes around the summary.

Well, I guess it's a per-maintainer choice:

git log | grep "^Fixes:"

    Fixes: 54fe26a900bc528f3df1e4235cb6b9ca5c6d4dc2 ('ARM: mvebu: Add thermal quirk for the Armada 375 DB board')
    Fixes: 54397d85349f ("ARM: kirkwood: Relocate PCIe device tree nodes")
    Fixes: a7d4f81821f7 ('ARM: mvebu: Add support for NOR flash device on Openblocks AX3 board')
    Fixes: b484ff42df47 ('ARM: mvebu: Add support for NOR flash device on Armada XP-DB board')
    Fixes: c971ff185f64 ("leds: leds-pwm: Defer led_pwm_set() if PWM can sleep")
    Fixes: abccd00f8af2 ('btrfs: Fix 32/64-bit problem with BTRFS_SET_RECEIVED_SUBVOL ioctl')
    Fixes: ee1e0994ab1bd (regulator: s5m8767: Use GPIO for controlling Buck9/eMMC)
    Fixes: 652ed95d5fa6 (cpufreq: introduce cpufreq_generic_get() routine)

Somewhat inconsistent :-)

But ok, 12 digits for the commit hash, and double quotes.

> >  drivers/of/base.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/of/base.c b/drivers/of/base.c
> > index f72d19b..e981f09 100644
> > --- a/drivers/of/base.c
> > +++ b/drivers/of/base.c
> > @@ -1831,11 +1831,16 @@ int of_update_property(struct device_node *np, struct property *newprop)
> >         if (rc)
> >                 return rc;
> >
> > +       /* At early boot, bail out and defer setup to of_init() */
> > +       if (!of_kset)
> > +               goto skip_sysfs;
> 
> I prefer to avoid the goto and do: return found ? 0 : -ENODEV;

Ok.

> Also, this code has changed some in 3.15 rc's, you need to rebase.
> This change needs to go into 3.15. Other platforms could be broken.

Ok, will submit a v2 separately.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
