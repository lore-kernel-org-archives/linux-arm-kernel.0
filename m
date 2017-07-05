From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 5 Jul 2017 08:55:59 +0200
Subject: [PATCH 0/8] mailbox: arm/arm64: introduce smc triggered mailbox
In-Reply-To: <7a58855c-7481-320e-19f0-83bd113ef2c0@arm.com>
References: <20170630095608.24943-1-andre.przywara@arm.com>
 <20170630122529.upjigip4hztrq67h@flea>
 <7a58855c-7481-320e-19f0-83bd113ef2c0@arm.com>
Message-ID: <20170705065559.6iehfacpiq74crz4@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 30, 2017 at 01:56:04PM +0100, Andre Przywara wrote:
> Hi,
> 
> thanks for having a look!
> 
> On 30/06/17 13:25, Maxime Ripard wrote:
> > Hi,
> > 
> > On Fri, Jun 30, 2017 at 10:56:00AM +0100, Andre Przywara wrote:
> >> The remaining patches demonstrate usage of this feature to drive SCPI services
> >> implemented as part of the ARM Trusted Firmware implementation used for
> >> AArch64 based Allwinner SoCs, the Allwinner A64 in this example.
> >> It allows to provide DVFS services, sensors support, device power domains
> >> and potentially other services like clocks or regulators.
> >> This allows to abstract those features in firmware, without the need to
> >> implement explicit Linux support for each variant of some SoC design.
> >> Those DT changes are not necessarily meant to be merged at this point.
> >> I started implementing the firmware side of those services and put a WIP
> >> branch on my ATF Github repo [1]. With this branch and these patches here
> >> you get DVFS and temperature sensor support for the A64, just with this
> >> driver and the generic SCPI support.
> > 
> > I would go even further, and say that these changes should be done by
> > the bootloader itself once it installed the proper monitor.
> > 
> > These patches represent not a state of the hardware itself, but the
> > state the bootloader let the hardware in, and that state will change
> > from one bootloader to the other, and one version to the other
> > (obviously). This is already what we do for the other things the
> > bootloader initializes (like simplefb, or PSCI). It just feels natural
> > to do the same thing here.
> 
> Yes, indeed that was my thinking as well. I just put those DT changes in
> here to demonstrate how it would look like.
> 
> Technically ATF (as the provider for the SCPI services) should do the DT
> change. That would also assure that those changes are always in sync
> with what's implemented. Mainline ATF seems to include libfdt now, but I
> haven't checked in detail how much this covers and how easy it is to
> use.

Even with just the libfdt's DT manipulation functions, this should be
quite easy. The steps needed would be:
  - Retrieve the phandle of the CCU node
  - Delete the CCU node (or mark it disabled, and remove its phandle
    property)
  - Add the SCPI nodes with the original's CCU phandle in your
    variable clocks subnode

The last part especially might be a bit painful, especially the
generation of the indices and names.

You also have the option of using an overlay and applying it if your
libfdt is recent enough. That way, you'll just need to care about
keeping the phandle in your code, but that's all.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170705/f3895528/attachment.sig>
