From: agraf@suse.de (Alexander Graf)
Date: Wed, 9 Jan 2013 21:12:16 +0100
Subject: [kvmarm] [PATCH v5.1 0/2] KVM: ARM: Rename KVM_SET_DEVICE_ADDRESS
In-Reply-To: <1357761007.18196.0@snotra>
References: <1357761007.18196.0@snotra>
Message-ID: <77BCD961-CD00-443B-B84E-1F4B41DFA003@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 09.01.2013, at 20:50, Scott Wood wrote:

> On 01/09/2013 10:48:47 AM, Alexander Graf wrote:
>> On 09.01.2013, at 17:26, Christoffer Dall wrote:
>> > Renames the KVM_SET_DEVICE_ADDRESS to KVM_ARM_SET_DEVICE_ADDR
>> > to make it obvious that this is ARM specific in lack of a better generic
>> > interface.
>> >
>> > Once we agree on a better interface the KVM/ARM code can also take
>> > advantage of that, but until then we don't want to hold up the KVM/ARM
>> > patches.
>> Works for me. Scott, are you happy with this one too?
> 
> Not really, given that it will stay around forever even after something new is introduced.

But only in ARM specific code.

> If you're going to change the name, why not just change it to KVM_SET_DEVICE_CONFIG?  Can we change the name later if nothing else changes (so it's still binary compatible)?

Because that again implies that it's generic enough. And to reach that conclusion will take more time than we should spend on this now.

>> We can start to introduce (and fix ARM) with a generic ioctl in the MPIC patches then.
> 
> The ioctl is already generic, except for its name.

It's making a few wrong assumptions:

  * maximum size of value is u64
  * combining device id (variable) with addr type id (const) into a single field. It could just be split into multiple fields
  * the id is 100% architecture specific. It shouldn't be. At least the "device id" field should be generic.

I'm not sure if we can come up with more problems in that API when staring at it a bit longer and/or we would actually start using it for more things. So for the sake of not holding up the ARM code, I'm perfectly fine to clutter ARM's ioctl handling code with an ioctl that is already deprecated at its introduction, as long as we don't hold everything else up meanwhile.


Alex
