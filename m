From: agraf@suse.de (Alexander Graf)
Date: Wed, 9 Jan 2013 22:37:20 +0100
Subject: [kvmarm] [PATCH v5.1 0/2] KVM: ARM: Rename KVM_SET_DEVICE_ADDRESS
In-Reply-To: <1357766143.18196.2@snotra>
References: <1357766143.18196.2@snotra>
Message-ID: <4F8BA51C-1A21-4ED9-80CE-55ECB01C0AAD@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Am 09.01.2013 um 22:15 schrieb Scott Wood <scottwood@freescale.com>:

> On 01/09/2013 02:12:16 PM, Alexander Graf wrote:
>> On 09.01.2013, at 20:50, Scott Wood wrote:
>> > On 01/09/2013 10:48:47 AM, Alexander Graf wrote:
>> >> On 09.01.2013, at 17:26, Christoffer Dall wrote:
>> >> > Renames the KVM_SET_DEVICE_ADDRESS to KVM_ARM_SET_DEVICE_ADDR
>> >> > to make it obvious that this is ARM specific in lack of a better generic
>> >> > interface.
>> >> >
>> >> > Once we agree on a better interface the KVM/ARM code can also take
>> >> > advantage of that, but until then we don't want to hold up the KVM/ARM
>> >> > patches.
>> >> Works for me. Scott, are you happy with this one too?
>> >
>> > Not really, given that it will stay around forever even after something new is introduced.
>> But only in ARM specific code.
> 
> ...which I'll probably have to deal with when Freescale's virtualization-capable ARM chips come along.  I don't see "it's only in that other architecture" as "it might as well not exist".

I'm saying it's limiting its scope to a few lines of code in arch an arch specific file and makes everyone aware that we really need to come to a conclusion soon.

> 
>> > If you're going to change the name, why not just change it to KVM_SET_DEVICE_CONFIG?  Can we change the name later if nothing else changes (so it's still binary compatible)?
>> Because that again implies that it's generic enough. And to reach that conclusion will take more time than we should spend on this now.
> 
> If the conclusion later on is that it is good enough, can the name be changed then?

We can add another generic name, yes. Changing it won't work because it'd break compatibility.

> 
>> >> We can start to introduce (and fix ARM) with a generic ioctl in the MPIC patches then.
>> >
>> > The ioctl is already generic, except for its name.
>> It's making a few wrong assumptions:
>>  * maximum size of value is u64
> 
> This is tolerable IMHO.
> 
>>  * combining device id (variable) with addr type id (const) into a single field. It could just be split into multiple fields
> 
> I agree, but that could be lived with as well.
> 
> I get that there's a tradeoff between getting something in now, versus waiting until the API is more refined.  Tagging it with a particular ISA seems like an odd way of saying "soon to be deprecated", though.  What happens if we're still squabbling over the perfect replacement API when we're trying to push PPC MPIC stuff in?

Then we're the ones who have to come up with a good interface.

> 
> Perhaps the threshold for an API becoming "permanent" should not be acceptance into the tree, but rather the removal of an "experimental" tag (including a way of shutting off experimental APIs to make sure you're not depending on them).  Sort of like CONFIG_EXPERIMENTAL, except actually used for its intended purpose (distributions should have it *off* by default), and preferably managed at runtime.  Sort of like drivers/staging, except for APIs rather than drivers.  Changes at that point should require more justification than before merging, but would not have the strict compatibility requirement that non-experimental APIs have.  This would make collaboration and testing easier on APIs that aren't ready to be permanent.

This tag does exist. It's called "not in Linus' tree" :).

> 
>>  * the id is 100% architecture specific. It shouldn't be. At least the "device id" field should be generic.
> 
> That's a documentation issue that could be changed to have all architectures adopt what is currently specified for ARM, without breaking compatibility.

Depends on how we want to design the final layout. I don't have the impression that we've reached final conclusion on this interface. That's all I'm saying.

> 
>> I'm not sure if we can come up with more problems in that API when staring at it a bit longer and/or we would actually start using it for more things. So for the sake of not holding up the ARM code, I'm perfectly fine to clutter ARM's ioctl handling code with an ioctl that is already deprecated at its introduction, as long as we don't hold everything else up meanwhile.
> 
> I'm not in a position to block it, and if I were I presumably would have seen this in time for feedback to matter.  That's different from actually being happy. :-)

For the ARM specific ioctl it has my ack. I'd say let's go with that and start to work on a good interface ASAP. But we need an ok from Marcelo or Gleb too.


Alex
