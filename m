From: ccc94453@vip.cybercity.dk (Rask Ingemann Lambertsen)
Date: Mon, 22 Aug 2016 19:52:05 +0200
Subject: [PATCH 3/9] regulator: core: Try full range when adjusting
 regulators to constraints
In-Reply-To: <20160822162907.GO22076@sirena.org.uk>
References: <20160821021125.1521-1-wens@csie.org>
 <20160821021125.1521-4-wens@csie.org>
 <20160822162907.GO22076@sirena.org.uk>
Message-ID: <20160822175205.h76hurjaopnosymc@vip.cybercity.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 22, 2016 at 05:29:07PM +0100, Mark Brown wrote:
> On Sun, Aug 21, 2016 at 10:11:19AM +0800, Chen-Yu Tsai wrote:
> 
> > Currently when we try to bring regulator in bounds of its constraints,
> > we pick either the minimum or maximum voltage as the target. This fails
> > if the regulator range is not continuous, and the target voltage is not
> > an exact value the regulator can achieve, i.e. the target is not aligned
> > to the step of the regulator.
> 
> This seems like you have buggy constraints, constraints which allow
> voltages that can't physically be satisfied don't make obvious sense.

No, it's for cases like this (see the cubietruck4 or a80-optimus dts
patches):

			reg_bldo4: bldo4 {
				regulator-min-microvolt = <1080000>;
				regulator-max-microvolt = <1320000>;
				regulator-name = "vcc12-hsic";
			};

The regulator can do 1100000 uV, 1200000 uV and 1300000 uV, all of which
are within the constraints, so obviously the constraints can be satisfied,
yet the regulator core fails do so with a message like this:

vcc12-hsic: Bringing 700000uV into 1080000-1080000uV
vcc12-hsic: failed to apply 1080000-1080000uV constraint(-22).

I've run into the same bug trying to support the CX-A99 board, which uses an
AXP808 PMIC [1], which seems to be very similar to the AXP 806. The patch
fixes the bug by rounding the constraints to voltages which are supported by
the regulator. Output from dmesg on my CX-A99 board looks like this:

[    2.577202] vcc12-hsic: Bringing 700000uV into 1080000-1320000uV
[    2.583335] vcc12-hsic: override min_uV, 1080000 -> 1100000
[    2.589003] vcc12-hsic: override max_uV, 1320000 -> 1300000
[    2.594673] vcc12-hsic: 1100 <--> 1300 mV at 1100 mV 

[1] Details on which will be happily accepted, btw.

-- 
Rask Ingemann Lambertsen
