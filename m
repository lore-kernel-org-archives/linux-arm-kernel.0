From: drinkcat@chromium.org (Nicolas Boichat)
Date: Wed, 5 Aug 2015 18:24:05 +0800
Subject: [PATCH 1/3] spi: bitbang: Replace spinlock by mutex when calling
 chipselect
In-Reply-To: <20150804105957.GI20873@sirena.org.uk>
References: <1438668598-6678-1-git-send-email-drinkcat@chromium.org>
 <20150804105957.GI20873@sirena.org.uk>
Message-ID: <CANMq1KB2zxPPCbxh4K-REUgp-83s=MPcGRjz-p1fK1PQMzyLdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 4, 2015 at 6:59 PM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Aug 04, 2015 at 02:09:56PM +0800, Nicolas Boichat wrote:
[snip]
>> Actually, I'm not sure if I understand the existing code: why are we not
>> waiting for busy to go down to 0, then call chipselect, instead of not calling
>> it at all if the bus happens to be busy when we setup the device? With the
>> current approach, it would be easy to just use an unconditional mutex_lock.
>
> We shouldn't be blocking waiting for the bus to become free, that's not
> how the interface works.

Noted.

>> Also, is it harmful to deactivate the newly setup device in spi_bitbang_setup,
>> even if the bus is busy with another device? chipselect should be independent
>> for each device (or is it not?). So I'm not clear why we need any locking at
>> all...
>
> If you assert chip select on one device while another device is still
> being interacted with then the new device will see the traffic for the
> old device and become confused.

Here in spi_bitbang_setup, we do:
bitbang->chipselect(spi, BITBANG_CS_INACTIVE);
That is, we make sure that the current device is _not_ selected.

Looking a bit more into this, the issue here is that some drivers use
chipselect to chip select individual devices separately, while, on
others, the above command unselects all devices (which is a bad idea
if the bus is currently transferring data...). So, in short, it's
probably better not to touch this code.

>> Anyway, this patch series does not change the existing behaviour, applies on
>> top of broonie-sound/for-next, and, along with the 2 follow-up patches, was
>> compile-tested on x86-64/arm (allyesconfig) and ppc44x (defconfig+SPI driver),
>> and runtime-tested on an arm platform.
>
> I'm not seeing enough analysis in the commit log of what's being locked
> and why - I don't fully understand what the busy stuff is for either
> (not that I've looked at the code in detail just now) but I think that's
> going to be the key thing here.

Regarding deleting prepare/unprepare and moving the lock into transfer_one.

spi.c:__spi_pump_messages, which calls these functions, does the following:
 - If no more messages need to be sent, call unprepare_transfer_hardware
 - If messages need to be sent:
   + call prepare_transfer_hardware
   + call prepare_message (NULL for bitbang)
   + call transfer_one_message

I don't think it makes a big difference if we set busy (or hold a
mutex) in prepare/unprepare, or we just do it in transfer_one_message,
since chipselect is only set in transfer_one_message, and is
deselected at the end of the function anyway (in most cases, and if
it's not, it will be selected again at the next transfer anyway).

Anyway, the "safer" way to fix this would be to keep the
prepare/unprepare functions, busy variable, and just protect it with a
mutex instead of a spinlock...

Thanks.

Best,
