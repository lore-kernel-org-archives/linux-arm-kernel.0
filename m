From: tony@atomide.com (Tony Lindgren)
Date: Wed, 11 Dec 2013 08:43:03 -0800
Subject: [PATCH] of/platform: Fix no irq domain found errors when
 populating interrupts
In-Reply-To: <20131211151159.GA31617@ulmo.nvidia.com>
References: <20131123004334.GJ10023@atomide.com>
 <20131124213651.59750C402C3@trevor.secretlab.ca>
 <20131125092549.GD22043@ulmo.nvidia.com>
 <20131125094954.GF22043@ulmo.nvidia.com>
 <20131127155629.DB612C404EC@trevor.secretlab.ca>
 <20131128154622.GB23201@ulmo.nvidia.com>
 <20131211134553.2E967C4061A@trevor.secretlab.ca>
 <20131211151159.GA31617@ulmo.nvidia.com>
Message-ID: <20131211164302.GB13171@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Thierry Reding <thierry.reding@gmail.com> [131211 07:14]:
> 
> So how about we make the platform_get_irq() modification for starters,
> so that the OMAP issues can be resolved and then turn our attention to
> coming up with a more generic approach. If indeed we end up with what
> you're proposing we can easily switch platform_get_irq() to use it.

Yeah we should do the minimal fix for the $Subject bug for the -rc cycle
so I can fix the PM test regression fix for the few omap3 platforms
already made DT only.
 
> One of the things I'm not so sure about is how to handle other types of
> resources, since they'll be somewhat more specific to the type of
> device. That's true also for devices other than platform devices. Let's
> look at I2C devices for instance. The way to get at the IRQ number is
> via the i2c_client->irq member.

Yes. And BTW, there's also another related glitch where there's no easy
way to configure auxdata from arch/arm/mach code for some devices.

For example, consider something like this that's fairly common:

1. i2c bus driver configured with DT and can take board specific auxdata

2. i2c bus intializes connected devices as configured with DT but
   cannot pass board specific auxdata as the auxdata for the i2c bus
   is empty

3. i2c connected pmic driver intializes as configured with DT, but
   cannot get board specifc auxdata

So we should probably add some parent or master auxdata table that's
also checked if the bus specific auxdata table is empty.
 
> device_get_irq() breaks down at that point because unless you want to
> add special cases for all sorts of devices you have no way of getting at
> the data if it hasn't been instantiated from DT (or ACPI). Actually, all
> devices instantiated from platform data will suffer from this if I'm not
> mistaken.
> 
> If you're saying that the device_get_irq() API should only cover cases
> where some sort of firmware interface exists such as DT or ACPI, then I
> suppose it could be made to work and drivers could rely on the subsystem
> specific locations as fallback. I guess for I2C drivers you'd have to do
> something like this:
> 
> 	err = device_get_irq(&client->dev, 0);
> 	if (err >= 0)
> 		client->irq = err;
> 
> And then continue to use client->irq as usual. That obviously has the
> side-effect of having to do this for every single driver, whereas the
> original patches were meant to solve this in the core.
> 
> Given enough time we could probably migrate everyone to the new
> interfaces, but it certainly is a lot of churn. Perhaps another
> alternative would be to unify this some more by making each subsystem
> provide special hooks that device_get_irq() and friends can call for
> fallback when none of the "firmware" functions were successful.

Ideally of course we'd have Linux generic way of doing this that works
for platform data, DT and ACPI without changing the existing interfaces :)

Regards,

Tony
