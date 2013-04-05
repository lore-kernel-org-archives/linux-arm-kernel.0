From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 5 Apr 2013 10:44:12 +0100
Subject: regulator: query on regulator re-entrance
In-Reply-To: <1365138582-10409-1-git-send-email-nm@ti.com>
References: <1365138582-10409-1-git-send-email-nm@ti.com>
Message-ID: <20130405094411.GA6597@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 05, 2013 at 12:09:42AM -0500, Nishanth Menon wrote:

> If we ignore the details of the class 1.5 implementation, we will notice
> a) regulator set_voltage equivalent set_voltage() is required.
> b) this set_voltage does some 'magic stuff' depending on the SoC and AVS class
> and calls the 'real regulator' which talks to the PMIC over i2c/spi etc..
> in short the call sequence is more or less:
> 
> driver (cpufreq) -> AVS -> PMIC regulator.
> 
> By modeling AVS class drivers as an regulator, we then do not need to introduce
> SoC specific hacks and APIs.

But you're shoehorning something into the regulator API which isn't
supposed to be there and causing yourself problems.  This just isn't a
good idea.  The regulator API already has a mechanism for supporting
regulators which are supplied by other regulators, if you can't model in
terms of that (adding something to support variability better) then
you're not using a regulator.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130405/1d9819c6/attachment.sig>
