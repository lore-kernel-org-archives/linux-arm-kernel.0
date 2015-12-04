From: jeremy.linton@arm.com (Jeremy Linton)
Date: Fri, 4 Dec 2015 16:48:48 -0600
Subject: [RFC PATCH 1/2] PCI/ACPI: Add ACPI support for non ECAM Host
 Bridge Controllers
In-Reply-To: <2425021.SWJx48r3Ls@wuerfel>
References: <1449155999-220955-1-git-send-email-gabriele.paoloni@huawei.com>
 <5018756.5lEEeJVMod@wuerfel> <5661FB9B.20201@arm.com>
 <2425021.SWJx48r3Ls@wuerfel>
Message-ID: <56621850.4070009@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/04/2015 03:34 PM, Arnd Bergmann wrote:
> On Friday 04 December 2015 14:46:19 Jeremy Linton wrote:
>> On 12/03/2015 02:58 PM, Arnd Bergmann wrote:
>>> On Thursday 03 December 2015 17:58:26 Lorenzo Pieralisi wrote:
>>>> I will put together a proposal to define the way we specify HID and
>>>> related DSD properties for PCI host controllers and send it to
>>>> the ACPI working group for review.
>>>
>>> That also requires a change to SBSA, right? Today, SBSA assumes that
>>> we have a standard PCI host that will work with any hardware independent
>>> PCI implementation in an OS. We either have to give up on SBSA saying
>>> much about how PCI hosts are implemented, or stop assuming that hardware
>>> is SBSA compliant.
>>
>> Which would be standardizing nonstandard hardware. It would surprise me
>> if that got much traction.
>
> What do you suggest instead?

Arnd,

Well... I'm simply trying to say that IMHO involving a standards 
committee to get involved with quirky hardware is a little unusual. They 
didn't have to get involved for the dozens of pieces of hardware already 
quirked by the PCI paths in linux.

So, in the end I think its more a question of finding an acceptable 
solution given linux's bus/driver model. In that case I am 100% open to 
constructive suggestions that will result in something that will be 
accepted into mainline. AKA if someone says "do it this way and I will 
take it" then I will go off an make that work. Put another way, I don't 
think anyone likes the need for the existing quirking/blacklisting/etc 
mechanisms for dealing with "buggy" hardware but that doesn't stop them 
from being in the kernel.

For this particular problem, in the case of the APM part I have there 
are probably a handful of ways to get it working. Mark Salter posted a 
patch last year (based on ACPI OEM id) which could be rebased. That is 
where I started recently, but deviated because of complaints on kernel 
lists about it. Right now, I've been trying to delay the quirk detection 
until after the scan has started so that I can use the root pcie VID/PID 
and restart the scan once the correct ops functions have been installed.

Anyway, these two patches (and my unposted one) all have something in 
common vs much of the existing quirk infrastructure. We are trying to 
add a dynamic registration system so the quirks are isolated to the host 
driver rather than hard-coded into the pcie subsystem. I think that is a 
good thing. I can model them on the CRS quirks but I'm pretty sure that 
is worse.
