From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Apr 2018 23:05:35 +0200
Subject: ioremap() use with specific mailbox drivers and SCMI
In-Reply-To: <9d9a2894-3f9f-8a7b-d53f-36f3c8e91aa6@arm.com>
References: <be5f7ed4-4b2c-2a6a-0a41-19e30172a048@gmail.com>
 <c51e5750-eabd-6728-0a2c-8b1146ca5fab@gmail.com>
 <9d9a2894-3f9f-8a7b-d53f-36f3c8e91aa6@arm.com>
Message-ID: <CAK8P3a08jN_KF0SY2Vvi2V_f26_s44ReCB4vh1sdfz1-tgXjBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 19, 2018 at 7:09 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> On 19/04/18 17:35, Florian Fainelli wrote:
>
>>> Using a reserved-memory entry would be far less error prone, would
>>> clearly show the intents of the specific regions being declared, and
>>> could, through the use of additional properties (e.g: "map", as opposed
>>> to "no-map") indicate a possible need to map that DRAM region into
>>> kernel virtual memory and using e.g: memremap() APIs.
>>>
>
> Sorry for missing this. For some reasons, I had assumed memremap was
> specifically for DRAM and when I wrote the driver, I was testing on
> our internal Juno dev platform which has dedicated SRAM for the
> communication with remote control processor. However having a quick look
> at the API, I see no reasons to not use that as it takes care of using
> ioremap if required. But I am wondering why the generic SRAM driver in
> drivers/misc/sram.c uses ioremap.
>
>>> Also the semantics of ioremap() are not particularly portable from one
>>> architecture to another whereas memremap() is IMHO.
>>>
>
> Again, wasn't aware of that.
>
> Arnd,
>
> Do you see any issues moving from ioremap to memremap for SCMI ?
> I am asking you as you would have seen various platforms having multiple
> options for shared IPC memory and wanted to get you feedback.

Good question. The important point here is that whatever way the
kernel maps the buffer must match whatever the other end does:

- If you have regular RAM that is accessed using the CPU cache from
  firmware running on the same CPU, or using a cache-coherent method
  from a remote processor, you need to use memremap().

- If you have device registers somewhere, you must use ioremap()
  or possibly ioremap_wc().

- A dedicated SRAM is a bit tricky, usually that kind of buffer is accessed
  without going through the cache, so memremap() would be wrong.
  ioremap() is probably safe here.

- The last case would get you into real trouble: a memory buffer at
  a fixed location that is physicall in system RAM and excluded from
  the memory visible to the OS, but accessed from a remote processor
  that is not cache-coherent with your CPU caches. Here, you can't
  use memremap() since you want an uncached mapping, but ioremap()
  is probably also wrong. You could construct something using
  dma_map_single() that might work, but that's not what this API is
  meant for either.

          Arnd
