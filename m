From: jcm@jonmasters.org (Jon Masters)
Date: Thu, 18 Jan 2018 20:17:13 -0500
Subject: [PATCH v2] arm64: Branch predictor hardening for Cavium ThunderX2
In-Reply-To: <20180118232816.GA93910@jc-sabre>
References: <20180108164651.GQ25869@arm.com>
 <1515502022-7376-1-git-send-email-jnair@caviumnetworks.com>
 <e9a192da-f603-6523-6d2e-858eb9c7d1b2@jonmasters.org>
 <20180116234554.GA38392@jc-sabre> <20180118135354.GB20783@arm.com>
 <20180118175615.GF38392@jc-sabre>
 <cd75aa1e-10ec-2e40-3136-a34d4ec2258f@jonmasters.org>
 <20180118232816.GA93910@jc-sabre>
Message-ID: <4317e419-ddb1-b5b8-35a5-0cc227e1d217@jonmasters.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi JC, Will,

On 01/18/2018 06:28 PM, Jayachandran C wrote:
> On Thu, Jan 18, 2018 at 01:27:15PM -0500, Jon Masters wrote:
>> On 01/18/2018 12:56 PM, Jayachandran C wrote:
>>> On Thu, Jan 18, 2018 at 01:53:55PM +0000, Will Deacon wrote:

>>> I think in this case we have to choose between crashing or giving a false
>>> sense of security when a guest compiled with HARDEN_BRANCH_PREDICTOR is
>>> booted on an hypervisor that does not support hardening. Crashing maybe
>>> a reasonable option.
>>
>> Crashing is a completely unreasonable option and is totally
>> unacceptable. We never do this in enterprise, period.
>>
>> It's reasonable to give an output in dmesg that a system isn't hardened,
>> but it's not reasonable to crash. On x86, we added a new qemu machine
>> type for those guests that would have IBRS exposed, and ask users to
>> switch that on explicitly, but even if they boot the new kernels on
>> unpatched infrastructure, we'll detect the lack of the branch predictor
>> control interface and just log that.
>>
>> The exact same thing should happen on ARM.
> 
> With the current patchset from ARM, there is no way of detecting if the
> hypervisor is hardened or not, to provide the warning.  The only other
> option I have call get version blindly and provide a false sense of
> security.

Agreed that (unless) I'm missing something, the current arm patchset
doesn't have an enumeration mechanism to see if firmware supports the
branch predictor hardening or not. Am I missing something there?

On the three other affected arches we're tracking, there's an
enumeration mechanism. On x86, there's a new set of CPUID bits. On
POWER, there's a new hcall that tells us whether the millicode supports
what we need, and on z there's a new facility code we can test for that
is also passed into VMs. So we need to have a similar enumeration
mechanism on ARM that is passed into guests as well.

> Since both options are bad, I don't have a good solution here. If RedHat
> has a preference here on what would be better, I can go with that.

We need an enumeration mechanism that determines whether the hypervisor
is patched. In the absence of that, blindly calling in and hoping that
the firmware is updated is better than nothing. I'll look to see if
there's a generic upstream solution for enumeration that I've missed (or
that can be added, perhaps a new SMC enumeration mechanism). If there
isn't a short term fix, we'll work with you guys directly to add
something RHEL specific by checking some firmware version somehow.

Jon.
