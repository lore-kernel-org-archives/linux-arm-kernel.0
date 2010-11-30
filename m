From: htejun@gmail.com (Tejun Heo)
Date: Tue, 30 Nov 2010 20:49:29 +0100
Subject: Cannot detect SATA disks w/ CONFIG_SATA_PMP w/o actually using
	SATA multiplier
In-Reply-To: <AANLkTi=0gBcfrAyJNb0+=obH2QDsqhGM5a9xxwHAoh88@mail.gmail.com>
References: <AANLkTi=kbTcq3hYBiDzGcAb02Ppwb1QEcs12-1W_T=LG@mail.gmail.com>
	<4CF50574.6000706@gmail.com>
	<AANLkTi=0gBcfrAyJNb0+=obH2QDsqhGM5a9xxwHAoh88@mail.gmail.com>
Message-ID: <4CF55549.4080000@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 11/30/2010 06:46 PM, Lin Mac wrote:
> Could be,  but disabling it is the last option. And it's anoying to
> have 2 different modules for different uses.
> 
> I'd prefer some clues/checkpoint if possible.

One thing which could be possible is that the controller stashes the
result code for the PMP aware SRST according to the PMP number instead
of the usual place, so the driver can't see it.  In that case, the
driver can be modified to check both places I suppose but if the
hardware can be fixed, that would be great.

> I supposed the behavior of detecting and resetting disks (without
> using port multiplier) should be the same for both with and without
> CONFIG_SATA_PMP. All I know about port multiplier is when it is used
> (not much too), but is there any register configuration or behavior is
> required for multiplier to work properly and take effect even when no
> multiplier is used?

Yeah, the only difference is the PMP port number when issuing SRST.
Non-PMP devices ignore it and respond the same way while PMP
recognizes it and responds with PMP signature instead of the signature
of the first device.  As written above, I think it's quite likely that
the controller is handling the response D2H Reg FIS incorrectly when a
non-PMP device responds to PMP SRST.

Good luck.

-- 
tejun
