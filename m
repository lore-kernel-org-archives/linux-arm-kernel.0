From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 15 Aug 2013 05:44:52 +0100
Subject: [PATCH] ARM64: KVM: Fix =?UTF-8?Q?coherent=5Ficache=5Fguest?=
 =?UTF-8?Q?=5Fpage=28=29=20for=20host=20with=20external=20L=33-cache=2E?=
In-Reply-To: <20130814173452.GD11390@cbox>
References: <1376480832-18705-1-git-send-email-pranavkumar@linaro.org>
 <f8917fe8409b1fae634c7de45e34d4a7@www.loen.fr>
 <CAAhSdy2TctgKk7m48S7jUCMr2dkDoeyT-r=-SMX+_Ce-sUimYA@mail.gmail.com>
 <5d2d3ae495c27873661c5c2fbdcc19b6@www.loen.fr>
 <CAFEAcA_d-rtiJoAZhGN=cggzakJ5QzU6Upg1GUSBgUOSuqPZoQ@mail.gmail.com>
 <09ec55dcde7961d4774a5239dd9a1184@www.loen.fr> <20130814173452.GD11390@cbox>
Message-ID: <b86f212351d39fc308bd91fcbc733ec8@www.loen.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-08-14 18:34, Christoffer Dall wrote:
> On Wed, Aug 14, 2013 at 04:49:24PM +0100, Marc Zyngier wrote:
>> On 2013-08-14 16:35, Peter Maydell wrote:
>> > On 14 August 2013 16:23, Marc Zyngier <marc.zyngier@arm.com> 
>> wrote:
>> >> On 2013-08-14 15:22, Anup Patel wrote:
>> >>> It seems a bit unnatural to have cache cleaning is user-space. I 
>> am
>> >>> sure
>> >>> other architectures don't have such cache cleaning in user-space
>> >>> for
>> >>> KVM.
>> >>
>> >> Well, we have it on AArch64. Why would we blindly nuke the whole
>> >> cache
>> >> if we can do the right thing, efficiently, on the right range?
>> >
>> > When exactly would userspace have to care about the cache?
>>
>> Only for the initial payload, I'd expect. Unless I've missed 
>> something
>> more crucial?
>
> What happens if the page is swapped out, is the kernel guaranteed to
> flush it all the way to RAM when it swaps it back in, or would KVM 
> have
> to take care of that?

I'd expect the kernel to deal with it, otherwise you'd hit the wrong 
data each time you swap in a page in any userspace process.

>>
>> > This patch isn't exactly clear about the circumstances. I
>> > think you'd need a really strong reason for not dealing with
>> > this in the kernel -- in general userspace KVM tools don't
>> > otherwise have to deal with cache maintenance at all.
>>
>> I believe we *could* do it in the kernel, just at the expense of a 
>> lot
>> more CPU cycles.
>>
>> A possible alternative would be to use HCR.DC, but I need to have a
>> look and see what it breaks...
>>
> Could we flush the cache when we fault in pages only if the guest has
> the MMU disabled and trap if the guest disabled the MMU and flush the
> whole outer dcache at that point in time?

We don't need to trap the disabling of the MMU. If the guest does that, 
it *must* have flushed its cache to RAM already. Otherwise, it is 
utterly broken, virtualization or not.

What the guest doesn't expect is the initial data to sit in the cache 
while it hasn't set the MMU on just yet. I may have a patch for that.

         M.
-- 
Fast, cheap, reliable. Pick two.
