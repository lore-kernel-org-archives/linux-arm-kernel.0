From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Mon, 13 Jun 2016 09:54:33 +0100
Subject: [PATCH v2 4/9] coresight: Fix csdev connections initialisation
In-Reply-To: <CANLsYkwGckonnLjHbOJQPZ849NQyjf+Zy=N6kjtwwo-kQbbj4Q@mail.gmail.com>
References: <1465204301-24184-1-git-send-email-suzuki.poulose@arm.com>
 <1465204301-24184-5-git-send-email-suzuki.poulose@arm.com>
 <CANLsYkwGckonnLjHbOJQPZ849NQyjf+Zy=N6kjtwwo-kQbbj4Q@mail.gmail.com>
Message-ID: <575E74C9.9010004@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/06/16 21:39, Mathieu Poirier wrote:
> On 6 June 2016 at 03:11, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>> This is a cleanup patch.
>>
>> coresight_device->conns holds an array to point to the devices
>> connected to the OUT ports of a component. Sinks, e.g ETR, do not
>> have an OUT port (nr_outport = 0), as it streams the trace to
>> memory via AXI.
>>
>> At coresight_register() we do :
>>
>>          conns = kcalloc(csdev->nr_outport, sizeof(*conns), GFP_KERNEL);
>>          if (!conns) {
>>                  ret = -ENOMEM;
>>                  goto err_kzalloc_conns;
>>          }
>>
>> For ETR, since the total size requested for kcalloc is zero, the return
>> value is, ZERO_SIZE_PTR ( != NULL). Hence, csdev->conns = ZERO_SIZE_PTR
>> which cannot be verified later to contain a valid pointer. The code which
>> accesses the csdev->conns is bounded by the csdev->nr_outport check,
>> hence we don't try to dereference the ZERO_SIZE_PTR. This patch cleans
>> up the csdev->conns and csdev->refcnt, initialisation to make sure we
>
> This patch no longer deals with csdev->refcnt.

Ok, fill fix that. Btw, do we need that check ? I am tempted to keep it there,
just to make sure we don't end up in something similar in the future.

Cheers
Suzuki
