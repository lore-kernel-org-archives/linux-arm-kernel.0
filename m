From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 04 Apr 2015 14:58:23 +0200
Subject: [PATCH] sunxi: a10-lime: add regulator nodes
In-Reply-To: <20150404123302.GY6023@sirena.org.uk>
References: <551537ED.7060402@gmail.com> <551538AB.50207@redhat.com>
 <55169622.5070007@gmail.com> <20150330222311.GY23664@lukather>
 <CABxcv=nCROiQ2COrTmnwvhtSJzh83BWKaxgn0EkFuwW8HqSiQw@mail.gmail.com>
 <20150404123302.GY6023@sirena.org.uk>
Message-ID: <551FDFEF.6010207@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 04-04-15 14:33, Mark Brown wrote:
> On Sat, Apr 04, 2015 at 02:18:12PM +0200, Javier Martinez Canillas wrote:
>> On Tue, Mar 31, 2015 at 12:23 AM, Maxime Ripard
>
>>> No, it's defining which regulators are provided by the regulator, and
>>> the voltage boundaries they have. It doesn't make any assumption with
>>> regards to what is connected to what, and if a particular regulator is
>>> connected to something. That's something that the board DTS should
>>> describe as accurately as possible.
>
> This is broken - think about what this means.  If you are defining a
> voltage (or any other constraint) you're saying that it's safe to use on
> a given board.  If you provide a voltage constraint saying that the
> maximum allowable range for a voltage regulator is safe.  That's
> unlikely to be true on any given board, usually only a limited set of
> regulators can vary voltages at runtime safely at all and then rarely
> over their full supported range.  Similarly for other constraints, for
> example allowing a regulator to be disabled when there are driverless
> things (or drivers without regulator support or mappings for that board)
> relying on it is going to break.

Right, this is why in later revisions the pmic dtsi file does not
contain any ranges, these must now all be set by the dts file.

> Providing a list of the regulators is safe but not really doing a huge
> amount.

This (providing a list) is pretty much all the dtsi does, this is actually
somewhat useful, because a regulator must be listed for it to get automatically
turned off when not used. So by having the dtsi + dts files referencing only
the regulators which they use we end up automatically turning off all the
other regulators.

FYI here is the full contents of the dtsi:

/*
  * Copyright 2015 Chen-Yu Tsai
  *
  * Chen-Yu Tsai <wens@csie.org>
  *
  * This file is dual-licensed: you can use it either under the terms
  * of the GPL or the X11 license, at your option. Note that this dual
  * licensing only applies to this file, and not this project as a
  * whole.
  *
  *  a) This file is free software; you can redistribute it and/or
  *     modify it under the terms of the GNU General Public License as
  *     published by the Free Software Foundation; either version 2 of the
  *     License, or (at your option) any later version.
  *
  *     This file is distributed in the hope that it will be useful,
  *     but WITHOUT ANY WARRANTY; without even the implied warranty of
  *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *     GNU General Public License for more details.
  *
  *     You should have received a copy of the GNU General Public
  *     License along with this file; if not, write to the Free
  *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
  *     MA 02110-1301 USA
  *
  * Or, alternatively,
  *
  *  b) Permission is hereby granted, free of charge, to any person
  *     obtaining a copy of this software and associated documentation
  *     files (the "Software"), to deal in the Software without
  *     restriction, including without limitation the rights to use,
  *     copy, modify, merge, publish, distribute, sublicense, and/or
  *     sell copies of the Software, and to permit persons to whom the
  *     Software is furnished to do so, subject to the following
  *     conditions:
  *
  *     The above copyright notice and this permission notice shall be
  *     included in all copies or substantial portions of the Software.
  *
  *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
  *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
  *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
  *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
  *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
  *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
  *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  *     OTHER DEALINGS IN THE SOFTWARE.
  */

/*
  * AXP202/209 Integrated Power Management Chip
  * http://www.x-powers.com/product/AXP20X.php
  * http://dl.linux-sunxi.org/AXP/AXP209%20Datasheet%20v1.0_cn.pdf
  */

&axp209 {
	compatible = "x-powers,axp209";
	interrupt-controller;
	#interrupt-cells = <1>;

	regulators {
		/* Default work frequency for buck regulators */
		x-powers,dcdc-freq = <1500>;

		reg_dcdc2: dcdc2 {
			regulator-name = "dcdc2";
		};

		reg_dcdc3: dcdc3 {
			regulator-name = "dcdc3";
		};

		reg_ldo1: ldo1 {
			/* LDO1 is a fixed output regulator */
			regulator-always-on;
			regulator-min-microvolt = <1300000>;
			regulator-max-microvolt = <1300000>;
			regulator-name = "ldo1";
		};

		reg_ldo2: ldo2 {
			regulator-name = "ldo2";
		};

		reg_ldo3: ldo3 {
			regulator-name = "ldo3";
		};

		reg_ldo4: ldo4 {
			regulator-name = "ldo4";
		};

		reg_ldo5: ldo5 {
			regulator-name = "ldo5";
		};
	};
};

Regards,

Hans
