From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 10 Nov 2016 11:43:51 +0100
Subject: [PATCH 04/14] ARM: dts: armada-375: Fixup bootrom DT warning
In-Reply-To: <20161110111506.02842cbd@free-electrons.com> (Thomas Petazzoni's
 message of "Thu, 10 Nov 2016 11:15:06 +0100")
References: <20161110001000.10619-1-gregory.clement@free-electrons.com>
 <20161110001000.10619-5-gregory.clement@free-electrons.com>
 <20161110092221.0219490b@free-electrons.com>
 <87wpgbekwg.fsf@free-electrons.com>
 <20161110111506.02842cbd@free-electrons.com>
Message-ID: <87fumzehso.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
 
 On jeu., nov. 10 2016, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:

[...]

>> > A good example of why I'm worried is the sa-sram case:
>> >
>> > +		crypto_sram0: sa-sram0 at 0 {
>> >  			compatible = "mmio-sram";
>> >  			reg = <MBUS_ID(0x09, 0x09) 0 0x800>;
>> >
>> > +		crypto_sram1: sa-sram1 at 0 {
>> >  			compatible = "mmio-sram";
>> >  			reg = <MBUS_ID(0x09, 0x05) 0 0x800>;
>> >
>> > The node names should be just "sram" without a number. Indeed for UARTs
>> > for example, you use uart at XYZ, uart at ABC and not uart0 at XYZ and
>> > uart1 at ABC. But then, if you do that, with your scheme, you end up with
>> > both nodes named sa-sram at 0.
>> >
>> > Which clearly shows that the way you set this unit-address is not
>> > correct: those two devices are mapped at completely different
>> > locations, but you end up with an identical unit address.
>> >
>> > I have no idea what is the rule for setting the unit address in this
>> > case, but I'm pretty sure the rule you've chosen is not good.  
>> 
>> I don't know if there is an existing rules for this case. But I see your
>> concern. What I propose then is to expose the memory windows ID by
>> adding the target and the attributes like this:
>> 
>> 		crypto_sram0: sa-sram at 09_09_0 {
>>  			compatible = "mmio-sram";
>>   			reg = <MBUS_ID(0x09, 0x09) 0 0x800>;
>> 
>> 
>> 		crypto_sram1: sa-sram at 09_05_0 {
>>   			compatible = "mmio-sram";
>>   			reg = <MBUS_ID(0x09, 0x05) 0 0x800>;
>
> I have no idea if 09_05_0 is considered a valid unit address. Indeed
> the _ character in an address looks a bit weird.
>
> I guess we need guidance from the DT binding maintainers on this, since
> it's really a matter of interpreting what "unit address" means in
> relation to the value of the "reg" property.

So I looked for in the reference: Power_ePAPR_APPROVED_v1.0, and in
paragraph "2.2.1.1 Node Name Requirements" we have:

"The unit-address component of the name is specific to the bus type on
which the node sits. It consists of one or more ASCII characters from
the set of characters in Table 2-1. The fundamental requirement is that
at any level of the device tree the unit-address be unique in order to
differentiate nodes with the same name at the same level in the
tree. The binding for a particular bus may specify additional, more
specific requirements for the format of a unit-address."

In Table 2-1 we have the following characters:
0-9
a-z
A-z
,
.
_
+
-

So the underscore is valid. And by adding information about the memory
windows we match the fundamental requirement :"at any level of the
device tree the unit-address be unique".

Gregory

> -- 
> Thomas Petazzoni, CTO, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
