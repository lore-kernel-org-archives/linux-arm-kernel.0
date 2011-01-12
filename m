From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 12 Jan 2011 16:38:54 +0000
Subject: ARM: relocation out of range (when loading a module)
In-Reply-To: <4D2DD5F8.5000200@parrot.com>
References: <4D2B4CE4.9080309@ahsoftware.de>
	<alpine.LFD.2.00.1101101722470.9794@xanadu.home>
	<4D2BFA08.5030104@ahsoftware.de>
	<AANLkTinR7ih2ZMRMbXmSvoh-rS3LVv+UCvd0rRH_ESzf@mail.gmail.com>
	<20110111155930.GH11039@n2100.arm.linux.org.uk>
	<4D2DD5F8.5000200@parrot.com>
Message-ID: <20110112163854.GE11039@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 12, 2011 at 05:25:28PM +0100, Matthieu CASTET wrote:
> Russell King - ARM Linux a ?crit :
>> On Tue, Jan 11, 2011 at 09:16:38PM +0530, Rabin Vincent wrote:
>>> It's possible to hack around this by placing the initramfs at the end of
>>> the kernel image rather than at the beginning with the rest of the init
>>> data.  Something like the below should work, although you should also
>>> probably take care of alignment and also have this section freed when
>>> the rest of the init data is freed.
>>
>> You're then running into problems as _sdata.._edata is copied to RAM on
>> XIP kernels, and you really don't want to waste time copying the
>> initramfs to RAM.
>>
> But in this case initramfs is after edata and before bss.

Right, so that isn't a concern.

> So where is the problem ?

There is a problem with it, as noted by Rabin.  The initramfs will
never be freed.  Let's try to find a proper solution to this rather
than everyone sticking their half-baked ideas at it.  Let's see if
we can rearrange the _entire_ layout in a way that sorts this out
once and for all without making things even more complicated than
they already are today.

We've already got enough variables to think about here without having
yet more freeable sections scattered in the middle of the existing
layout.
