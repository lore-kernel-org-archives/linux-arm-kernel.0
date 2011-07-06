From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 6 Jul 2011 15:03:45 +0800
Subject: [PATCH v2] ARM: CSR: Adding CSR SiRFprimaII board support
In-Reply-To: <20110706062838.GI9978@ponder.secretlab.ca>
References: <1309231954-23260-1-git-send-email-bs14@csr.com>
	<201106292329.44447.arnd@arndb.de>
	<BANLkTinfKCMcutMDQ+mpdD4EUy9mCpZs+w@mail.gmail.com>
	<201106301236.25822.arnd@arndb.de>
	<BANLkTikoMu3ccUxj5KRmKzdReQcBqK4Y9Q@mail.gmail.com>
	<CAGsJ_4wSKP6EUihOVbUJJ+HUynWGp8PA=8J_WhgmOtVhpd5_Lg@mail.gmail.com>
	<20110706053026.GB9978@ponder.secretlab.ca>
	<CAGsJ_4xV7ecdqnB5gJDUDSg4nvebgubBj4qGJGaCtcpbj-b0gQ@mail.gmail.com>
	<CAGsJ_4yxUzMr4EJd5i0oW1tOa2oK7jicAehKVXXiU_SMDpTQ0Q@mail.gmail.com>
	<20110706062838.GI9978@ponder.secretlab.ca>
Message-ID: <CAGsJ_4xUsw21EM2GXMt4i27MGjCP_h46tCzhDqo-MCZkAVsEiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant,
Thanks.

2011/7/6 Grant Likely <grant.likely@secretlab.ca>:
> On Wed, Jul 06, 2011 at 02:01:24PM +0800, Barry Song wrote:
>> 2011/7/6 Barry Song <21cnbao@gmail.com>:
>> > 2011/7/6 Grant Likely <grant.likely@secretlab.ca>:
>> >>> ? ? ? ? ? ? ? ? ? ? ? intc: interrupt-controller at 0x80020000 {
>> >>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? #interrupt-cells = <1>;
>> >>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? interrupt-controller;
>> >>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? compatible = "sirf,intc", "sirf,prima2-intc";
>> >>
>> >> This looks backwards. ?Most specific values should appear first.
>> >> "sirf,intc" looks to be generic when compared to "sirf,prima2-intc".
>> >> I'm also concerned that "sirf,intc" is trying to be too generic. ?As
>> >> much as possible compatible values should reflect a real
>> >> implementation of the interface, not a generic abstract name. ?Future
>> >> hardware can always claim compatibility with existing older hardware.
>> >> You're probably better off dropping "sirf,intc" entirely, and doing
>> >> the same for similar properties throughout the file.
>> >
>> > i have been confused by compatible in dts and drivers for some time.
>> > if an intc ip core is shared by two chips, for example, prima2 and
>> > atlas6. is the following right?
>> >
>> > in dts for prima2: compatible = "sirf,prima2-intc";
>> > in dts for atlas6: ?compatible = "sirf,prima2-atlas6";
>>
>> sorry for typo. in dts for atlas6: ?compatible = "sirf,atlas6-intc";
>>
>> > in intc drivers shared for both: ? ? compatible = "sirf,prima2-intc",
>> > "sirf,prima2-atlas6";
>>
>> sorry for typo. ?compatible = "sirf,prima2-intc", "sirf,atlas6-intc";
>>
>
> Yes, that is one way to do it, just specify all the implementations
> using the IP core. ?If there are only a few, then this is easy. ?If
> there are a lot of implementations using the same core, then the list
> gets rather large in a hurry.
>
> The intent of compatible is to allow one device to claim compatibility
> with another. ?So, if the prima2 was already supported, and you were adding
> atlas6 support, you could put the following into the atlas6 .dts:
>
> ? ? ? ?compatible = "sirf,atlas6-intc", "airf,prima2-intc";
>
> and the existing driver would work.

it seems you mean if we only support prima2 for the moment:
prima2 .dts:    compatible = "sirf,prima2-intc"
intc driver:       compatible = "sirf,prima2-intc"

then after some time, we bring up atlas6 and find atlas6 can use
prima2 intc driver due to shared ip core, then we let alsta6 .dts
include:
compatible =  "sirf,alsta6-intc", "sirf,prima2-intc"
no matter we change compatible in intc driver to <"sirf,prima2-intc",
"sirf,alsta6-intc"> or not, the driver will always work for alsta6
even only with "sirf,prima2-intc" .

but it seems we will still add "sirf,alsta6-intc" in intc driver if
that really happen in the future. in my understanding, drivers should
explicitly claim all chips or ip cores they can support.

anyway, both prima2.dts and drivers use "sirf,prima2-xxx" should be
the right way for the moment. "sirf, xxx" is too generic now. i will
drop all "sirf, xxx" in both drivers and dts.

>
> The other option when working with IP cores it so encode the version
> of the IP block into the compatible values, and make both boards use
> that. ?ie. ?"sirf,intc-1.32". ?*however* doing so requires that the
> hardware folks actually do a good job of documenting the core versions
> so that the compatible value you use accurately describes the
> hardware.
>
> It is also completely valid for a newer IP core to claim compatibility
> with an older one in the .dts:
>
> ? ? ? ?ie: compatible = "sirf,intc-1.32", "sirf,intc-1.00";
>
> Personally, I prefer anchoring compatible values to the specific
> hardware implmentation rather than the IP core version.
>
>> >
>> > in my understanding, dts for special soc/board contains special
>> > compatible for the chip, drivers shared by multi-soc/board contain all
>> > compatible lists which can be supported by them?
>> >
>> > what's the generic way for this?
>> >
>> >>
>> >> Also, for every new compatible value make sure you add documentation
>> >> for it to Documentation/devicetree/bindings. (You may have already
>> >> done so, it's just something I remind people about a lot).
>> >>
>> >> These comments also apply through the rest of the file.
>> >>
>> >>
>> >
-barry
