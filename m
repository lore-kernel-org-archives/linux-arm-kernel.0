From: computersforpeace@gmail.com (Brian Norris)
Date: Fri, 20 Oct 2017 10:27:01 -0700
Subject: [PATCH 2/9] PCI: host: brcmstb: add DT docs for Brcmstb PCIe
 device
In-Reply-To: <9fae640f-a9da-90bf-01d2-c62131611ef9@gmail.com>
References: <1507761269-7017-1-git-send-email-jim2101024@gmail.com>
 <1507761269-7017-3-git-send-email-jim2101024@gmail.com>
 <20171017202418.ykve2o4zvuwxjdgj@rob-hp-laptop>
 <CANCKTBt_gUF8qAEuhS1336Uce+WdP_98ApZhv1sxZgJsWGoiGQ@mail.gmail.com>
 <CAL_JsqLoqB0GF201ofJrjdYH8B-Ca=hGBtE4=VcrBxS7M52mVQ@mail.gmail.com>
 <9fae640f-a9da-90bf-01d2-c62131611ef9@gmail.com>
Message-ID: <20171020172701.GA105780@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Oct 19, 2017 at 02:58:55PM -0700, Florian Fainelli wrote:
> On 10/19/2017 02:49 PM, Rob Herring wrote:
> > On Tue, Oct 17, 2017 at 5:42 PM, Jim Quinlan <jim2101024@gmail.com> wrote:
> >> On Tue, Oct 17, 2017 at 4:24 PM, Rob Herring <robh@kernel.org> wrote:
> >>> This is not the regulator binding. Use the standard binding.
> >>>
> >> The reason we do it this way is because the PCIe controller does not
> >> know or care what the names of the supplies are, or how many there
> >> will be.  The list of regulators can be different for each board we
> >> support, as these regulators turn on/off the downstream EP device.
> >> All the PCIe controller does is turn on/off this list of regulators
> >> when booting,resuming/suspending.
> >>
> >> An alternative would have the node specifying the standard properties
> >>
> >> xyz-supply = <&xyz_reg>;
> >> abc-supply = <&abc_reg>;
> >> pdq-supply = <&pdq_reg>;
> >> ...
> >>
> >> and then have this driver search all of the properties in the PCIe
> >> node for names matching /-supply$/, and then create a list of phandles
> >> from that.  Is that what you would like?
> > 
> > Really, you should have child nodes of the PCIe devices and have the
> > supplies in there.
> 
> While that would be technically more correct this poses a number of issues:
> 
> - there is precedence in that area, and you already Acked binding
> documents proposing the same thing:
> 	* Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt (commit
> c26ebe98a103479dae9284fe0a86a95af4a5cd46)
> 	* Documentation/devicetree/bindings/pci/rockchip-pcie.txt (commit
> 828bdcfbdb98eeb97facb05fe6c96ba0aed65c4a and before)

I can actually speak to the Rockchip binding a bit :)

It actually has a mixture of true controller regulators (e.g., the 1.8V
and 0.9V regulators power analog portions of the SoC's PCIe logic) and
controls for the PCIe endpoints (e.g., 12V). Additionally, some of these
have been misused to represent a little of both, since the regulator
framework is actually quite flexible ;)

That may or may not help, but they are at least partially correct.

The Freescale one does look like it's plainly *not* about the root
controller.

Also, those rails *are* all fairly well defined by the various PCIe
electromechanical specifications, so isn't it reasonable to expect that
a controller can optionally control power for 1 of each of the standard
power types? Or do we really want to represent the flexibility that
there can be up to N of each type for N endpoints?

As a side note: it's also been pretty tough to get the power sequencing
requirements represented correctly for some PCIe endpoints. I've tried
to make use of this previously, but the series took so long (>1 year and
counting!) my team lost interest:

[PATCH v16 2/7] power: add power sequence library
https://www.spinics.net/lists/linux-usb/msg158452.html

It doesn't really solve all of this problem, but it could be worth
looking at.

> (which may indicate those should also be corrected, at the possible
> expense of creating incompatibilities)

If a better way is developed, we can always augment the bindings. The
current bindings aren't that hard to maintain as "deprecated backups."

> - there is a chicken and egg problem, you can't detect the EP without
> turning its regulator on, and if you can't create a pci_device, you
> certainly won't be able to associate it with an device_node counterpart

That's definitely a major problem driving some of the current bindings.
We're just not set up to walk the child devices if we can't probe them.

> - PCIe being dynamic by nature, can you have "wildcard" PCIE EP DT node
> that would be guaranteed to match any physically attached PCIE EP which
> is discovered by the PCI bus layer (and then back to issue #2)

Technically, you *can* walk the DT (i.e., 'device_node's) without having
pci_dev's for each yet. Something like of_pci_find_child_device() would
do it. But that still seems kind of wonky, and it's currently neither
precise enough nor flexible enough for this, I don't think.

Brian

> If we can solve #2 and #3, it would be reasonable to move the regulator
> to a PCIE EP node. Ideally, we may want the generic PCI layer to be
> responsible for managing regulators within pci_enable_device() and
> pci_disable_device() for instance?
> 
> > 
> > The driver could do what you describe, but you've still got to define
> > the names here.
> > 
> > Rob
> > 
> 
> 
> -- 
> Florian
