From: m-karicheri2@ti.com (Murali Karicheri)
Date: Thu, 24 Sep 2015 11:54:12 -0400
Subject: [PATCH 1/3] Documentation: dt: keystone: provide SoC specific
 compatible flags
In-Reply-To: <560406C2.6090200@ti.com>
References: <1442938118-4718-1-git-send-email-nm@ti.com>
 <1442938118-4718-2-git-send-email-nm@ti.com> <5602ED34.9010108@oracle.com>
 <56040323.1080409@ti.com> <560406C2.6090200@ti.com>
Message-ID: <56041CA4.40208@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nishanth,

On 09/24/2015 10:20 AM, Nishanth Menon wrote:
> On 09/24/2015 09:05 AM, Murali Karicheri wrote:
>> On 09/23/2015 02:19 PM, santosh shilimkar wrote:
>>> Nishant,
>>>
>>> On 9/22/2015 9:08 AM, Nishanth Menon wrote:
>>>> Keystone2 devices are used on more platforms than just Texas
>>>> Instruments reference evaluation platforms called EVMs. Providing a
>>>> generic compatible "ti,keystone" is not sufficient to differentiate
>>>> various SoC definitions possible on various platforms. So, provide
>>>> compatible matches for each SoC family by itself.
>>>>
>>>> This allows SoC specific logic to be run time handled based on
>>>> of_machine_is_compatible("ti,k2hk") or as needed for the dependent
>>>> processor instead of needing to use board dependent compatibles that
>>>> are needed now.
>>>>
>>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>>> ---
>>> You need to expand that 'not sufficient' for me. Unless there is
>>> genuine case to support this, I would want to avoid this churn.
>>>
>>
>> I agree. If there are run time check required in code to treat the
>> variants of Keystone SoC differently, then this change is needed. At
>> this time, SoC DTS captures these differences. IMHO, If a future
>> Keystone SoC support required SoC specific compatibility string to
>> customize SoC specific initialization code, then it can be introduced at
>> that time. I am not sure why this is introduced with out an example usage.
>
> a) See
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/usage-model.txt#n116
> -> all we have today is board, soc generic family. The generic
> compatible flag of ti,keystone to mark that this is a keystone2 device
> does not identify that what kind of soc it is. which is what this
> series introduces.
>
> b) there is no realistic way for user space applications such as a
> test framework or other SoC based applications in a generic distro to
> detect the right SoC this platform is running on - imagine writing SoC
> specific code that depends on board compatible flags - there is never
> an end to that story as the number of boards expand.
>
> c) Ideally we will try never to introduce code that will have to
> depend on SoC compatible flag based match in kernel - but that is not
> a reason not to follow guidelines provided by devicetree documentation
> to provide SoC specific compatible flags.
>

Thanks for pointing out the link which provided me some thing to cross 
check my argument.

The relevant description from the above quoted below for discussion.
===================== Cut from the above ===============================

The 'compatible' property contains a sorted list of strings starting
with the exact name of the machine, followed by an optional list of
boards it is compatible with sorted from most compatible to least.  For
example, the root compatible properties for the TI BeagleBoard and its
successor, the BeagleBoard xM board might look like, respectively:

	compatible = "ti,omap3-beagleboard", "ti,omap3450", "ti,omap3";
	compatible = "ti,omap3-beagleboard-xm", "ti,omap3450", "ti,omap3";

Where "ti,omap3-beagleboard-xm" specifies the exact model, it also
claims that it compatible with the OMAP 3450 SoC, and the omap3 family
of SoCs in general.  You'll notice that the list is sorted from most
specific (exact board) to least specific (SoC family).

=======================================================================

So in keystone case, we have

     "ti,k2hk-evm","ti,keystone";

IMO, this is consistent with the above description as ti,k2hk-evm 
describes the board exactly and ti,keystone is the optional list which 
is a generic SoC name.

=========================== Cut from the above==========================

The reasoning behind this scheme is the observation that in the majority
of cases, a single machine_desc can support a large number of boards
if they all use the same SoC, or same family of SoCs.  However,
invariably there will be some exceptions where a specific board will
require special setup code that is not useful in the generic case.
Special cases could be handled by explicitly checking for the
troublesome board(s) in generic setup code, but doing so very quickly
becomes ugly and/or unmaintainable if it is more than just a couple of
cases.

Instead, the compatible list allows a generic machine_desc to provide
support for a wide common set of boards by specifying "less
compatible" values in the dt_compat list.  In the example above,
generic board support can claim compatibility with "ti,omap3" or
"ti,omap3450".  If a bug was discovered on the original beagleboard
that required special workaround code during early boot, then a new
machine_desc could be added which implements the workarounds and only
matches on "ti,omap3-beagleboard".
=======================================================================

This is how interpret the above.

ti,omap3 is the family of omap3 devices similar to keystone. ti,omap3450 
is required if there is an exceptional treatment required for ti,omap3450.

In keystone case so far there is no case of exceptional treatment 
required in the code for a specific SoC. So a generic name, ti,keystone 
is used. When exceptional treatment is needed in the future, for example 
k2hk Soc, we should introduce SoC specific string in the following order.

"ti,k2hk-evm", "ti,k2hk", "ti,keystone"

So unless there is an exception, there is no need for a SoC specific 
string in the compatibility string list. So this can be added later if 
there is need for exceptional treatment. Did I get it wrong?

-- 
Murali Karicheri
Linux Kernel, Keystone
