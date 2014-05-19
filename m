From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 19 May 2014 16:03:19 +0200
Subject: [RFC PATCH 0/3] mfd: AXP22x: add support for APX221 PMIC
In-Reply-To: <1400176305-22737-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1400176305-22737-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140519140319.GI29466@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Thu, May 15, 2014 at 07:51:42PM +0200, Boris BREZILLON wrote:
> Hello,
> 
> This patch series adds basic support for the X-Powers' AXP221 PMIC.
> It's mainly based on Carlo's series [1], which is almost merged (at least
> the mfd and regulator drivers are merged).
> 
> At the moment I only added support for the AXP221 regulators but other
> subdevices will be added later.
> 
> But, before going any further in my developement I'd like to get feedback
> on some points:
> 
> 1) I'm pretty sure we can share some code between the axp20x and axp22x
>    drivers, but I'm not sure how it should be done:
>  a) defining an axp2xx-core.c driver and make the axp20x and axp22x driver
>     use this core implementation.
>  b) just share some macros (like the AXP_DESC one) and the keep drivers
>     separated
>  c) keep only one generic driver that support all PMICs revisions (axp2xx-
>     drivers).
> 
> 2) The ipsout regulator is currently represented as a fixed regulator
>    providing a 5v output, and this is not exactly the case.
>    AFAIU (here's is the datasheet traduction if you want to check [2]), the
>    ipsout output is a multiplexer that choose among vbus (5V), acin (12V
>    which is then converted to 5V) and the battery power supply (3,5 -> 4,2 V).
>    This means the output voltage of ipsout vary between 3,5V and 5V.
>    How can we express this kind of muxer in the regulator framework (is there
>    already something available ?) ?

One thing I'd like to add to this, is that even though the IPSOUT
voltage itself is between the 3.5 / 5V boundaries, there is an
external regulator that boost the voltage to 5V, before being actually
used by any other device on the boards, including the other regulators
that the PMIC can output.

It basically looks like something like this:

+---------------------------------+
| ACIN (12V) -------+             | (3.5 - 5v)
| USB VBUS (5V) ----+----- IPSOUT +-----------------+--------------+
| BAT (3.5 - 4.2V)--+             |                 |    +---------+----------+
|                                 |                 |    |   External Boost   |
|                                 |                 |    |      Regulator     |
|    PMIC                         |                 |    +---------+----------+
|                                 |                 |              +--------------+--- VCC 5V
|                   +-------------+    (3.5V - 5V)  |                     (5V)    +--- USB
|                   |        VIN -+-----------------+                             +--- HDMI
|                   | Random      |                  
|                   | Regulator   |
|                   |             |      (Random V)
|                   |       VOUT -+------------------------
|                   +-------------+
+---------------------------------+

For the some moment, the IPSOUT regulator is decribed as a fixed
regulator, but that seems a bit inaccurate.

Do you have a suggestion?

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140519/1c2c1e42/attachment.sig>
