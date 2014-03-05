From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 5 Mar 2014 10:24:14 +0100
Subject: [PATCHv3 3/4] of: provide a binding for fixed link PHYs
In-Reply-To: <CAGVrzcbHwxtgUfC4+u_3wszcmEYpz8Y7gu13xJy6TbT6fgR1sg@mail.gmail.com>
References: <1393930704-24374-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1393930704-24374-4-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAGVrzcbHwxtgUfC4+u_3wszcmEYpz8Y7gu13xJy6TbT6fgR1sg@mail.gmail.com>
Message-ID: <20140305102414.111f856e@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Florian Fainelli,

On Tue, 4 Mar 2014 12:58:41 -0800, Florian Fainelli wrote:


> What I like about this new binding is that we could place the
> 'fixed-link' related properties in e.g: a SPI slave node, and have the
> Ethernet MAC be pointed at it by a phandle to tell it: look this is
> your PHY, it might not be one you could address on a MDIO bus, so I
> have been providing additional properties to help you with the link
> configuration.
> 
> One thing that needs to be addressed in this patch is how to deal with
> the existing 5-digit fixed-link, something that sounds fairly easy and
> which would not require changing the callers of of_phy_connect_fixed()
> is to do the following:

I am not sure to understand "would not require changing the callers of
of_phy_connect_fixed()". This function is precisely introduced by the
patch set, so how would we need to "change the callers" ? Maybe you're
making a confusion with the existing of_phy_connect_fixed_link(), which
is used by network drivers to create a PHY using the old-style
fixed-link = <5 digits> binding ?

> - of_phy_is_fixed_link() needs to look for *all* required compatible
> properties of the new binding to give an accurate verdict on the
> nature of the PHY (to avoid false positives as mentioned in PATCH 4),

Hum?

The false positive problem only exists if you want to automatically
instantiate the fixed PHYs, as I proposed in a patch as a reply to my
series. And checking for *all* required properties does not make the
problem better: you could very well have other nodes in the tree that
have a "fixed-link" and a "speed" property, for example.

> and it also needs to look for the 5-digit fixed-link property and
> ensure the property is 5-digits long if existing

I don't understand how this could work. The of_phy_is_fixed_link()
function is meant to take as argument a Device Tree node that describes
a fixed PHY, using the new proposed DT binding for fixed PHYs.

The old 'fixed-link' binding has the fixed-link property as part of the
Ethernet node itself.

So I don't really see how a sane function could check both.

> - of_phy_register_fixed_link() needs to also parse the old 5-digit
> fixed-link property, most likely just copy-pasting what
> arch/powerpc/sysdev/fsl_soc.c::of_add_fixed_phys does with the
> property endian-swapping (as this code is for PowerPC)
> 
> Then we can deal with how to make that semi-automatic for the new
> binding users to make it smoother to use a regular or "fixed PHY"
> device.

I still don't understand. With the old binding, the "fixed-link"
property is within some random Ethernet node, and there is no way for
us to find out whether a given node having a "fixed-link" property
corresponds to a fixed PHY, or something completely unrelated.

So to conclude, I'm sorry, but I didn't understand at all what you
meant to say here, so I'm completely puzzled about what your
suggestions are.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
