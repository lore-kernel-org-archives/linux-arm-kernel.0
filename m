From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 18 May 2013 21:30:09 +0200
Subject: [RFC 4/4] DRM: tda998x: add missing include
In-Reply-To: <20130518205845.2dfe9fe5@armhf>
References: <20130516192510.GV18614@n2100.arm.linux.org.uk>
 <1368897139-25485-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1368897139-25485-5-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130518194644.2a02a4fc@armhf>
 <CAF6AEGtx7RbvKEEc5uSFvz-2uveB1cnJNf_ESn6JYhfte5UmZQ@mail.gmail.com>
 <20130518205845.2dfe9fe5@armhf>
Message-ID: <5197D6C1.3060702@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/18/2013 08:58 PM, Jean-Francois Moine wrote:
> On Sat, 18 May 2013 14:23:19 -0400
> Rob Clark<robdclark@gmail.com>  wrote:
>
>>> These parameters should not be there. It seems to me that the DT is the
>>> right place.
>>
>> You might not want to directly have a hard DT dependency in tda998x,
>> as the encoder could be used on non-DT platforms.  Although a DT to
>> encoder-params helper might be a nice idea for platforms which do have
>> DT.
>
> If I correctly understand:
>
> - Russell does not use any DT, so his drm driver should be declared in
>    some cubox-setup code in mach-dove/

No. The _device_ is declared in some cubox-setup but the _driver_ goes
into drivers/gpu/drm. Reading vendor provided kernel code may be
misleading as they often just put all stuff in arch/arm/mach-something.

> - this code should also declare the tda998x

The device for tda998x yes, but not the driver. Anyway, Russel decided
to have tda998x probed by his drm_driver.

> - the drm driver contains/passes parameters to the tda998x
>
> As the connection Dove LCD<->  tda998x is Cubox specific, the question
> is: why are'nt the tda998x parameters in the cubox-setup code?

The connection of Dove LCD and tda998x is _not_ Cubox specific, it is
also on the D2Plug. To be precise, even "Dove LCD" is not Dove specific
as you can find the very same controller on other Marvell SoCs with
little differences.

So in the end, we will have a DT node for the HW controllers found
in Dove SoCs, a node for TDA998x, and a node for the video card, i.e.
_how_ lcd controllers, external encoders, clocks, maybe audio, ...
are hooked up on that specific board.

There is so much to take care of like pixel format on lcd pins driving
an external encoder (_not_ only tda998x), what gpio pin is connected to
TDA interrupt line, one or two lcds, ...

The corresponding drivers _will_ take care of it .. but in the future.
All I try to make sure is that driver architecture does not prevent us
from e.g. having two lcds plus dcon later on. Or allows to reuse
dove-drm on pxa where only one lcd but no dcon is available.

Sebastian
