From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 11 Jan 2018 13:40:35 -0800
Subject: [linux, dev-4.10, 6/6] drivers/hwmon: Add a driver for a generic
 PECI hwmon
In-Reply-To: <261ac28e-813c-a058-c81f-ad4e718d0233@linux.intel.com>
References: <20180109223126.13093-7-jae.hyun.yoo@linux.intel.com>
 <20180110214747.GA25248@roeck-us.net>
 <261ac28e-813c-a058-c81f-ad4e718d0233@linux.intel.com>
Message-ID: <20180111214035.GA14748@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 11, 2018 at 11:47:01AM -0800, Jae Hyun Yoo wrote:
> On 1/10/2018 1:47 PM, Guenter Roeck wrote:
> >On Tue, Jan 09, 2018 at 02:31:26PM -0800, Jae Hyun Yoo wrote:
> >>This commit adds driver implementation for a generic PECI hwmon.
> >>
> >>Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

[ ... ]

> >>+
> >>+	if (priv->temp.tcontrol.valid &&
> >>+	    time_before(jiffies, priv->temp.tcontrol.last_updated +
> >>+				 UPDATE_INTERVAL_MIN))
> >>+		return 0;
> >>+
> >
> >Is the delay necessary ? Otherwise I would suggest to drop it.
> >It adds a lot of complexity to the driver. Also, if the user polls
> >values more often, that is presumably on purpose.
> >
> 
> I was intended to reduce traffic on PECI bus because it's low speed single
> wired bus, and temperature values don't change frequently because the value
> is sampled and averaged in CPU itself. I'll keep this.
> 
Then please try to move the common code into a single function.

[ ... ]

> >>+
> >>+	rc = of_property_read_u32(np, "cpu-id", &priv->cpu_id);
> >
> >What entity determines cpu-id ?
> >
> 
> CPU ID numbering is determined by hardware SOCKET_ID strap pins. In this
> driver implementation, cpu-id is being used as CPU client indexing.
> 
Seems to me the necessary information to identify a given CPU should
be provided by the PECI core. Also, there are already "cpu" nodes
in devicetree which, if I recall correctly, may include information
such as CPU Ids.

> >>+	if (rc || priv->cpu_id >= CPU_ID_MAX) {
> >>+		dev_err(dev, "Invalid cpu-id configuration\n");
> >>+		return rc;
> >>+	}
> >>+
> >>+	rc = of_property_read_u32(np, "dimm-nums", &priv->dimm_nums);
> >
> >This is an odd devicetree attribute. Normally the number of DIMMs
> >is dynamic. Isn't there a means to get all that information dynamically
> >instead of having to set it through devicetree ? What if someone adds
> >or removes a DIMM ? Who updates the devicetree ?
> >
> 
> It means the number of DIMM slots each CPU has, doesn't mean the number of
> currently installed DIMM components. If a DIMM is inserted a slot, CPU
> reports its actual temperature but on empty slot, CPU reports 0 instead of
> reporting an error so it is the reason why this driver enumerates all DIMM
> slots' attribute.
> 
And there is no other means to get the number of DIMM slots per CPU ?
It just seems to be that this is the wrong location to provide such
information.

[ ... ]

> >>+
> >>+static const struct of_device_id peci_of_table[] = {
> >>+	{ .compatible = "peci-hwmon", },
> >
> >This does not look like a reference to some piece of hardware.
> >
> 
> This driver provides generic PECI hwmon function to which controller has
> PECI HW such as Aspeed or Nuvoton BMC chip so it's not dependant on a
> specific hardware. Should I remove this or any suggestion?
> 

I don't really know enough about the system to make a recommendation.
It seems to me that the PECI core should identify which functionality
it supports and instantiate the necessary driver(s). Maybe there should
be sub-nodes to the peci node with relevant information. Those sub-nodes
should specify the supported functionality in more detail, though -
such as indicating the supported CPU and/or DIMM sensors.

Guenter
