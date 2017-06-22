From: linux@rempel-privat.de (Oleksij Rempel)
Date: Thu, 22 Jun 2017 08:40:44 +0200
Subject: [PATCH v1] ARM: dts: sun7i: provide ramoops region on BananaPi
In-Reply-To: <20170622061617.5guhcyxdthvmiq7j@flea.lan>
References: <1498065017-30556-1-git-send-email-linux@rempel-privat.de>
 <20170622061617.5guhcyxdthvmiq7j@flea.lan>
Message-ID: <48c81184-3713-31a8-03e8-f55ffaef639c@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 22.06.2017 um 08:16 schrieb Maxime Ripard:
> Hi Oleksij,
> 
> On Wed, Jun 21, 2017 at 07:10:17PM +0200, Oleksij Rempel wrote:
>> This should help provide useful debug information on remote
>> targets without UART.
>>
>> Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
>> ---
>>  arch/arm/boot/dts/sun7i-a20-bananapi.dts | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi.dts b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
>> index ed2f35a..38923bf 100644
>> --- a/arch/arm/boot/dts/sun7i-a20-bananapi.dts
>> +++ b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
>> @@ -63,6 +63,22 @@
>>  		stdout-path = "serial0:115200n8";
>>  	};
>>  
>> +	reserved-memory {
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges;
>> +
>> +		ramoops at 7fb6a000 {
>> +			compatible = "ramoops";
>> +			reg = <0x7fb6a000 0x100000>;
>> +			ecc-size	= <16>;
>> +			record-size	= <0x00020000>;
>> +			console-size	= <0x00020000>;
>> +			ftrace-size	= <0x00020000>;
>> +			pmsg-size	= <0x00020000>;
>> +		};
>> +	};
>> +
> 
> I'm a bit skeptical about this one.

I can understand your concern.

> First, there's nothing specific to the bananapi,

It is specific to memory size, bootloader used for the board and in some
cases security co processor. Any thing else I forgot?

> but every one will> want to have different sizes here, or different parameters.

I don't thing every one need different configurations. I assume current
parameters are good enough for most users. But if users need some thing
different they should be overwritten by kernel boot args.

May be, DTS should provide some generic/ramoops area and let
distributions decide how to use it? For example compile kernel with some
defaults for ramoops.

> Since using the kernel parameters is also an option, I'd rather
> document how to do that with the parameters.

Here are my arguments to do this in DTS:
- some issues are hardly reproducible and it is good to catch it as soon
as possible. So it should be enabled before first problem will happen.
- my previous experience with pstore was a bit disappointing, it didn't
worked on SMP system correctly. So the test coverage seems to be
minimal. Probably because it is not enabled by default.
- at least barebox can extract some postmortem information from not
booting system. Bootloader and Kernel need to use same parameters,
devicetree seems to be perfect here.
- distributions should be able to use this per default as soon as this
option is available.

-- 
Regards,
Oleksij

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 195 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170622/4f7b3e81/attachment.sig>
