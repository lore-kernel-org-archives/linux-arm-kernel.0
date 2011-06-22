From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 22 Jun 2011 13:46:37 +0300
Subject: [RFC 7/8] drivers: introduce rpmsg,
	a remote-processor messaging bus
In-Reply-To: <87liwu8u3q.fsf@rustcorp.com.au>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com>
	<1308640714-17961-8-git-send-email-ohad@wizery.com>
	<87liwu8u3q.fsf@rustcorp.com.au>
Message-ID: <BANLkTi=7TBMqnEf2qustrmSaubtTam79Bw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 22, 2011 at 5:42 AM, Rusty Russell <rusty@rustcorp.com.au> wrote:
> On Tue, 21 Jun 2011 10:18:33 +0300, Ohad Ben-Cohen <ohad@wizery.com> wrote:
>> Add a virtio-based IPC bus, which enables kernel users to communicate
>> with remote processors over shared memory using a simple messaging
>> protocol.
>
> Wow, sometimes one writes a standard and people use it. ?Thanks!

And we really liked it: virtio_rpmsg_bus.c, the virtio driver which
does most of the magic here ended up pretty small thanks to virtio.
and the performance numbers are really good, too.

>> + ? ? /* Platform must supply pre-allocated uncached buffers for now */
>> + ? ? vdev->config->get(vdev, VPROC_BUF_ADDR, &addr, sizeof(addr));
>> + ? ? vdev->config->get(vdev, VPROC_BUF_NUM, &num_bufs, sizeof(num_bufs));
>> + ? ? vdev->config->get(vdev, VPROC_BUF_SZ, &buf_size, sizeof(buf_size));
>> + ? ? vdev->config->get(vdev, VPROC_BUF_PADDR, &vrp->phys_base,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? sizeof(vrp->phys_base));
>
> The normal way is to think of the config space as a structure, and use
> offsets rather than using an enum value to distinguish the fields.

Yes, I was (mis-)using the config space for now to talk with
platform-specific code (on the host), and not with the peer, so I
opted for simplicity.

But this is definitely one thing that is going away: I don't see any
reason why not just use dma_alloc_coherent (or even dma_pool_create)
directly from the driver here in order to get those buffers.

>> +#define RPMSG_NAME_SIZE ? ? ? ? ? ? ? ? ? ? ?32
>> +#define RPMSG_DEVICE_MODALIAS_FMT ? ?"rpmsg:%s"
>> +
>> +struct rpmsg_device_id {
>> + ? ? char name[RPMSG_NAME_SIZE];
>> + ? ? kernel_ulong_t driver_data ? ? ?/* Data private to the driver */
>> + ? ? ? ? ? ? ? ? ? ? __attribute__((aligned(sizeof(kernel_ulong_t))));
>> +};
>
> This alignment directive seems overkill...

Yes, looks like I can remove this. thanks.

>> +#define VIRTIO_ID_RPMSG ? ? ? ? ? ? ?10 /* virtio remote processor messaging */
>
> I think you want 6. ?Plan 9 jumped ahead to grab 9 :)

6 it is :)

Thanks,
Ohad.
