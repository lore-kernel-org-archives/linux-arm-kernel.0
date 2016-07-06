From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Tue, 05 Jul 2016 23:16:33 -0700
Subject: [PATCH 02/21] usb: ulpi: Support device discovery via DT
In-Reply-To: <20160701005817.GA31363@rob-hp-laptop>
References: <20160626072838.28082-1-stephen.boyd@linaro.org>
 <20160626072838.28082-3-stephen.boyd@linaro.org>
 <20160628205642.GP3737@rob-hp-laptop>
 <146715176149.31418.10938517376423447782@sboyd-linaro>
 <20160701005817.GA31363@rob-hp-laptop>
Message-ID: <146778579383.12931.7862254251015294434@sboyd-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Rob Herring (2016-06-30 17:59:15)
> On Tue, Jun 28, 2016 at 03:09:21PM -0700, Stephen Boyd wrote:
> > Quoting Rob Herring (2016-06-28 13:56:42)
> > > On Sun, Jun 26, 2016 at 12:28:19AM -0700, Stephen Boyd wrote:
> > > > The qcom HSIC ulpi phy doesn't have any bits set in the vendor or
> > > > product id ulpi registers. This makes it impossible to make a
> > > > ulpi driver match against the id registers. Add support to
> > > > discover the ulpi phys via DT to help alleviate this problem.
> > > > We'll look for a ulpi bus node underneath the device registering
> > > > the ulpi viewport (or the parent of that device to support
> > > > chipidea's device layout) and then match up the phy node
> > > > underneath that with the ulpi device that's created.
> > > > 
> > > > The side benefit of this is that we can use standard DT
> > > > properties in the phy node like clks, regulators, gpios, etc.
> > > > because we don't have firmware like ACPI to turn these things on
> > > > for us. And we can use the DT phy binding to point our phy
> > > > consumer to the phy provider.
> > > > 
> > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > > Cc: <devicetree@vger.kernel.org>
> > > > Cc: Rob Herring <robh+dt@kernel.org>
> > > > Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> > > > ---
> > > >  Documentation/devicetree/bindings/usb/ulpi.txt | 20 +++++++++
> > > >  drivers/usb/common/ulpi.c                      | 56 +++++++++++++++++++++++++-
> > > >  2 files changed, 74 insertions(+), 2 deletions(-)
> > > >  create mode 100644 Documentation/devicetree/bindings/usb/ulpi.txt
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/usb/ulpi.txt b/Documentation/devicetree/bindings/usb/ulpi.txt
> > > > new file mode 100644
> > > > index 000000000000..ca179dc4bd50
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/usb/ulpi.txt
> > > > @@ -0,0 +1,20 @@
> > > > +ULPI bus binding
> > > > +----------------
> > > > +
> > > > +Phys that are behind a ULPI connection can be described with the following
> > > > +binding. The host controller shall have a "ulpi" named node as a child, and
> > > > +that node shall have one enabled node underneath it representing the ulpi
> > > > +device on the bus.
> > > 
> > > This needs to co-exist with the USB bus binding which has the controller 
> > > ports for the child nodes. Maybe use the phy binding?
> > 
> > Which binding is that? bindings/usb/usb-device.txt? 
> 
> Yes.
> 
> > This ulpi binding is
> > to describe phys that are accessed through the ulpi "viewport" in the
> > usb controller. So controller ports don't come into the picture here.
> 
> You just need to confirm that there's no collision with child nodes like 
> it assumes all children are ports.
> 

Ok. It will work with the way usb_of_get_child_node() is written but it
doesn't seem like great DT design if we want to support usb-device
binding and ulpi bus at the same time, because we treat the controller
node as the usb bus.

&usb1 { 
        status = "okay";

        #address-cells = <1>;
        #size-cells = <0>;
	phys = <&uphy>;
	phy-names = "usb-phy";

        hub: genesys at 1 {
                compatible = "usb5e3,608";
                reg = <1>;
        };

	ulpi {
		uphy: phy {
			compatible = "phy";
		};
	};
}

In this example, the ulpi bus doesn't have a reg property because it
isn't a port.

Perhaps we can move the usb ports to a subnode like 'usb' so that we can
have two logical busses underneath the controller, one for usb and one
for ulpi? We would need backwards compatibility code that looks for a
ports directly underneath the usb controller node when #address-cells
and #size-cells are present, otherwise it should fall down into a
'usb' subnode.
