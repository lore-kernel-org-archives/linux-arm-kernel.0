From: mkl0301@gmail.com (Lin Mac)
Date: Thu, 2 Dec 2010 18:23:46 +0800
Subject: Cannot detect SATA disks w/ CONFIG_SATA_PMP w/o actually using
	SATA multiplier
In-Reply-To: <4CF55549.4080000@gmail.com>
References: <AANLkTi=kbTcq3hYBiDzGcAb02Ppwb1QEcs12-1W_T=LG@mail.gmail.com>
	<4CF50574.6000706@gmail.com>
	<AANLkTi=0gBcfrAyJNb0+=obH2QDsqhGM5a9xxwHAoh88@mail.gmail.com>
	<4CF55549.4080000@gmail.com>
Message-ID: <AANLkTimWqFh-PD4DFXwaRmthb5Lyw3MAFknFmT7vp5pY@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/12/1 Tejun Heo <htejun@gmail.com>:
> On 11/30/2010 06:46 PM, Lin Mac wrote:
>> Could be, ?but disabling it is the last option. And it's anoying to
>> have 2 different modules for different uses.
>>
>> I'd prefer some clues/checkpoint if possible.
>
> One thing which could be possible is that the controller stashes the
> result code for the PMP aware SRST according to the PMP number instead
> of the usual place, so the driver can't see it. ?In that case, the
> driver can be modified to check both places I suppose but if the
> hardware can be fixed, that would be great.
the usual place, I presume you mean PxTFD+PxSIG.
I've check RFIS of received FIS structure after softreset failed and
nothing there. (UFIS neither)
Is there any other suspect to check?

>> I supposed the behavior of detecting and resetting disks (without
>> using port multiplier) should be the same for both with and without
>> CONFIG_SATA_PMP. All I know about port multiplier is when it is used
>> (not much too), but is there any register configuration or behavior is
>> required for multiplier to work properly and take effect even when no
>> multiplier is used?
>
> Yeah, the only difference is the PMP port number when issuing SRST.
> Non-PMP devices ignore it and respond the same way while PMP
> recognizes it and responds with PMP signature instead of the signature
> of the first device. ?As written above, I think it's quite likely that
> the controller is handling the response D2H Reg FIS incorrectly when a
> non-PMP device responds to PMP SRST.

My situation is that device is sending D2H Reg FIS, but controller is
not reflecting it on PxTFD, PxSIG, or RFIS of received FIS
structure.With the patch I sent, it seems the controller receives D2H
Reg FIS of the same PMP setting of the previous sent H2D Reg FIS, and
drop the different one.

The AHCI controller I used is AHCI v1.1 compatible, command-based switching.

In SATA spec (rev2.6) 16.7.1, it says:

A host controller may support command-based switching by implementing
the Port Multiplier Port (PMP) field in the SControl register as
detailed in section 14.1.3.In order to use this mechanism, host
software would set the PMP field appropriately before issuing a
command to a device conected to the Port Multiplier. (...) Note that
the PMP field shall be set to the control port when host software
issues commands to the Port Multiplier itself.
--

In AHCI spec, the PMP field of PxSCTL "is not used by AHCI".Does it
implies AHCI would set it and software doesn't need to do anything?

13.13.4.1 Port Multiplier Discovery
If  a device is present, the host issues a software reset with the PM
Port field set  to the control port. The host checks the signature
value returned and if....
--

SATA spec didn't says what to do IF it received a data with PMP
setting doesn't match it's current setting (did it?). While 13.13.4.1
only implies the host should receive the signature successfully, even
if it is of different PMP setting.


Best Regards,
Mac Lin
