From: andre.przywara@arm.com (Andre Przywara)
Date: Thu, 17 Dec 2015 12:32:57 +0000
Subject: block layer bug with 4.4-rc3+
In-Reply-To: <CACVXFVMXjSFkj0Wb2qDFqDjWUA1fY41MZdN6SDKVH=H8grLZdg@mail.gmail.com>
References: <566FF3ED.1000503@arm.com>
 <CACVXFVNLY97FAJ_tUF1UW4t=3cf6c5mfHXOpbfq1iSSiKciCNw@mail.gmail.com>
 <5670062B.7020103@arm.com>
 <CACVXFVN3w0Y_8k3TiKoGytbayXiB+mRhgDn-OueV2+e93i=4AQ@mail.gmail.com>
 <56717B6F.2040008@arm.com>
 <CACVXFVMXjSFkj0Wb2qDFqDjWUA1fY41MZdN6SDKVH=H8grLZdg@mail.gmail.com>
Message-ID: <5672AB79.3030004@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ming,

On 17/12/15 03:52, Ming Lei wrote:
> On Wed, Dec 16, 2015 at 10:55 PM, Andre Przywara <andre.przywara@arm.com> wrote:
>> Hi,
>>
>> On 15/12/15 13:39, Ming Lei wrote:
>>> On Tue, Dec 15, 2015 at 8:23 PM, Andre Przywara <andre.przywara@arm.com> wrote:
>>>> Hi Ming,
>>>>
>>>> thanks for the answer!
>>>>
>>>> On 15/12/15 11:54, Ming Lei wrote:
>>>>> On Tue, Dec 15, 2015 at 7:05 PM, Andre Przywara <andre.przywara@arm.com> wrote:
>>>>>> Hi,
>>>>>>
>>>>>> I've been experiencing issues with at least 4.4-rc3 (including current
>>>>>
>>>>> I'd suggest you to test the latest linus tree first, and at least two
>>>>> fix patches
>>>>> have been merged for blk-merge issue.  If there is still the issue
>>>>> with linus tree,
>>>>> I am happy to take a look.
>>>>
>>>> Mmh, as said ("including current HEAD") this happens still with the
>>>> latest HEAD from Linus (which is "9f9499ae8e64: Linux 4.4-rc5" for me).
>>>> Just tested yesterday.
>>>> Is there another branch/tree with block fixes I should test? Is it worth
>>>> to try any of the upcoming branches in linux-block.git (for-4.5/core,
>>>> maybe?)
>>>
>>> Both the fixes have been in linus tree already, and reverting the commit
>>> basically makes merge not possible, so there must be issues somewhere.
>>>
>>> And can you see the issue on other 32bit ARM platform?  I don't see the
>>> issue on x86 and arm64, and the commit itself is correct, IMO.
>>
>> Quick tests on a Cubietruck didn't show the issue, but this board is
>> nowhere near the Midway (2 in-order cores with 2GB RAM vs. 4
>> out-of-order cores with 8 GB RAM), so the load isn't the same.
>> I could rule out .config issues by using multi_v7_defconfig - with LPAE
>> enabled on top, that is.
>> Using the plain multi_v7_defconfig (which doesn't have LPAE and makes me
>> loose half of the RAM on that box) didn't show the bug so far.
>> One of the effects of turning on LPAE is that dma_addr_t and phys_addr_t
>> turn to 64-bit, with long, int and void* still being 32-bit. Can you
>> think of any issues that could be related to that?
>>
>> Also can you briefly sketch what that patch (578270bfbd) eventually
>> changes? I see that the fix looks right, I am just wondering what the
>> impact is: Do we get more blocks or less or bigger ones or smaller?
> 
> Without the change, 'bvprvp' always points to 'bv', then each bio vector
> can't be merged to other bio vector, so each bvec becomes one single
> physical segment(convert to one single sg element in driver), finally the
> transfer size for each bio becomes much smaller, and size of each
> segment becomes much smaller, but segment number may become
> bigger.

Thanks a lot, exactly the explanation I was looking for.
Tracing this function didn't show any significant difference between the
two version on the first glance, though.

I will try to catch the actual differences and take it from there.

Cheers,
Andre.

>>
>> I will try to do more experiments and to find the real culprit.
> 
> It may be helpful to enable 'block:*' trace events, and get/analyze the
> traces close to the kernel warning.
> 
>>
>> Thanks,
>> Andre.
>>
>>>
>>>>
>>>> Thanks,
>>>> Andre.
>>>>
>>>>> Thanks,
>>>>>
>>>>>> HEAD) on a Calxeda Midway (4*ARM Cortex-A15 (32-bit), 8GB RAM, SATA
>>>>>> spinning disk or SSD).
>>>>>> After some disk I/O load (kernel compile with -j6) I see the kernel
>>>>>> screaming:
>>>>>>
>>>>>> [  103.736982] ata1.00: exception Emask 0x0 SAct 0x3ffff0 SErr 0x0
>>>>>> action 0x6 frozen
>>>>>> [  103.744476] ata1.00: failed command: WRITE FPDMA QUEUED
>>>>>> [  103.749707] ata1.00: cmd 61/00:20:48:6b:41/08:00:0a:00:00/40 tag 4
>>>>>> ncq 1048576 out
>>>>>> [  103.749707]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
>>>>>> 0x4 (timeout)
>>>>>> [  103.764659] ata1.00: status: { DRDY }
>>>>>> [  103.768321] ata1.00: failed command: WRITE FPDMA QUEUED
>>>>>> [  103.773547] ata1.00: cmd 61/98:28:48:73:41/42:00:0a:00:00/40 tag 5
>>>>>> ncq 8728576 out
>>>>>> [  103.773547]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
>>>>>> 0x4 (timeout)
>>>>>> < repeated with increasing tag numbers>
>>>>>>
>>>>>> This repeats for a while, but then seems to recover later, though I
>>>>>> haven't checked if there are more issues and rebooted instead to avoid
>>>>>> filesystem damage.
>>>>>>
>>>>>> While I agree that this looks like a disk error on the first glance, I
>>>>>> never saw this before 4.4-rc2, had the very same error on different
>>>>>> nodes (with another spinning disk and even an SSD) and I can make it
>>>>>> vanish by reverting the commit I identified after bisection:
>>>>>>
>>>>>> commit 578270bfbd2803dc7b0b03fbc2ac119efbc73195
>>>>>> Author: Ming Lei <ming.lei@canonical.com>
>>>>>> Date:   Tue Nov 24 10:35:29 2015 +0800
>>>>>>
>>>>>>     block: fix segment split
>>>>>> ...
>>>>>> I understand that this fix seems sane, but actually reverting it fixes
>>>>>> the issue for me: 4.4-rc5 crashed within some minutes with the above
>>>>>> log, 4.4-rc5 with 578270bfbd reverted survived 19 hours of continuous
>>>>>> kernel compiles without issues.
>>>>>> Looking at the git history of that file I see quite some recent changes
>>>>>> there, but it's beyond my understanding of the code to spot the real
>>>>>> culprit.
>>>>>>
>>>>>> Can anyone point me to a change in blk-merge.c I could try to revert to
>>>>>> identify the real root cause? I can run tests quickly, though a real
>>>>>> positive case would need some hours of runtime to be sure it's fine.
>>>>>>
>>>>>> Many thanks!
>>>>>> Cheers,
>>>>>> Andre.
>>>>>> --
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-block" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
