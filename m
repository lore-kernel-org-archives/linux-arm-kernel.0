From: monstr@monstr.eu (Michal Simek)
Date: Mon, 13 May 2013 17:59:27 +0200
Subject: [RFC] device-tree.git automatic sync from linux.git
In-Reply-To: <1368446352.537.81.camel@zakaz.uk.xensource.com>
References: <1366800525.20256.266.camel@zakaz.uk.xensource.com>
 <5190900D.5020408@monstr.eu> <1368446352.537.81.camel@zakaz.uk.xensource.com>
Message-ID: <51910DDF.9010202@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/13/2013 01:59 PM, Ian Campbell wrote:
> On Mon, 2013-05-13 at 08:02 +0100, Michal Simek wrote:
>> Just small overview it is a Xilinx soft core cpu where you can even setup
>> some parameters for core itself - multiplier, divider, BS, fpu, cache sizes, etc.
>> You have to also compose the whole system and every platform/configuration is different
>> because you can setup addresses, IP on the bus, IRQs, etc.
>> Based on this configuration we have created tcl script which is able to generate
>> DTS directly from Xilinx design tool and it is working quite well for several years
>> and everybody just use it without any problem.
> 
> That sounds very neat!
> 
> Does this tcl script live in the kernel tree? If so would you think it
> would make sense for it to also migrate to device-tree.git? I'm not at
> all sure if that makes sense but if you think it does please let me know
> which paths need top be carried over.

No. This script is here.
https://github.com/Xilinx/device-tree/tree/master-next

It is tightly connected to Xilinx design tool that's why I don't think it is useful
to add it to any other tree.


>> As you see in your repo there is only one microblaze DTS which is for one of mine
>> ancient configuration which none used.
>> It means from microblaze point of view we can simple remove it from mainline kernel
>> because it is useless.
> 
> That will then naturally get propagated over to device-tree.git.

I will think about it for a while and probably just remove it through my microblaze tree.


>> I also care about arm zynq platform where situation is partially different because
>> zynq is fixed block but you can add others thing to programmable logic.
>> It means for zynq case we are almost in the same situation where every zynq based
>> platform is using different configuration and that's why fpgas are so great.
>>
>> It means for zynq case everybody will need different DTS but will be just good
>> to describe or show binding.
>> Currently we have just one dts for zc702 xilinx reference board.
>>
>> Let's move to my point.
>> Based on our experience all xilinx boards don't depend on any dts in the linux kernel
>> and our users just understand the reason why they should use our tcl script for
>> DTS generation.
>>
>> Back to your point about moving DTSes out of the kernel.
> 
> I suppose you are now commenting on the Phase II bit where maintenance
> of the DTS moves out of linux.git into device-tree.git, rather than
> Phase I work, which is creating a split repo which is automatically
> synchronised from linux.git but maintenance remains in linux.git, i.e.
> what I'm doing here.

ok.

>>  For microblaze - no problem
>> just do it. For arm zynq this is more problematic because there is weird binding
>> for ARM. For example PMU which is out of bus and should be probably in cpu node.
>> Also scu devices, scutimers, watchdog which lie on the bus for our case and we
>> need to use PPI interrupt cpu mask. Different clock binding, maybe pinmux binding, etc.
>>
>> It means from my point of view if binding is correct, no problem to move it
>> out of the kernel. If a kernel patch change binding, it is worth for me to change
>> dts in the kernel too to reflect this change and track this change too.
>> My proposal is, let's clean all DTSes in the arm kernel that all platform use
>> the same binding where all platforms are just correctly described.
> 
> AIUI this split/move isn't intended to change the existing policy, which
> is already that DTS files are supposed to remain compatible across
> kernel versions and that "flag days" are to be avoided. The split is
> supposed to make it harder (if not impossible) to accidentally break
> that policy.
> 
> On the other hand I suppose there is an argument to be made for clearing
> up the cruft *before* making the split.
> 
> Ultimately I think this will be up to Grant & co.

ok.

>> The reaching this point I would suggest that for arm, arm-soc maintainers should
>> keep eyes on any dts binding change and all these changes require ACK from Rob or Grant
>> (like device-tree maintainers).
> 
> Yes, once we move onto Phase II I don't expect it will end up being me
> that is the DTS maintainer -- I expect the maintenance will remain with
> those who take care of it in linux.git today.
> 
> My involvement in Phase I is really just to help out with the transition
> (ulterior motive: the Xen project would also like to use these DTS
> files...) not to perform a "land grab" or take over maintenance etc. I
> certainly don't think I am the right person to become the long term
> maintainer of device-tree.git!

Ok. I see you point right now in connection to different project where
your Phase I make more sense.
Our flow, because of a lot of flexibility in fpga word, is more based on DTS which
we don't have in hand and everyone has to maintain it.
Starting to using not correct DTSes by another project will be problematic.

It is good step but it suggests that they can start to use it but one change
in the kernel binging will caused that it breaks another project.

>From my point of view this Phase I is good to do for DTSes which are correct.
Then another project can be sure that they won't change a lot.

I have the same experience with our DTS driven Qemu that it works when description
is stable but till that time it is just pain because you need to be sure
that all binding changes are also done in Qemu.

Thanks,
Michal




-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130513/20fd352c/attachment.sig>
