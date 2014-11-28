From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 28 Nov 2014 14:37:14 +0100
Subject: [PATCH 3/9] clk: sunxi: Add prcm mod0 clock driver
In-Reply-To: <20141127190509.GR25249@lukather>
References: <20141126211318.GN25249@lukather> <5476E3A5.4000708@redhat.com>
 <CAGb2v652m0bCdPWFF4LWwjcrCJZvnLibFPw8xXJ3Q-Ge+_-p7g@mail.gmail.com>
 <5476F8AB.2000601@redhat.com> <20141127190509.GR25249@lukather>
Message-ID: <54787A8A.6040209@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 11/27/2014 08:05 PM, Maxime Ripard wrote:
> Hi,
>
> On Thu, Nov 27, 2014 at 11:10:51AM +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 11/27/2014 10:28 AM, Chen-Yu Tsai wrote:
>>> Hi,
>>>
>>> On Thu, Nov 27, 2014 at 4:41 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> <snip>
>>
>>>> I notice that you've not responded to my proposal to simple make the clock
>>>> node a child node of the clocks node in the dt, that should work nicely, and
>>>> avoid the need for any kernel level changes to support it, I'm beginning to
>>>> think that that is probably the best solution.
>>>
>>> Would that not cause an overlap of the io regions, and cause one of them
>>> to fail? AFAIK the OF subsystem doesn't like overlapping resources.
>>
>> No the overlap check is done by the platform dev resource code, and of_clk_declare
>> does not use that. So the overlap would be there, but not an issue (in theory
>> I did not test this).
>
> An overlap is always an issue.
>
>> Thinking more about this, I believe that using the MFD framework for the prcm seems
>> like a mistake to me. It gains us nothing, since we have no irq to de-multiplex or
>> some such. We're not using MFD for the CMU, why use it for CMU2 (which the prcm
>> effectively is) ?
>
> Because the PRCM is much more than that. It also handles the power
> domains for example.

Ok, so thinking more about this, I'm still convinced that the MFD framework is only
getting in the way here. But I can see having things represented in devicetree
properly, with the clocks, etc. as child nodes of the prcm being something which
we want.

So since all we are using the MFD for is to instantiate platform devices under the prcm
nodes, and assign an io resource for the regs to them, why not simply make the prcm node
itself a simple-bus.

This does everything the MFD prcm driver currently does, without actually needing a specific
kernel driver, and as added bonus this will move the definition of the mfd function reg offsets
out of the kernel and into the devicetree where they belong in the first place.

Please see the attached patches, I've tested this on sun6i, if we go this route we should
make the same change on sun8i (I can make the change, but not test it).

Regards,

Hans
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-ARM-dts-sun6i-Change-prcm-node-into-a-simple-bus.patch
Type: text/x-patch
Size: 2173 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141128/6d90bca5/attachment-0002.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-ARM-dts-sun6i-Add-ir_clk-node.patch
Type: text/x-patch
Size: 946 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141128/6d90bca5/attachment-0003.bin>
