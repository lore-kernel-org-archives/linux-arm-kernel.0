From: maggie.mae.roxas@gmail.com (Maggie Mae Roxas)
Date: Mon, 1 Dec 2014 16:27:46 +0800
Subject: Issue found in Armada 370: "No buffer space available" error
 during continuous ping
In-Reply-To: <20141201072802.GB21731@1wt.eu>
References: <20140717081527.GJ14723@1wt.eu>
 <CAB8gEUsLmuDkTzGsq8fVs9dZ90d82Brw2cAPBOnobUTcSgQabA@mail.gmail.com>
 <CAB8gEUvwPJUhDN-=tugTyKe93SdNwqNaGtKMF1DRCb8ZNncmmg@mail.gmail.com>
 <20140721054405.GK21834@1wt.eu>
 <CAB8gEUsK9c3YMpAABifNAWU7zec2ePztSqS4KAYtiT7Sbhadvg@mail.gmail.com>
 <20140721070303.GM21834@1wt.eu>
 <CAB8gEUtmgwfWcuoYZ-wDwHVmzHN0WyOQD9oEOGAZ_gJfbPUm-g@mail.gmail.com>
 <20140723061659.GE30488@1wt.eu>
 <CAB8gEUtO=K-mjie6czsf-9ao1cxiMAV2ScbgUnf+XxqjEfOUvg@mail.gmail.com>
 <CAB8gEUtgo-8nets3tRtqiZ8qRx+SyCq2d8v05scavWNwE5TNXg@mail.gmail.com>
 <20141201072802.GB21731@1wt.eu>
Message-ID: <CAB8gEUsQ8nSNwB7vpZHBkELEBX2sN1QdWvujBGYQJY9dtCzgww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Willy,
Good day.

Thank you for the quick feedback.

> In the mean time you can apply the attached patch. I haven't submitted it yet only by lack of time :-(
Should we apply this patch on:
1. 3.13.9? or
2. 3.13.9 with cd71e246c16b30e3f396a85943d5f596202737ba and reverted
4f3a4f701b59a3e4b5c8503ac3d905c0a326f922?

This patch is expected resolve the low throughput and the kernel crash as well?
# Not just the "No buffer space available" error?

Thank you.

Regards,
Maggie Roxas

On Mon, Dec 1, 2014 at 3:28 PM, Willy Tarreau <w@1wt.eu> wrote:
> Hi Maggie,
>
> On Mon, Dec 01, 2014 at 02:26:49PM +0800, Maggie Mae Roxas wrote:
>> Hi Willy, Thomas.
>> Good day.
>>
>> I am reopening this discussion because we found an unusual behavior
>> after using this combination that we thought was OK as discussed in
>> the previous messages of this thread:
>>
>> > - use 3.13.9 mvneta.c
>> > - apply cd71e246c16b30e3f396a85943d5f596202737ba
>> > - revert 4f3a4f701b59a3e4b5c8503ac3d905c0a326f922
>>
>> Specifically, if we apply above, the "No buffer space available" error
>> during continuous ping does NOT occur anymore.
>> # Attached: with_patch_3_13_9_no_buffer_space_solved.txt
>>
>> However, after continuous and further testing, we encounter the ff. issues:
>> 1. Low throughput during iperf when Armada 370 device is set as iperf
>> client. For example, in 1000Mbits/s, we only get below 140Mbits/s.
>
> Yes that was the intent of the original fix.
>
> We recently diagnosed the issue related to "no buffer space available".
> What happens is that the "ping" utility uses a very small socket buffer.
> It sends a few packets, and the NIC doesn't send interrupts until the
> TX interrupt count is reached, so the Tx skbs are not freed and the
> socket buffers remain full.
>
> The only solution at the moment is to make the NIC emit an IRQ for each
> Tx packet. I'm still trying to find a better way to do this (either find
> a way to make the NIC emit an IRQ once the Tx queue is empty or adjust
> the IRQ delay when adding more packets, though it creates a race condition).
>
> In the mean time you can apply the attached patch. I haven't submitted it
> yet only by lack of time :-(
>
> Best regards,
> Willy
>
