From: frieder.schrempf@kontron.De (Schrempf Frieder)
Date: Mon, 12 Nov 2018 10:46:45 +0000
Subject: [PATCH v4 06/10] ARM: defconfig: Use the new FSL QSPI driver
 under the SPI framework
In-Reply-To: <20181108093451.08dfe63e@bbrezillon>
References: <1541601809-16950-1-git-send-email-frieder.schrempf@kontron.de>
 <1541601809-16950-7-git-send-email-frieder.schrempf@kontron.de>
 <CAOesGMgPwwwmizC+R4W1aLpvgcuVOYQr2qR2Vqb6171zGfarRw@mail.gmail.com>
 <b12936f5-871d-a982-13c5-9d894f4a1521@kontron.de>
 <20181108093451.08dfe63e@bbrezillon>
Message-ID: <b01d70ae-9feb-985a-8001-dba54206662d@kontron.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08.11.18 09:34, Boris Brezillon wrote:
> On Wed, 7 Nov 2018 16:36:13 +0000
> Schrempf Frieder <frieder.schrempf@kontron.De> wrote:
> 
>> Hi Olof,
>>
>> On 07.11.18 17:20, Olof Johansson wrote:
>>> On Wed, Nov 7, 2018 at 6:44 AM Frieder Schrempf
>>> <frieder.schrempf@kontron.de> wrote:
>>>>
>>>> From: Frieder Schrempf <frieder.schrempf@exceet.de>
>>>>
>>>> The new driver at spi/spi-fsl-qspi.c replaces the old SPI NOR driver
>>>> at mtd/fsl-quadspi.c. Switch to the new driver in the defconfigs.
>>>>
>>>> Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
>>>
>>> Hi Frieder,
>>>
>>> This patch is part of a series that I didn't see the rest of, but in
>>> general we prefer to merge these through arm-soc even if the driver
>>> goes in through another tree. The way we'd prefer to handle it is that
>>> once the driver lands, we'll take the config option change to turn it
>>> on. To avoid our branches to break until both sides have landed, it
>>> might be a good idea to keep both drivers on for a short while (one
>>> release).
>>>
>>> So, I'm not going to ack this since we avoid taking defconfig changes
>>> through driver trees (these two defconfigs tend to churn a lot and we
>>> don't want to create merge conflicts where we don't have to), but
>>> we'll be happy to pick it up when the time comes.
>>
>> Ok, thank you for explaining the common practice. I will drop the config
>> changes for the next version and send it separately when the time is ready.
>>
>> Both the old driver and the new one use the same compatible strings for
>> probing. Wouldn't that cause problems if both drivers are enabled for a
>> while, or am I missing something?
> 
> Or maybe we should not introduce a new Kconfig option and just reuse
> the old one. It probably requires re-ordering patches a bit (patch 1
> should be moved after patch 5). Then you have 2 choices:
> 
> 1/ merge patch 1 and 6 so that the new driver effectively replaces the
>     old one but uses the same Kconfig option
> 2/ remove the ability to compile the old driver when the new one is
>     introduced: remove the line from drivers/mtd/spi-nor Makefile and
>     move the Kconfig entry from drivers/mtd/spi-nor/Kconfig to
>     drivers/spi/Kconfig. And remove the old code in a separate patch
> 
> I'm fine either way, but option #2 will probably make the patch
> introducing the new driver bigger and hurt readability.

I think having both drivers in the tree for a while wouldn't be so bad. 
So if any compatibility issues come up with the new driver, people can 
still use the old one.

Therefore I think I will drop the patches that change the defconfig and 
remove the old driver code and keep the different Kconfig options. And 
maybe add an exclusive dependency in Kconfig, so both drivers can not be 
enabled at the same time.

Does this make sense?
