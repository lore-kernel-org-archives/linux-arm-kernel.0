From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 10 Jul 2014 17:09:45 +0200
Subject: a case for a common efuse API?
In-Reply-To: <53BEB443.9000606@ti.com>
References: <53BC4DD7.20906@codeaurora.org> <20140709083509.GQ13423@lukather>
 <53BDD0F3.7040906@codeaurora.org> <20140710142616.GD27469@lukather>
 <53BEB443.9000606@ti.com>
Message-ID: <20140710150945.GF27469@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 10, 2014 at 06:41:55PM +0300, Grygorii Strashko wrote:
> On 07/10/2014 05:26 PM, Maxime Ripard wrote:
> >On Wed, Jul 09, 2014 at 04:32:03PM -0700, Stephen Boyd wrote:
> >>On 07/09/14 01:35, Maxime Ripard wrote:
> >>>Hi Stephen,
> >>>
> >>>On Tue, Jul 08, 2014 at 01:00:23PM -0700, Stephen Boyd wrote:
> >>>>Hi,
> >>>>
> >>>>On MSM chips we have some efuses (called qfprom) where we store things
> >>>>like calibration data, speed bins, etc. We need to read out data from
> >>>>the efuses in various drivers like the cpufreq, thermal, etc. This
> >>>>essentially boils down to a bunch of readls on the efuse from a handful
> >>>>of different drivers. In devicetree this looks a little odd because
> >>>>these drivers end up having an extra reg property (or two) that points
> >>>>to a register in the efuse and some length, i.e you see this:
> >>>>
> >>>>	thermal-sensor at 34000 {
> >>>>		compatible = "sensor";
> >>>>		reg = <0x34000 0x1000>, <0x10018 0xc>;
> >>>>		reg-names = "sensor", "efuse_calib";
> >>>>	}
> >>>>
> >>>>
> >>>>I imagine in DT we want something more like this:
> >>>>
> >>>>	efuse: efuse at 10000 {
> >>>>		compatible = "efuse";
> >>>>		reg = <0x10000 0x1000>;
> >>>>	}
> >>>>
> >>>>	thermal-sensor at 34000 {
> >>>>		compatible = "sensor";
> >>>>		reg = <0x34000 0x1000>;
> >>>>		efuse = <&efuse 0x18>;
> >>>>	}
> 
> Why don't use "syscon" framework for your needs? (mfd/syscon.c)

Because syscon is restricted to MMIO, and not really meant to be used
for this.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140710/4d5a6c38/attachment.sig>
