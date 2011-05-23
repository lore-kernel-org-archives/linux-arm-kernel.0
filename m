From: koen@beagleboard.org (Koen Kooi)
Date: Mon, 23 May 2011 10:55:53 +0200
Subject: [beagleboard] [PATCH v2 2/2] OMAP3BEAGLE: Add support for mt9p031
	sensor driver.
In-Reply-To: <201105231000.32194.laurent.pinchart@ideasonboard.com>
References: <1305899272-31839-1-git-send-email-javier.martin@vista-silicon.com>
	<DDCBBAA2-C49C-4952-9D1B-519D8A3AB41E@beagleboard.org>
	<BANLkTi=ZHyk1+otf2i0qp47Zvvo4nfYk6A@mail.gmail.com>
	<201105231000.32194.laurent.pinchart@ideasonboard.com>
Message-ID: <5C643F76-F34A-4921-A406-B5123CC391A3@beagleboard.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Op 23 mei 2011, om 10:00 heeft Laurent Pinchart het volgende geschreven:

> Hi Javier,
> 
> On Monday 23 May 2011 09:01:07 javier Martin wrote:
>> On 20 May 2011 17:57, Koen Kooi <koen@beagleboard.org> wrote:
>>> In previous patch sets we put that in a seperate file
>>> (omap3beagle-camera.c) so we don't clutter up the board file with all
>>> the different sensor drivers. Would it make sense to do the same with
>>> the current patches? It looks like MCF cuts down a lot on the
>>> boilerplace needed already.
>> 
>> I sent my first patch using that approach but I was told to move it to
>> the board code.
>> Please, don't make undo the changes. Or at least, let's discuss this
>> seriously so that we all agree on what is the best way of doing it and
>> I don't have to change it every time.
> 
> What we really need here is a modular way to support sensors on pluggable 
> expansion boards. Not all Beagleboard users will have an MT9P031 connected to 
> the OMAP3 ISP, so that must not be hardcoded in board code. As the sensor 
> boards are not runtime detectable

Well, they are runtime detectable, you just need to read the ID register on the sensor and they all share the same I2C address. Once you have the sensor ID you can (re)setup the I2C. But doing that in linux seems to be impossible with the current I2C infrastructure.

What we (beagleboard.org) are doing now:

1) set a bootarg in uboot e.g. camera=llbcm5mp
2) read bootarg in linux boardfile and setup i2c

What we are going to do medium term:

1) read ID in uboot, set bootarg
2) read bootarg in linux boardfile

Long term 1) will probably do some devicetree magic. The goal is to plug in a sensor and boot, no manual modprobing, it just works.

regards,

Koen
