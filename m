From: sf84@laposte.net (Sebastian Frias)
Date: Tue, 13 Sep 2016 16:22:09 +0200
Subject: ARM, SoC: About the use DT-defined properties by 3rd-party drivers
In-Reply-To: <20160913131208.GA23336@leverpostej>
References: <57BDAF2E.10502@laposte.net>
 <CAOZdJXVjsR3NTWiJX33yT3jYk=FU65raWoMooTLD7OMN3sqP-A@mail.gmail.com>
 <57D69FB1.2020801@laposte.net> <20160912123809.GB13741@leverpostej>
 <57D6AA54.6000208@laposte.net> <20160912135549.GA14165@leverpostej>
 <57D6D2A9.3010006@laposte.net> <20160912165637.GF14165@leverpostej>
 <57D7CF17.2050905@laposte.net> <20160913131208.GA23336@leverpostej>
Message-ID: <57D80B91.4020306@laposte.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 09/13/2016 03:12 PM, Mark Rutland wrote:
>> Exactly, that is why I was thinking it would take less "review" time.
>> Indeed, if there is no driver, why would it matter what those bindings
>> are?
> 
> If you believe that the bindings don't matter, then there is absolutely
> no reason for them to exist in the first place.

Again, they would be there serving as HW description. Like documentation.
3rd parties and the open-source community could then use them to write
drivers.

Also, it would avoid having multiple DTs (bootloader, Linux, etc.) or
using 'binary DT overlays'.

