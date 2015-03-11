From: stsp@list.ru (Stas Sergeev)
Date: Wed, 11 Mar 2015 18:01:18 +0300
Subject: [PATCH] n_tty: use kmalloc() instead of vmalloc() to avoid crash
 on armada-xp
In-Reply-To: <20150311131433.GC8656@n2100.arm.linux.org.uk>
References: <54FF21BE.2040506@list.ru> <550038C9.7010807@free-electrons.com>
 <20150311131433.GC8656@n2100.arm.linux.org.uk>
Message-ID: <550058BE.3060406@list.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

11.03.2015 16:14, Russell King - ARM Linux ?????:
> On Wed, Mar 11, 2015 at 01:44:57PM +0100, Gregory CLEMENT wrote:
>> Hi Stas,
>>
>> On 10/03/2015 17:54, Stas Sergeev wrote:
>>> Hello, the patch below is needed for a successful boot on armada-xp.
>>>
>> I am really surprised by this patch because I used the Armada XP based
>> board in a daily base and I never saw this issue.
> Can you provide some details about your board - does it have 8GB of
> memory, ranging from 0-0xf0000000, and 4G-8G ?
I wonder about this 256Mb memory hole.
There is only one dimm for whole 8Gb.
It seems 0xf000000-0xffffffff is used for PCI though:
---

0xf3000000-0xf303ffff 64bit]
[  119.290027] pci 0000:00:00.0: BAR 2: set to [mem
0xf3000000-0xf303ffff 64bit] (PCI address [0xf3000000-0xf303ffff])
[  119.300509] pci 0000:00:00.0: BAR 0: assigned [mem
0xf3040000-0xf305ffff 64bit]
[  119.307883] pci 0000:00:00.0: BAR 0: set to [mem
0xf3040000-0xf305ffff 64bit] (PCI address [0xf3040000-0xf305ffff])
[  119.318367] pci 0000:00:00.0: BAR 6: assigned [mem
0xf3060000-0xf306ffff pref]

---

Does this mean that the 256Mb of physical memory is
completely unaccessable on this board?
