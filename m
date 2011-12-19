From: akong@redhat.com (Amos Kong)
Date: Mon, 19 Dec 2011 10:50:13 +0800
Subject: [RFC] virtio: use mandatory barriers for remote processor vdevs
In-Reply-To: <4EEE9F16.8000501@redhat.com>
References: <1322569886-13055-1-git-send-email-ohad@wizery.com>
 <1322867384.11728.20.camel@pasglop> <87hb1iqls3.fsf@rustcorp.com.au>
 <20111211122544.GC11504@redhat.com> <1323642447.19891.8.camel@pasglop>
 <4EE56FCD.9030609@redhat.com> <87wra2tlue.fsf@rustcorp.com.au>
 <4EEE9F16.8000501@redhat.com>
Message-ID: <4EEEA665.3030808@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/12/11 10:19, Amos Kong wrote:
> On 12/12/11 13:12, Rusty Russell wrote:
>> On Mon, 12 Dec 2011 11:06:53 +0800, Amos Kong<akong@redhat.com> wrote:
>>> On 12/12/11 06:27, Benjamin Herrenschmidt wrote:
>>>> On Sun, 2011-12-11 at 14:25 +0200, Michael S. Tsirkin wrote:
>>>>
>>>>> Forwarding some results by Amos, who run multiple netperf streams in
>>>>> parallel, from an external box to the guest. TCP_STREAM results were
>>>>> noisy. This could be due to buffering done by TCP, where packet size
>>>>> varies even as message size is constant.
>>>>>
>>>>> TCP_RR results were consistent. In this benchmark, after switching
>>>>> to mandatory barriers, CPU utilization increased by up to 35% while
>>>>> throughput went down by up to 14%. the normalized throughput/cpu
>>>>> regressed consistently, between 7 and 35%
>>>>>
>>>>> The "fix" applied was simply this:
>>>>
>>>> What machine& processor was this ?
>>>
>>> pined guest memory to numa node 1
>>
>> Please try this patch. How much does the branch cost us?
>>
>> (Compiles, untested).
>>
>> Thanks,
>> Rusty.
>>
>> From: Rusty Russell<rusty@rustcorp.com.au>
>> Subject: virtio: harsher barriers for virtio-mmio.
>>
>> We were cheating with our barriers; using the smp ones rather than the
>> real device ones. That was fine, until virtio-mmio came along, which
>> could be talking to a real device (a non-SMP CPU).
>>
>> Unfortunately, just putting back the real barriers (reverting
>> d57ed95d) causes a performance regression on virtio-pci. In
>> particular, Amos reports netbench's TCP_RR over virtio_net CPU
>> utilization increased up to 35% while throughput went down by up to
>> 14%.
>>
>> By comparison, this branch costs us???
>>
>> Reference: https://lkml.org/lkml/2011/12/11/22
>>
>> Signed-off-by: Rusty Russell<rusty@rustcorp.com.au>
>> ---
>> drivers/lguest/lguest_device.c | 10 ++++++----
>> drivers/s390/kvm/kvm_virtio.c | 2 +-
>> drivers/virtio/virtio_mmio.c | 7 ++++---
>> drivers/virtio/virtio_pci.c | 4 ++--
>> drivers/virtio/virtio_ring.c | 34 +++++++++++++++++++++-------------
>> include/linux/virtio_ring.h | 1 +
>> tools/virtio/linux/virtio.h | 1 +
>> tools/virtio/virtio_test.c | 3 ++-
>> 8 files changed, 38 insertions(+), 24 deletions(-)
>
> Hi all,
>
> I tested with the same environment and scenarios.
> tested one scenarios for three times and compute the average for more
> precision.
>
> Thanks, Amos
>
> --------- compare results -----------
> Mon Dec 19 09:51:09 2011
>
> 1 - avg-old.netperf.exhost_guest.txt
> 2 - avg-fixed.netperf.exhost_guest.txt
>
> ======
> TCP_STREAM
> sessions| size|throughput| cpu| normalize| #tx-pkts| #rx-pkts| #tx-byts|
> #rx-byts| #re-trans| #tx-intr| #rx-intr| #io_exit| #irq_inj|#tpkt/#exit|
> #rpkt/#irq
> 1 1| 64| 1073.54| 10.50| 102| 0| 31| 0| 1612| 0| 16| 487641| 489753|
> 504764| 0.00| 0.00
> 2 1| 64| 1079.44| 10.29| 104| 0| 30| 0| 1594| 0| 17| 487156| 488828|
> 504411| 0.00| 0.00
> % | 0.0| +0.5| -2.0| +2.0| 0| -3.2| 0| -1.1| 0| +6.2| -0.1| -0.2| -0.1|

The format is broken in webpage, attached the result file.
it's also available here: http://amosk.info/download/rusty-fix-perf.txt
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: rusty-fix-perf.txt
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111219/5da85248/attachment-0001.txt>
