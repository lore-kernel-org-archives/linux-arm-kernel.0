From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 17 Nov 2014 09:56:40 +0100
Subject: [RFC PATCHv2] ARM: mvebu: Let the device-tree determine smp_ops
In-Reply-To: <1415327626-16079-1-git-send-email-chris.packham@alliedtelesis.co.nz>
References: <20141106201603.GF4974@lunn.ch>
 <1415327626-16079-1-git-send-email-chris.packham@alliedtelesis.co.nz>
Message-ID: <20141117095640.03e25d17@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Chris Packham,

On Fri,  7 Nov 2014 15:33:46 +1300, Chris Packham wrote:
> The machine specific SMP operations can be configured either via
> setup_arch or via arm_dt_init_cpu_maps. For the ARMADA_370_XP_DT devices
> both of these are called and setup_arch wins because it is called last.
> This means that it is not possible to substitute a different set of SMP
> operations via the device-tree.
> 
> For the ARMADA_370_XP_DT compatible devices add a smp_init function that
> detects if the device tree has an enable-method defined. If it does
> return true to indicate that the smp_ops have already been set which
> will prevent setup_arch from overriding them.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

My colleague Maxime Ripard (in Cc) rightfully suggests exploring a
different option: what about getting rid completely of the .smp field
of the DT_MACHINE structure, and instead have some code run early
enough that looks if an enable-method is defined, and if not, defines
it to the default value. This way, we continue to be backward
compatible in terms of DT, but we always use the enable-method from the
DT, and not sometimes from DT, sometimes from the DT_MACHINE structure.

Unfortunately, it will have to be done on the flattened DT, because the
DT is unflattened right before the enable-method properties are looked
up:

        unflatten_device_tree();

        arm_dt_init_cpu_maps();

And manipulating the DT in its flattened format, while possible in
->dt_fixup(), is a pain, and probably doesn't allow adding new
properties anyway.

So, in the end, maybe this idea doesn't work, I haven't checked
completely.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
