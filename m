From: s-anna@ti.com (Suman Anna)
Date: Tue, 29 Jul 2014 14:33:07 -0500
Subject: [PATCH 2/2] remoteproc: add support to handle internal memories
In-Reply-To: <CAK=WgbY-WmcJdnLHDf1CSkJqNBUeUMPTLcEZyLGKnECbxH1OAQ@mail.gmail.com>
References: <1404836521-59637-1-git-send-email-s-anna@ti.com>
 <1404836521-59637-3-git-send-email-s-anna@ti.com>
 <CAK=WgbY-WmcJdnLHDf1CSkJqNBUeUMPTLcEZyLGKnECbxH1OAQ@mail.gmail.com>
Message-ID: <53D7F6F3.9020804@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ohad,

On 07/29/2014 06:00 AM, Ohad Ben-Cohen wrote:
> Hi Suman,
> 
> On Tue, Jul 8, 2014 at 7:22 PM, Suman Anna <s-anna@ti.com> wrote:
>> A remote processor may need to load certain firmware sections into
>> internal memories (eg: RAM at L1 or L2 levels) for performance or
>> other reasons.
> 
> Can you please provide as much details as you can about the scenario
> you need this for? what hardware, what sections, which specific
> memory, what's the use case, numbers, sizes, everything.
> 
> I'd like to better understand the use case please.

We currently have two usecases. The primary usecase is the WkupM3
processor on TI Sitara AM335x/AM437x SoCs used for suspend/resume
management. This series is a dependency for the WkupM3 remoteproc driver
that Dave posted [1]. More details are in section 8.1.4.6 of the AM335x
TRM [2]. The program/data sections for this processor all _needs_ to be
in the two internal memory RAMS (16K Unified RAM and 8K Data RAM), and
there is no MMU for this processor. The current RSC_CARVEOUT and
RSC_DEVMEM do not fit to describe this type of memory (we neither
allocate memory through dma api nor do we need to map these into an MMU).

The second usecase is for some code to be loaded into the internal
memories of the DSP in existing OMAPs directly during remoteproc loading
stage. These memories are accessible to the processor again without
having to go through the L2MMU through which the external RAM and
peripherals are accessed through.

regards
Suman

[1] https://patchwork.kernel.org/patch/4529651/
[2] www.ti.com/lit.ug/spruh73k/spruh73k.pdf
