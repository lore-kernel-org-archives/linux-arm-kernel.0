From: sre@kernel.org (Sebastian Reichel)
Date: Sun, 25 Jan 2015 16:04:31 +0100
Subject: [PATCH RFC 2/3] power: mxs_power: add driver for mxs power
 subsystem
In-Reply-To: <54C0AFE4.3020701@i2se.com>
References: <1416514477-19190-1-git-send-email-stefan.wahren@i2se.com>
 <1416514477-19190-3-git-send-email-stefan.wahren@i2se.com>
 <20150121230148.GJ13715@earth.universe> <54C0AFE4.3020701@i2se.com>
Message-ID: <20150125150431.GE2719@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[add maintainers from regulator framework]

On Thu, Jan 22, 2015 at 09:08:04AM +0100, Stefan Wahren wrote:
> Am 22.01.2015 um 00:01 schrieb Sebastian Reichel:
> > On Thu, Nov 20, 2014 at 08:14:36PM +0000, Stefan Wahren wrote:
> >> This patch adds a minimal driver for the Freescale i.MX23, i.MX28
> >> power subsystem. It's required to trigger the probing of the underlying
> >> drivers like on-chip regulators. Additionally the drivers supports
> >> the configuration of the DC-DC clock frequency to avoid possible
> >> interferences.
> > I would expect PLL to be board specific and part of DT. Why is it
> > specified as parameter?
> 
> I think the switching frequency of the DC-DC belongs to the
> configuration and don't describe how the hardware is connected. But i
> don't have a problem to change it into a DT property.
> 
> Does a common property name exists for the switching frequency or would
> it be vendor specific?

As far as I know most regulators have fixed switching frequencies,
so there is no common property name so far. I added regulator
framework people, since this property should be regulator specific.

Apart from introducing a custom/common switching-frequency property
the dts could also expose the PLL like this and use the common
clock-frequency property:

power: power at 80044000 {
    compatible = "fsl,imx28-power";
    #address-cells = <1>;
    #size-cells = <1>;
    reg = <0x80044000 0x2000>;
    interrupts = <6>;
    ranges;

    powerpll {
        compatible = "fsl,imx28-power-pll"
        #clock-cells = <0>;
        clock-frequency = <12345>;
    }
}

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150125/5af2c464/attachment.sig>
