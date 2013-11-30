From: stefan@agner.ch (Stefan Agner)
Date: Sat, 30 Nov 2013 17:24:14 +0100
Subject: [PATCH 3/3] ARM: tegra: set SM2 voltage correct
In-Reply-To: <1385632196.5838.4.camel@weser.hi.pengutronix.de>
References: <cover.1385508112.git.stefan@agner.ch>
 <c9ceead9e3df77b5a33ad654db23c241cd624096.1385508112.git.stefan@agner.ch>
 <5296281C.1060403@wwwdotorg.org>
 <1385632196.5838.4.camel@weser.hi.pengutronix.de>
Message-ID: <ab16891b4a6bcfbb1854aa766e4926a7@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 2013-11-28 10:49, schrieb Lucas Stach:
> Am Mittwoch, den 27.11.2013, 10:13 -0700 schrieb Stephen Warren:
>> On 11/26/2013 04:45 PM, Stefan Agner wrote:
>> > Set the requested SM2 voltage to the correct value of 1.8V. The value
>> > before used to work on TPS658623 since the driver applied a wrong
>> > voltage table too. However, the TPS658643 used on newer devices uses
>> > yet another voltage table and those broke that compatibility. The
>> > regulator driver now has the correct voltage table for both regulator
>> > versions and those the correct voltage can be used in this device
>> > tree.
>>
>> One thing you haven't called out explicitly here is that this series is
>> an incompatible change to the DT, since the old buggy driver used to
>> allow old buggy DT content to accidentally work.
>>
> The current (wrong and potentially dangerous) DT content only worked on
> the engineering sample models. So this change definitely does improve
> the situation, even with the risk of breaking a small fraction of
> working boards.
On the released modules, the current value ends in a freeze during
boot-up (since the wrong voltage table results in a too low voltage).

When I use 1.8V in the device tree, the old drivers refuses to set any
voltage. The regulators default/bootloader settings work then better
than the wrongfully applied values (tested on a new device). The probe
just fails:

[    0.243864] tps6586x-regulator tps6586x-regulator: failed to register
regulator REG-SM_2
[    0.244317] tps6586x-regulator: probe of tps6586x-regulator failed
with error -22

So, for newer modules, the incompatible 1.8V DT results in a successful
boot. Since we don't have a regulator driver at all, likely other things
are broken at that situation...

--
Stefan
