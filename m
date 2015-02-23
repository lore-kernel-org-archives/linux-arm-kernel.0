From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 23 Feb 2015 11:12:14 +0000
Subject: stand-alone kvmtool
In-Reply-To: <54E5C16D.3060109@oracle.com>
References: <54DDD465.3050300@arm.com> <54E5C16D.3060109@oracle.com>
Message-ID: <54EB0B0E.3010308@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sasha,

thanks for taking a look!

On 19/02/15 10:56, Sasha Levin wrote:
> On 02/13/2015 05:39 AM, Andre Przywara wrote:
>> Hi,
>>
>> as I found it increasingly inconvenient to use kvmtool[1] as part of a
>> Linux repository, I decided to give it a go and make it a stand-alone
>> project. So I filtered all the respective commits, adjusted the paths in
>> there (while keeping authorship and commit date, of course) and then
>> added the missing bits to let it compile without a kernel tree nearby.
>> The result is now available on:
>>
>> git://linux-arm.org/kvmtool.git
>> http://linux-arm.org/kvmtool.git
> 
> Hi Andre,
> 
> What inconvenience is caused by having it sit inside the kernel tree
> beyond an increased requirement in disk space?

Reduced disk space is admittedly one of the benefits of this exercise.
Also it makes cloning a lot easier and would allow easier packaging.

Many of the issues we face here come from the fact that kvmtool lives in
_a_ kernel repository, but it's not upstream. So we loose the benefit of
joined kernel-userland development. In fact we have to do regular merges
of mostly unrelated upstream kernel code into the branch to get it
compiled with a new feature.
Also having a pure userland tool in the kernel repository sounds just
wrong to me, especially as KVM has a nice API with compatibility
features. There is a clear interface between the KVM kernel and the
controlling userland, so they should not need to share code beyond the
API defining header files. Having a shared code base lures people into
breaking the interface.

> Moving it out will make us lose all the new features and bug fixes we
> gain from using the kernel code directly rather than copying it once
> in a while.

Which code are you exactly thinking of?
>From the code I copied I don't see that rbtree or the Linux list
implementations for instance justify a common code base. If in dire
need, one could setup alerts on the few code files copied to spot
upstream bug fixes.
I see there is a slight drawback in this regard, but I think the
benefits outweigh it.

> With your suggestion we'll end up needing something that copies stuff
> from the kernel into that standalone tree, just like what qemu does.

While I see that copying is not the best solution, QEMU lives very well
with it, doesn't it? With KVM's feature compatibility API and the
kernel's "don't break userland" policy there should be no real problem.
Also with the current situation we just replace "copy uapi header files"
with "merge in upstream kernel code base", which is also manually
triggered and much more ugly IMHO.


I agree that the whole argumentation would be much different if kvmtool
would be upstream, but it is not and as Will pointed out will probably
never be. So to make it's usage easier for the users and distribution
package maintainers, I'd like to see it live on in a separate
(kernel.org) repository.
I could imagine that the easier accessibility would make it more
appealing to potential users (and packagers!)

Cheers,
Andre.
