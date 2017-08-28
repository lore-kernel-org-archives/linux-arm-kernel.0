From: clg@kaod.org (=?UTF-8?Q?C=c3=a9dric_Le_Goater?=)
Date: Mon, 28 Aug 2017 12:13:51 +0200
Subject: [GIT PULL] ARM: dts: aspeed: Changes for 4.14
In-Reply-To: <CAK8P3a1eQq+fkAT7jkpzHk0arCtVENJzGxk3s7aRLzU5v86xzA@mail.gmail.com>
References: <CACPK8XerZV+3RbxofpghWioYC68kK531aQQ_Jc8ZYLrjjCUqjQ@mail.gmail.com>
 <CAK8P3a1i0qJ+3Ty+QejDW5Pbyx24D9JjxrZuvhx8-1Hj2G1h1g@mail.gmail.com>
 <076266b4-175e-492f-0edf-543217efbce2@kaod.org>
 <CAK8P3a1eQq+fkAT7jkpzHk0arCtVENJzGxk3s7aRLzU5v86xzA@mail.gmail.com>
Message-ID: <b37b5e94-9eef-090e-e940-7e5aa3d4b0f7@kaod.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/24/2017 11:24 PM, Arnd Bergmann wrote:
> On Thu, Aug 24, 2017 at 5:06 PM, C?dric Le Goater <clg@kaod.org> wrote:
>> On 08/24/2017 01:13 PM, Arnd Bergmann wrote:
>>> On Thu, Aug 24, 2017 at 6:14 AM, Joel Stanley <joel@jms.id.au> wrote:
>>>> Hi Arnd and Olof,
>>>> Aspeed devicetree updates for 4.14
>>>>
>>>>  - fix to expose the full flash windows on ast2400.
>>>>
>>>
>>> Pulled into next/dt, thanks! Can you explain the CONFIG_VMSPLIT_2G
>>> requirement mentioned in the changelog here? Will it stop working with
>>> a normal multiplatform configuration that uses VMSPLIT_3G, or just
>>> have no effect?
>>
>> The kernel will still boot but, without VMSPLIT_2G, the SPI flash
>> controller driver will fail to map the memory windows of the flash
>> devices. And the system will surely lack a root filesystem.
> 
> Hmm, why does the flash controller even map the entire area?
> 
> IIRC, NOR flash controllers normally have a 'ranges' property that
> gets set up to list the available memory ranges, and the chips
> attached to them have the 'reg' property that matches the actual
> size.

Yes, that is the common scenario. 

The SMC controller of the Aspeed SoC uses a global memory window 
(defined by HW for each controller) on which the chips contents can 
be memory mapped. This is up to the software using 'segment' registers 
to organize how the mapping of each chip is done. There are some HW 
constraints on alignments, overlaps and on the values of the start and 
end addresses of each segment. For instance, the start address of the 
first segment should be equal to the start address of the global window 
and the end address of the last segment should be equal to the end address 
of the global window. 

Also, most of the backplanes (all IBMs) have sockets holding the flash 
devices, so you don't necessarily know which model and how many chips 
are available. Some boards have a couple of flash devices which can 
cover the full window, some have large ones, like the witherspoon
which uses a 128MB chip for the host firmware.

So, the driver does its best to discover the flash layout at probe time,
maps the full area and configures the segment registers accordingly. 
The start address of each segment is then used to send SPI commands 
when the controller is in I/O mode. When the controller is set to use 
memory mode, the full memory range can be used to access the flash 
contents directly.

I agree that we could probably probe the chips, configure the segment 
registers and then only map the required area. Some configurations 
would still need the whole window but there might be room for some 
improvements.
 
C.
