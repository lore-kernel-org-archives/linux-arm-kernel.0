From: slapdau@yahoo.com.au (Craig McGeachie)
Date: Wed, 02 Oct 2013 22:52:12 +1300
Subject: [RFC PATCH 2/3] Enable BCM2835 mailbox support
In-Reply-To: <524B8D7A.6080204@wwwdotorg.org>
References: <5232F7C2.3070408@yahoo.com.au> <524B8D7A.6080204@wwwdotorg.org>
Message-ID: <524BECCC.6030804@yahoo.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/02/2013 04:05 PM, Stephen Warren wrote:
> On 09/13/2013 05:32 AM, Craig McGeachie wrote:
>> I would prefer something like
>>
>>   mailbox {
>>   	compatible = "brcm,bcm2835-mbox";
>>    	reg = <0x7e00b800 0x400>;
>>   	reg = <0x7e00b880 0x40>;
>
> You can only have one reg property. It could have two separate entries
> if required, but I don't see a need for that.

Ooops.  Sorry, that was a typo.  Lubomir's orginal patch had 0x400, and 
after I figured out 0x40 was a more reasonable size I corrected what I 
thought was a typo by apparently creating a cut'n'paste error.

>
>>   	interrupts = <0 1>;
>> 	#address-cells = <1>;
>
> You'll need #size-cells too, probably with value 0 since the concept of
> size doesn't really apply here.

Yes, I discovered that.

> I wonder if #address-cells might not need to be more than 1 in order to
> generate unique addresses for the multiple devices that hang off the
> property channel?

See below.

>
> And a blank line before the nodes.
>
>> 	brcm,channel at 0 = {
>
> Node names don't have a vendor prefix.

That's useful to know.  I was going by Power_ePAPR_APPROVED_v1.1.pdf 
which has nothing standard about mailboxes or channels.

>> 		reg = <0>;
>> 		brcm,channel-name = "power";
>
> I don't see a need for a channel name.

There is no need for a channel name in the DTS other than documentation, 
but I now think that a better way to do it is #define's for the numbers. 
  That works for the reg values, but I'm not so sure about the node names.

>
>> 	};
>> 	[...etc...]
>>   };
>>
>> But I thought that might be too fussy, or too hard for a boot loader to
>> populate.
>
> Why would the bootloader populate this? Presumably the entire mailbox
> node (and its children) would be statically part of the DT that the
> bootloader reads from disk.

That seems like a probable implementation.  But I didn't want to second 
guess the possibility of the boot loader just dynamically generating the 
lot.  Even if that does like a far fetched idea.  I only thing that I 
can be sure of is that the bootloader will have to modify parts of the 
tree.  To the best of my knowledge, it's the only way to get HDMI 
display dimensions and memory size. And I have both revisions of the 
model B, so I'd like to get it right.

>> @@ -4,12 +4,19 @@ Required properties:
>>
>>   - compatible : should be "brcm,bcm2835-mbox"
>>   - reg : Specifies base physical address and size of the registers.
>> -- interrupts : the interrupt number
>> +- interrupts : the interrupt number. Must be <0 1>, the mailbox interrupt.
>
> The binding should specify the schema, not the data. <0 1> is only true
> in the case where the mailbox IP is hooked into a particular SoC. The
> binding could theoretically be used on other SoCs with different
> interrupt assignments.

Noted.

>> +- brcm,channel-nums : The mailbox channels in use.
>> +- brcm,channel-names : list of symbolic channel names for mailbox clients to
>> +  use.
>> +
>> +The number of channel numbers must match the number of channel names.
>
> As mentioned above, I see no reason to name/number the channels in this
> way. I prefer using the reg address in child nodes to represent this
> information.

The channel names simply came about because that's how the mailbox 
subsystem is implemented.  Not that this is a reason to expose names in 
the DTS.  It occurs to me that the string "8" would be just as valid a 
channel name internally as anything else.  Might be a bit cryptic in 
kernel messages though.  As I said, I'm beginning to think that symbolic 
defines for the channel numbers would be a better form of documentation. 
  I'd only recently stumbled across a reference to them as something 
that dtc now implements.

> I would expect to see something like:
>
> mailbox {
> 	compatible = "brcm,bcm2835-mbox";
> 	reg = <0x7e00b800 0x400>;
> 	interrupts = <0 1>;
> 	#address-cells = <1>;
> 	#size-cells = <1>;
>
> 	regulator at 0 {
> 		compatible = "brcm,bcm2835-mbox-power";
> 		reg = <0>;
> 		... /* various regulator nodes */
> 	};
>
> 	/* or perhaps use @8 for the property FB interface */
> 	framebuffer at 1 {
> 		compatible = "brcm,bcm2835-mbox-fb";
> 		reg = <1>;
> 		...
> 	};
>
> 	serial at 2 {
> 		compatible = "brcm,bcm2835-mbox-uart";
> 		reg = <2>;
> 		...
> 	};
>
> 	clock at 8 {
> 		compatible = "brcm,bcm2835-mbox-clock";
> 		reg = <1>;
> 		#clock-cells = <1>;
> 		...
> 	};
>
> 	...
> };

That's very interesting.  I'm not going to make any comments right now. 
  I need to look at it an think for a few days.  But I will leave you 
another idea that I started implementing last night:

mailbox {
	compatible = "brcm,bcm2835-mbox";
	reg = <0x7e00b880 0x40>;
	interrupts = <0 1>;
	#address-cells = <1>;
	#size-cells = <0>;
	power at 0 {
		reg = <0>;
	};
	fb at 1 {
		reg = <1>;
	};
	vchiq at 1 {
		reg = <3>;
	};
	props_mbox: property at 8 {
		reg = <8>;
	};
};

thermal {
	compatible = "brcm,bcm2835-thermal";
	brcm,channel = <&props_mbox>;
};

Other than that I have an unresolved bug with getting the right channel 
number, it seems to work.  #address-cells and #size-cells are set as you 
said, but because the mailbox is not a registered bus, I can't use any 
of_ functions that rely on it being one.  Which means I have to loop 
over the child node and process the reg properties directly.

I have next to no knowledge about mailboxes on other systems, but I am 
wondering if actually registering as a bus, or at least a class, would 
be a good idea.  Or some standard of_ support for mailboxes.  If it does 
get written, it won't be me.  All I've got is Raspberry Pi's.

Cheers,
Craig.
