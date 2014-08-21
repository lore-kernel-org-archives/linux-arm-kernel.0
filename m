From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 21 Aug 2014 08:58:54 +0200
Subject: [PATCH v2 1/5] of: Add descriptions of thermtrip properties to
 Tegra PMC bindings
In-Reply-To: <53F50231.5010605@wwwdotorg.org>
References: <1407933685-12404-1-git-send-email-mperttunen@nvidia.com>
 <1407933685-12404-2-git-send-email-mperttunen@nvidia.com>
 <53F50231.5010605@wwwdotorg.org>
Message-ID: <20140821065853.GE4486@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 20, 2014 at 02:16:49PM -0600, Stephen Warren wrote:
> On 08/13/2014 06:41 AM, Mikko Perttunen wrote:
> >Hardware-triggered thermal reset requires configuring the I2C
> >reset procedure. This configuration is read from the device tree,
> >so document the relevant properties in the binding documentation.
> 
> >diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
> 
> >+Hardware-triggered thermal reset:
> >+On Tegra30, Tegra114 and Tegra124, if the 'i2c-thermtrip' subnode exists,
> >+hardware-triggered thermal reset will be enabled.
> 
> "will be enabled" sounds like SW behaviour, whereas DT is suppose to
> describe HW, and leave SW to define its own behaviour. I would suggest:
> 
> Optional sub-nodes:
> i2c-thermtrip: Describes how to power off the system in the event of a
>   thermal emergency.
> 
> >+Required properties for hardware-triggered thermal reset (inside 'i2c-thermtrip'):
> 
> Simpler might be:
> 
> Required properties for i2c-thermtrip node:
> 
> >+- nvidia,pmu : Phandle to power management unit / PMIC handling poweroff
> >+- nvidia,reg-addr : I2C register address to write poweroff command to
> >+- nvidia,reg-data : Poweroff command to write to PMU
> 
> Why are both the PMU/PMIC phandle and the register address/data required? I
> thought the purpose of having the phandle was to allow the register address
> and data to be queried from the PMU/PMIC driver.
> 
> To me, it seems much simpler to get rid of the phandle and just hard-code
> the I2C bus number, address, and data into this node, rather than having to
> go query it from the PMU/PMIC driver, then find the I2C controller, then
> query it for its ID (and hope that all HW modules that talk to I2C
> controllers directly use the same numbering scheme...)

I originally requested this to be changed. It seems wrong to duplicate
information about the PMIC in both the PMIC device tree node and the
i2c-thermtrip node if we can get the same information from the driver
directly (via the phandle). It certainly requires a little more code,
but at the advantage of not having to figure out the I2C controller
hardware number and I2C slave addresses when writing the i2c-thermtrip
node.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140821/173ffb99/attachment.sig>
