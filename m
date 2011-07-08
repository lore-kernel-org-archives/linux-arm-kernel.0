From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 08 Jul 2011 09:56:09 -0700
Subject: [PATCH 0/7] Re-organize linker layouts
In-Reply-To: <20110708160329.GF4812@n2100.arm.linux.org.uk>
References: <20110706102245.GO8286@n2100.arm.linux.org.uk>
	<4E15ECB6.40100@codeaurora.org>
	<20110707223620.GG20403@n2100.arm.linux.org.uk>
	<4E165597.90002@codeaurora.org>
	<20110708090721.GC2414@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1107080941090.14596@xanadu.home>
	<20110708160329.GF4812@n2100.arm.linux.org.uk>
Message-ID: <4E1736A9.9040102@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/8/2011 9:03 AM, Russell King - ARM Linux wrote:
> On Fri, Jul 08, 2011 at 09:46:42AM -0400, Nicolas Pitre wrote:
>> On Fri, 8 Jul 2011, Russell King - ARM Linux wrote:
>>
>>> There's also platforms where the zImage is loaded at some predetermined
>>> offset into RAM to give the decompressor room to directly place the
>>> kernel in its final location too, which will be buggered by
>>> AUTO_ZRELADDR.
>>
>> How so?  Loading that zImage at the same predetermined offset will still 
>> have the same desired effect.  As long as the offset is within 128MB of 
>> the start of RAM.
>
> You just said it...
>
> Given that it's 128MB, Stephen shouldn't have a problem with loading the
> zImage at 0xN0208000, but he said it doesn't work.  I think there's some
> work to be done there to figure out if Stephen really has a problem, and
> what that problem is.

My problem is due to how the zreladdr is calculated. Our ram starts at
0xN0200000 and loading the zImage at 0xN0208000 works fine, but then
when zreladdr is calculated it essentially aligns PC to 128MB and then
my kernel is loaded at 0xN0008000. I've lost the 2. It looks like other
machines are in a similar situation (or their zImage is loaded somewhere
beyond 128MB and it never works).

Why can't this work via atags (or DT for that matter)? atags have always
said where ram starts and we should be able to write some code that
parses the atags/DT and figures out the final resting place of the
decompressed image.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