In one case the nodes/properties would be made public, most likely with
documentation (even if there's no driver for them), in the other case
undocumented 'binary DT overlays' are used.

> 
> If those binding matter to *anyone*, then those collating the bindings
> have some responsibility of stewardship, and that includes
> review/maintenance/etc.
> 
> Hence, the Linux community cares as stewards of those bindings, and
> don't accept bindings they don't understand, for which there is no
> obvious user, nor for which the authors claim stability does not matter.
> Those go against the aims of DT, and against out responsiblities as
> stewards.
> 
> I cannot put that any clearer. 

I understand that.
However, it does not looks crazy to add some sort of 'staging', actually,
I found this:

$ find . -name 'stag*'
./Documentation/devicetree/bindings/staging
./drivers/staging
...
$ ls -1R ./Documentation/devicetree/bindings/staging
./Documentation/devicetree/bindings/staging:
iio
ion

./Documentation/devicetree/bindings/staging/iio:
adc

./Documentation/devicetree/bindings/staging/iio/adc:
lpc32xx-adc.txt
spear-adc.txt

./Documentation/devicetree/bindings/staging/ion:
hi6220-ion.txt

$ ls -1R ./drivers/staging | wc -l
2134

Isn't that a similar use to the one discussed in this thread?

>> Only for bindings for which there is a driver.
> 
> This is not true for all but the most trivial of hardware, as I stated
> previously.
> 
> Go and take a look at all the effort that went into sorting out generic
> IOMMU bindings, when driver support was written after a large amount of
> review to sort out fundamental concepts. We had to sort out fundamentals
> before prototype driver code could be written, and while we knew drivers
> were coming, an awful lot of review effort came first.

Again, you are talking about drivers, but it is not the case at hand.

DT seems essentially free-form, like XML.
One could imagine that some tool could then be used to guarantee that
some parts of DT conform to a given XML schema, including backwards
compatibility, while at the same time ignoring 'staging' stuff.

>> Think about this:
>> - a binding with no driver is submitted and ends up in the tree
>> (it could be on a staging area if necessary)
>>
>> - if at a later point somebody attempts to upstream a driver using those
>> 'staging' bindings, the reviewers could say "you are using 'staging' bindings,
>> please add compatibility with 'staging' and 'standard' bindings", even if that
>> includes the discussion and review of newly created 'standard' bindings
>> corresponding to the 'staging' bindings.
>>
>> - the submitter may even say "there's no need for compatibility for 'staging'
>> bindings, because they were never used (or other valid reasons)".
>>
>> What would you think of something like that?
> 
> As above, if they were never used, and potentially wrong, why did they
> exist?

The last step of my description, where the 'staging' bindings may not have
been used, was listed only for the sake of completeness since it is just a
possibility.
The hope is that they would be eventually used (most likely as is, but
there is also the possibility of having to rethink the bindings when
moving them from 'staging' to 'stable').

> Trying to upstream a binding with no user comees with no immediate
> benefit, and potentially creates longer-term pain, whereas you can defer
> upstreaming a binding until the driver is ready.

The immediate benefit is complete HW description, which, if generalised and
done properly would amount to HW documentation, isn't that good?

> Note that I've repeatedly pointed out that the user of the binding
> doesn't necessarily have to be linux. However, there does need to be
> some demonstration, and commitment to maintaining the principles DT aims
> towards (e.g. stability).

The commitment to stability can be enforced later, since changes would be
reviewed.

If the "user of the binding" is not Linux, under what circumstances
could "Linux" have the legitimacy of guaranteeing or enforcing any Linux-
specific commitment?

>> Let's make an abstraction of the word 'binding', 'create a binding', etc. and
>> just focus on this:
>> - Somebody submits a DT file that contains properties and nodes that are
>> *not used* by any Linux driver.
>> - Said properties and nodes serve as HW description for HW blocks for which
>> *there is no* Linux driver.
>>
>> The goal of the above is to use the DT as the authoritative (and single)
>> source of HW definition.
> 
> I understand that goal, and I've asked for a specific example, as this
> is not clear-cut. e.g. there has been work on describing secure devices
> for QEMU, but this isn't necessarily something we want to expose Linux
> to in general.

Interesting, do you know where in QEMU's code should I look for that?

Because the example I had in mind is something like (totally out of my
imagination):

   /sigma/ {
       audio_decoder_0: {
          version  = <2>;
          revision = <1>;
          program-memory = <0x20100000 0x1000>;
          data-memory    = <0x20101000 0x1000>;
          hwbug-list = <33, 57, 11>;
          arch = <DSP32>;
          mutex-id = <12>;
          irq-line = <9>;
          mbus-read-channels  = <2, 3>;
          mbus-write-channels = <12, 13>;
          has-AAC-support = <1>;
          has-DTS-support = <1>;
          has-SPDIF-output = <1>;
          ...
       };
       audio_decoder_1: {
          version  = <1>;
          revision = <0>;
          program-memory = <0x20200000 0x1000>;
          data-memory    = <0x20201000 0x1000>;
          hwbug-list = <33, 57>;
          arch = <DSP16>;
          mutex-id = <11>;
          irq-line = <8>;
          mbus-read-channels = <4>;
          mbus-write-channels = <14>;
          has-AAC-support = <1>;
          has-DTS-support = <0>;
          has-SPDIF-output = <0>;
          ...
       };
       ethernet: {
          mac-address = [ 00 11 22 33 44 55 ];
          hwbug-list = <23>;
       };
       video_decoder: {
          version = <4>;
          revision = <0>;
          memory = <0x20300000 0x10000>;
          arch = <MIPS4K>;
          mutex-id = <12>;
          irq-line = <7>;
          has-H264-support = <1>;
          ...
       };
   ...
   };

We could even imagine a section like:

   boot: {
      verify-images = <1>;
      boot-order = <NAND, SD, SATA>;
      enable-uart = <0>;
      debug-level = <1>;
   };

>> Ok, so if the information is not relevant to Linux do you agree that it
>> should not affect it, and then we could imagine such details being present on
>> the DT anyway?
> 
> Perhaps, or perhaps not. It depends on a number of details, and as I've
> said previously I cannot give you a general answer, because there is
> none. You must provide a specific case.

I gave one above, but I still don't understand why would it matter.
I mean, it should be easy:
- is the node/property used by a Linux driver?
  - YES => you must submit both DT+driver
  - NO  => we don't care

>> You mention the case of another OS.
>> What is the definition of OS in this case?
> 
> Generally, I am considering a general purpose OS (e.g. Linux, FreeBSD),
> and not a secure-world trusted OS nor firmware (as typically these are
> very strongly tied to the platform, and have very different strtuctures
> and requirements when compared to a general purpose OS).
> 
> That's the conext in which bindings are developed.
> 

I see, thanks.

>> Because one could say that "FW" or "secure world" could fit that definition,
>> right?
> 
> There's been work on describing things about the secure world in DT for
> QEMU. Firmware is typically so device-specific that an upstream/common
> DT doesn't really make sense.
> 
> Perhaps you have an example of the specific use-case you care about?

Like I said, this started like an hypothetical question as a way to centralise
all HW description in a single place.
Currently it is spread over multiple places and it is very error prone, not
to mention that not everybody gets all the information at once.
Also, DT is meant to be shared by at least Bootloader and Linux, so it would
be better if it was unique.

Anyway, I tried to make a more concrete example further above.
Hopefully it serves to illustrate more the idea.

>> Indeed, to me it is clear that what we conceive "differently", is that
>> "the effort", "lack of benefit for the community", "Old bindings should
>> remain supported regardless" and "backward compatibility" are considered
>> with respect to DT *plus* driver, yet the idea is to have DT describe
>> HW for which there's no upstream driver yet.
>> Hence most of those considerations should not apply, right?
> 
> No.
> 
> Bindings themselves should remain stable over time in that they must be
> evolved so as to allow software to handle them in a stable fashion,
> supporting old and new DTBs.

Yes, but "must be evolved so as to allow software to handle them in a stable
fashion, supporting old and new DTBs." makes sense for Linux drivers, or
from Linux's perspective.

Project independence rules should allow for projects to cooperate without
interfering with each other.

> 
> While a lot of that effort is taken by code, care must also be taken wit
> the bindings themselves, and those considerations apply.

IMHO, they apply only when there's a Linux driver, or any other public
user of such bindings. But if there's no user, it seems like an unnecessary
constraint.

Best regards,

Sebastian
