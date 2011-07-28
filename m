From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Thu, 28 Jul 2011 10:40:48 +0200
Subject: [RFC/PATCH 2/7] OMAP3: beagle: don't touch omap_device internals
In-Reply-To: <20110722085716.GI32058@legolas.emea.dhcp.ti.com>
References: <1311292338-11830-1-git-send-email-khilman@ti.com>
	<1311292338-11830-4-git-send-email-khilman@ti.com>
	<20110722085716.GI32058@legolas.emea.dhcp.ti.com>
Message-ID: <CAORVsuXsZXU+rH7ujYJuYDvYjWkCVnZrvkkinFPd9DEBYtdduQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jul 22, 2011 at 10:57 AM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Thu, Jul 21, 2011 at 04:52:13PM -0700, Kevin Hilman wrote:
>> Board code should not touch omap_device internals. ?To get the MPU/IVA devices,
>> use existing APIs: omap2_get_mpu_device(), omap2_get_iva_device().
>>
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>> ---
>> ?arch/arm/mach-omap2/board-omap3beagle.c | ? 23 ++++++++++-------------
>> ?1 files changed, 10 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
>> index 32f5f89..3ae16b4 100644
>> --- a/arch/arm/mach-omap2/board-omap3beagle.c
>> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
>> @@ -491,23 +491,22 @@ static void __init beagle_opp_init(void)
>>
>> ? ? ? /* Custom OPP enabled for all xM versions */
>> ? ? ? if (cpu_is_omap3630()) {
>> - ? ? ? ? ? ? struct omap_hwmod *mh = omap_hwmod_lookup("mpu");
>> - ? ? ? ? ? ? struct omap_hwmod *dh = omap_hwmod_lookup("iva");
>> - ? ? ? ? ? ? struct device *dev;
>> + ? ? ? ? ? ? struct device *mpu_dev, *iva_dev;
>>
>> - ? ? ? ? ? ? if (!mh || !dh) {
>> + ? ? ? ? ? ? mpu_dev = omap2_get_mpuss_device();
>> + ? ? ? ? ? ? iva_dev = omap2_get_iva_device();
>
> out of curiosity again, nothing to do with this patch.
>
> Maybe it would be nicer to have an api such as:
>
> omap2_get_device(name);
>
> there are already four devices to be gotten, if that number grows any
> bigger, so will the number of helper functions.

I agree with this.
The API is also helpful for the PM QoS devices constraints API, which
requires the pointers to devices structs. At the present time only a
few devices can be used and it would be good to have a generic
implementation.

Regards,
Jean

>
> --
> balbi
>
