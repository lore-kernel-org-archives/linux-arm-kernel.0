From: Chris.Packham@alliedtelesis.co.nz (Chris Packham)
Date: Mon, 17 Nov 2014 20:46:28 +0000
Subject: [RFC PATCHv2] ARM: mvebu: Let the device-tree determine smp_ops
In-Reply-To: <20141117095640.03e25d17@free-electrons.com>
References: <20141106201603.GF4974@lunn.ch>
 <1415327626-16079-1-git-send-email-chris.packham@alliedtelesis.co.nz>
 <20141117095640.03e25d17@free-electrons.com>
Message-ID: <546A5E9F.6080309@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 11/17/2014 09:56 PM, Thomas Petazzoni wrote:
> Dear Chris Packham,
>
> On Fri,  7 Nov 2014 15:33:46 +1300, Chris Packham wrote:
>> The machine specific SMP operations can be configured either via
>> setup_arch or via arm_dt_init_cpu_maps. For the ARMADA_370_XP_DT devices
>> both of these are called and setup_arch wins because it is called last.
>> This means that it is not possible to substitute a different set of SMP
>> operations via the device-tree.
>>
>> For the ARMADA_370_XP_DT compatible devices add a smp_init function that
>> detects if the device tree has an enable-method defined. If it does
>> return true to indicate that the smp_ops have already been set which
>> will prevent setup_arch from overriding them.
>>
>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>
> My colleague Maxime Ripard (in Cc) rightfully suggests exploring a
> different option: what about getting rid completely of the .smp field
> of the DT_MACHINE structure, and instead have some code run early
> enough that looks if an enable-method is defined, and if not, defines
> it to the default value. This way, we continue to be backward
> compatible in terms of DT, but we always use the enable-method from the
> DT, and not sometimes from DT, sometimes from the DT_MACHINE structure.
>
> Unfortunately, it will have to be done on the flattened DT, because the
> DT is unflattened right before the enable-method properties are looked
> up:
>
>          unflatten_device_tree();
>
>          arm_dt_init_cpu_maps();

That probably wouldn't be too hard because set_smp_ops_by_method() tells 
us if it's actually set something. We'd just need to propagate that up a 
few levels. We could either propagate this result through to setup_arch 
or move the smp_set_ops() call from setup_arch to something that gets 
invoked based on the return from set_smp_ops_by_method() or 
arm_dt_init_cpu_maps().

I'm a little hesitant because this is core code and I don't have access 
to a large set of devices to test (plus the whole newbie thing). But I 
could give it a go and see how far I get.

> And manipulating the DT in its flattened format, while possible in
> ->dt_fixup(), is a pain, and probably doesn't allow adding new
> properties anyway.
>
> So, in the end, maybe this idea doesn't work, I haven't checked
> completely.
>
> Best regards,
>
> Thomas
>
