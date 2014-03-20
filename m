From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu, 20 Mar 2014 16:25:55 +0100
Subject: [GIT PULL 00/21] Renesas ARM based SoC Board Updates for v3.15
In-Reply-To: <201402251704.54970.arnd@arndb.de>
References: <cover.1391665225.git.horms+renesas@verge.net.au>
 <20140220082316.GE19089@quad.lixom.net>
 <CANqRtoQj8CNn=pNP5HkVbaSSc=PbZEoOD3wGa9sXF9nXraTVeQ@mail.gmail.com>
 <201402251704.54970.arnd@arndb.de>
Message-ID: <532B0883.9090509@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/02/14 17:04, Arnd Bergmann wrote:
> On Tuesday 25 February 2014, Magnus Damm wrote:
>> On Thu, Feb 20, 2014 at 5:23 PM, Olof Johansson <olof@lixom.net> wrote:
>>> On Thu, Feb 06, 2014 at 03:17:08PM +0900, Simon Horman wrote:
>> Thanks for your email. I agree that the number of board file commits
>> is definitely larger than zero so some clarification is in order.
>>
>> As you probably recall, we earlier agreed on not adding any new board
>> files. That part is clear I believe so I will skip that.
>>
>> Regarding the legacy board code, we have quite ok hardware support
>> coverage as it is now, but some devices drivers are of course still
>> under development. This means that in some cases integration is on
>> going or has not happened yet. You may see those kind of changes as
>> significant commits in the pull requests for board support.
>
> [adding Ben Dooks, since he was complaining about this as well]

that's putting it mildly....

> My feeling is that we should adjust the strategy for shmobile. We've
> had good success with the dual strategy of keeping board support
> separate for DT-enabled and ATAGS-only boards in the sense that
> we did not have to coordinate updates for bindings between subsystem
> and architecture git trees, which has always been source for
> problems on other platforms.

Personally, I would be happy with no more platform support at-all.

> However, the price for this seems to be that it's still not possible
> to get a properly working system without a board file, and my feeling
> is that it's taking too long to get there. In particular, we now see
> new drivers getting added (I noticed VIN, which Ben mentioned before)
> that start out with just platform_device support but no DT support.
> This is bad, because it means DT users are always behind.

Agreed, for development purposes my current development tree I
am using on the Lager is showing:

  136 files changed, 13142 insertions(+), 1765 deletions(-)

This includes a specific lager_defconfig and Simon's development
work at the time 3.14-rc3 was out.

>> In the Legacy Lager/Koelsch board code the following devices are
>> supported as platform devices:
>>
>> ETHER, SCIF, DU, I2C, SATA*, USB*, MSIOF*, SDHI*, QSPI*, MMCIF,
>> Audio*, VIN*, Thermal, IRQC, PFC, CMT
>>
>> * Platform device support under development in v3.15-pre
>>
>> In the Multiplatform DT for Lager/Koelsch the following devices have DT support:
>>
>> ETHER, SCIF**, I2C, SATA, MSIOF, SDHI, QSPI, MMCIF, Thermal, IRQC, PFC, CMT**

I've tested Ether, I2C, SHDI and MMCIF.

>> ** Driver DT binding development on-going but integration not finalized
>>
>> In Multiplatform DT for Lager/Koelsch the following devices lack DT bindings:
>>
>> DU (drm/kms)
>> USB (host/function/phy)
>> Audio (alsa-soc + dmac)
>> VIN (v4l2 + camera sensor)
>
> Ok, thanks for the list.

The ALSA is on list and seems to be working with minor patches for
the odd issue we found when testing. I will re-post the DMAC branch
tonight for people to review.

VIN, I've sent patches for but these need to be re-sent with some
updates for soc-camera as well as the video input driver updates.

The USB is currently work in progress, both Sergei and I have sent
patches for the PHY, I have patches for DT for the USB host on list.

I feel this would have been faster if we had not found multiple issues
such as the pm_runtime, and bugs in some of the dt support that seems
to have missed being tested until the above have been attempted.

I hope between Geert, Laurent, Sergei and the people at Renesas we've
made some significant steps forward this release cycle. The issues
with pm_runtime should now be sorted as well as other device-tree
problems with shmobile.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
