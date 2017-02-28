From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Tue, 28 Feb 2017 16:13:00 +0100
Subject: [PATCH v3 11/25] ARM: dts: Add Actions Semi S500 and LeMaker
 Guitar
In-Reply-To: <20170228123245.GF3691@leverpostej>
References: <20170228063535.32069-1-afaerber@suse.de>
 <20170228063535.32069-12-afaerber@suse.de>
 <20170228123245.GF3691@leverpostej>
Message-ID: <11053e03-8e28-e93d-f1f6-2589a9f7800c@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Am 28.02.2017 um 13:32 schrieb Mark Rutland:
> On Tue, Feb 28, 2017 at 07:35:21AM +0100, Andreas F?rber wrote:
>> +/dts-v1/;
>> +
>> +#include "s500-guitar.dtsi"
>> +
>> +/ {
>> +	compatible = "lemaker,guitar-bb-rev-b", "lemaker,guitar", "actions,s500";
>> +	model = "LeMaker Guitar Base Board rev. B";
>> +
>> +	aliases {
>> +		serial3 = &uart3;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial3:115200n8";
>> +	};
>> +};
>> +
>> +&uart3 {
>> +	status = "okay";
>> +};
> 
>> +#include "s500.dtsi"
>> +
>> +/ {
>> +	compatible = "lemaker,guitar", "actions,s500";
>> +
>> +	/delete-node/ memory;
> 
> Eww. Is this just bodging around skeleton.dtsi?

I guess so: Working around its hardcoded name without unit address, not
finding a /rename-node/ to that effect.

>> +
>> +	memory at 0 {
>> +		device_type = "memory";
>> +		reg = <0x0 0x40000000>;
>> +	};
>> +};
> 
>> +#include "skeleton.dtsi"
> 
> Please don't include skeleton.dtsi.

Wasn't aware that was permissible. I now see it has been updated with a
textual comment, which predates my past uses of skeleton.dtsi - for
other pending work such as FM4 and XMC4500 I only noticed it was moved
out of armv7m.dtsi so that dtc started spewing scary messages. ;)

A #warning might be a more effective way to make people aware of its
deprecation - but sadly we have users that predate #include:

$ git grep /include/ -- arch/arm/boot/dts/ | grep skeleton.dtsi | wc --lines
32
$ git grep /include/ -- arch/arm/boot/dts/ | grep skeleton64.dtsi | wc
--lines
0
$ git grep skeleton -- arch/arm/boot/dts/ | wc --lines
117

Might updating those 32 users be a suitable Outreachy project (CC'ed),
to then get the remaining 85 occurrences to be eliminated by their
maintainers, so that it doesn't get copied for new SoCs any more? :)

> Please add the relevant nodes and
> properties explciitly to your dts{i,} files.

Great, will do.

But this series has grown too large to resend just for such nits. Is
there a chance we can get initial patches queued on some arm-soc
for-next branch soonish? It seems -rc1 pulls were merged 5 days ago?

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
