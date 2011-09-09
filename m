From: khilman@ti.com (Kevin Hilman)
Date: Fri, 09 Sep 2011 14:52:51 -0700
Subject: [PATCH 13/22] OMAP2+: voltage: keep track of powerdomains in each
	voltagedomain
In-Reply-To: <CAORVsuU27kNiJAt-YRgfJ5i0=ZpfcDhNfY+kYK+AnKurDHDPfQ@mail.gmail.com>
	(Jean Pihet's message of "Wed, 7 Sep 2011 11:23:21 +0200")
References: <1314639355-12713-1-git-send-email-khilman@ti.com>
	<1314639355-12713-14-git-send-email-khilman@ti.com>
	<CAORVsuU27kNiJAt-YRgfJ5i0=ZpfcDhNfY+kYK+AnKurDHDPfQ@mail.gmail.com>
Message-ID: <87pqj9s7rg.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jean Pihet <jean.pihet@newoldbits.com> writes:

> Hi Kevin,
>
> On Mon, Aug 29, 2011 at 7:35 PM, Kevin Hilman <khilman@ti.com> wrote:
>> When a powerdomain is registered and it has an associated voltage domain,
>> add the powerdomain to the voltagedomain using voltdm_add_pwrdm().
>>
>> Also add voltagedomain iterator helper functions to iterate over all
>> registered voltagedomains and all powerdomains associated with a
>> voltagedomain.
>>
>> Modeled after a similar relationship between clockdomains and powerdomains.
>>
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>> ---
>> ?arch/arm/mach-omap2/powerdomain.c | ? ?2 +
>> ?arch/arm/mach-omap2/powerdomain.h | ? ?2 +
>> ?arch/arm/mach-omap2/voltage.c ? ? | ? 80 +++++++++++++++++++++++++++++++++++++
>> ?arch/arm/mach-omap2/voltage.h ? ? | ? 10 +++++
>> ?4 files changed, 94 insertions(+), 0 deletions(-)
>>
> ...
>
>> diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
>> index 966aa88..b41d9f1 100644
>> --- a/arch/arm/mach-omap2/voltage.h
>> +++ b/arch/arm/mach-omap2/voltage.h
>> @@ -19,6 +19,8 @@
>> ?#include "vc.h"
>> ?#include "vp.h"
>>
>> +struct powerdomain;
>> +
>> ?/* XXX document */
>> ?#define VOLTSCALE_VPFORCEUPDATE ? ? ? ? ? ? ? ?1
>> ?#define VOLTSCALE_VCBYPASS ? ? ? ? ? ? 2
>> @@ -55,12 +57,15 @@ struct omap_vfsm_instance_data {
>> ?* @name: Name of the voltage domain which can be used as a unique identifier.
>> ?* @scalable: Whether or not this voltage domain is scalable
>> ?* @node: list_head linking all voltage domains
>> + * @pwrdm_node: list_head linking all powerdomains in this voltagedomain
>> ?* @vdd: to be removed
>> + * @pwrdms: powerdomains in this voltagedomain
>> ?*/
>> ?struct voltagedomain {
>> ? ? ? ?char *name;
>> ? ? ? ?bool scalable;
>> ? ? ? ?struct list_head node;
>> + ? ? ? struct list_head pwrdm_list;
>> ? ? ? ?struct omap_vdd_info *vdd;
>> ?};
> The kerneldoc is not reflecting the code for struct voltagedomain.

hmm, looks like kerneldoc is out of sync in a few places.

Thanks for catching.  Will fixup.

Kevin
