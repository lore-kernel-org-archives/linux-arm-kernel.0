From: bjorn@kryo.se (Bjorn Andersson)
Date: Fri, 27 Nov 2015 08:50:38 -0800
Subject: [PATCH] remoteproc: report error if resource table doesn't exist
In-Reply-To: <55E8A03B.9090608@ti.com>
References: <1440810499-24327-1-git-send-email-stefan@agner.ch>
 <55E8A03B.9090608@ti.com>
Message-ID: <CAJAp7Ogxsx2-dFazmYbvfdq82ju1Gkqsmr7HDfpV_Hctc=ddFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 3, 2015 at 12:32 PM, Suman Anna <s-anna@ti.com> wrote:
> On 08/28/2015 08:08 PM, Stefan Agner wrote:
>> Currently, if the resource table is completely missing in the
>> firmware, powering up the remoteproc fails silently. Add a message
>> indicating that the resource table is missing in the firmware.
>
> Yeah, pretty useful to have a trace there..
>
> Acked-by: Suman Anna <s-anna@ti.com>
>
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>> Hi Ohad,
>>
>> I am currently working on remoteproc support for Freescale Vybrid's
>> secondary Cortex-M4 core. I stumbled upon this rough spot since the
>> little test firmware I am using now does not have a resource table
>> yet.
>>
>> This also opens up a more general question: Is it mandatory to have
>> a resource table in the firmware? Theoretically a remoteproc could
>> also work completely independent, all what would be used from the
>> remoteproc framework is the loading and starting capabilities...

In the Qualcomm case we do not have a resource table and adding one
does not add any value. My current approach is to fake an empty table
to satisfy the framework, but I will have a look at trying to make it
optional.

>
> Hi Ohad,
>
> We will probably be seeing more of such scenarios for very simplistic
> devices (like the ones that load into their internal memories), it looks
> like the framework needs some kind of support for booting such devices,

They don't have to be simple, in the Qualcomm case we have two solutions;
1) Statically allocated memory chunks, through memory-reserve
2) Relocatable firmware, that can be loaded wherever and will fix up
its own mmu tables upon booting the remote.

Further more mode modem firmware is loaded as a two step process,
where one load and boot the boot loader (fits nicely into remoteproc)
and then one loads and feeds the actual firmware to the boot loader.
I.e. we have to load firmware in more than one step. So we need these
decisions to be more flexible.

> whether auto-boot, or give some kind of sysfs control for userspace. We
> do have the rproc_boot() and rproc_shutdown() API, but that almost
> always requires some other entity in the kernel to be able to invoke
> those API. Any suggestions here?
>

This is something we need to address.

I've been looking at adding this request to the module_init()/exit()
of the drivers that later will be communicating with the remote
firmware. E.g. the wifi driver upon loading would resolve the rproc
for the wifi/bt chip and call rproc_boot() on this upon loading.

This would solve the problem of figuring out whom should be requesting
the firmware to be loaded.

However, it would require either userspace to be fully aware of the
dependency towards remoteproc or us having a mechanism for marking a
future available remoteproc for loading - either because the
remoteproc isn't probed yet or simply because the firmware isn't
available yet.

Regards,
Bjorn
