From: a.beregalov@gmail.com (Alexander Beregalov)
Date: Sun, 23 Aug 2009 21:55:45 +0400
Subject: [PATCH] pxaficp-ir - remove incorrect net_device_ops
In-Reply-To: <200908220054.31438.marek.vasut@gmail.com>
References: <200907240257.10906.marek.vasut@gmail.com>
	<a4423d670907290416h4a0796c2s665d3f8ca0755e67@mail.gmail.com>
	<200908051602.34501.marek.vasut@gmail.com>
	<200908220054.31438.marek.vasut@gmail.com>
Message-ID: <a4423d670908231055o2bb65fe0le2c33fe94b660b38@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2009/8/22 Marek Vasut <marek.vasut@gmail.com>:
> Dne St 5. srpna 2009 16:02:34 Marek Vasut napsal(a):
>> Dne St 29. ?ervence 2009 13:16:25 Alexander Beregalov napsal(a):
>> > 2009/7/28 Eric Miao <eric.y.miao@gmail.com>:
>> > > Marek Vasut wrote:
>> > >> Hi!
>> > >>
>> > >> This patch fixes broken pxaficp-ir. The problem was in incorrect
>> > >> net_device_ops being specified which prevented the driver from
>> > >> operating. The symptoms were:
>> > >> ?- failing ifconfig for IrLAN, resulting in
>> > >> ? ? ? SIOCSIFFLAGS: Cannot assign requested address
>> > >> ?- irattach working for IrCOMM, but the port stayed disabled
>> > >>
>> > >> Moreover this patch corrects missing sysfs device link.
>> > >>
>> > >> btw. guys, be honest, when did you last tested pxaficp-ir on real
>> > >> hardware? ;-)
>> > >
>> > > Well, this seems to be brought by the net_device_ops change, which
>> > > seems to happen silently without any of us being notified.
>> > >
>> > > OK, netdev and Alex are copied, so that we can look into this issue a
>> > > bit deeper:
>> > >
>> > > 1. it looks to me that SIOCSIFFLAGS actually returned -EADDRNOTAVAIL,
>> > > which is likely caused by eth_validate_addr, the default eth_addr comes
>> > > with irda should be "00:00:00:00:00:00" if not explicitly specified
>> > > (kzalloc), and this should be the problem, solution ? ?Either give a
>> > > valid address to the irda net_device or remove this
>> > > 'ndo_validate_addr'. And which is a correct fix will impact on the
>> > > .ndo_set_mac_address
>> > >
>> > > 2. '.ndo_change_mtu' ? It looks to me that Irda device doesn't care too
>> > > much about the MTU, eth_change_mtu is supposed to work just fine and
>> > > not to cause any side effects, and may just benefit later irda device
>> > > drivers if there is a weird device happens to care about MTU
>> > >
>> > > - eric
>> > >
>> > > Marek's original patch in attachment.
>> >
>> > Sorry about that and thanks.
>> > Then we should fix the rest of irda drivers in the same way.
>>
>> Hi!
>> Was my patch applied or what's the current status? Thanks
>
> Hi!
> any updates ? Are we letting this into .32 in current broken state?
>

David, please have a look. Will you apply it?
