From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 24 Feb 2014 10:07:17 +0100
Subject: [PATCH 04/11] ARM: shmobile: lager legacy: Add MSIOF support
In-Reply-To: <CANqRtoQ9ZuAhqmaKU5NLsJBNc0iN7uNdQMS6uCrp0enkFUzrqQ@mail.gmail.com>
References: <1392907779-22053-1-git-send-email-geert@linux-m68k.org>
 <1392907779-22053-5-git-send-email-geert@linux-m68k.org>
 <CANqRtoQQ9cn55Ct7pva2Bo7461WbZG0=Y5f9zLwfKhyU2=QFZw@mail.gmail.com>
 <CAMuHMdWMJFpV_uvi4mNZYc9R8qVWqQf3QGRhdPyc+hj=6XMoJw@mail.gmail.com>
 <CANqRtoRLcac3x55N+VHK+n6RvcgT0v9==9mt1rhVda-zwCYTCg@mail.gmail.com>
 <CAMuHMdWDtDqmarg-p+LFv4ZtzF7Rv=KzLQA3rnSa_dS2PkVmfA@mail.gmail.com>
 <CANqRtoQ9ZuAhqmaKU5NLsJBNc0iN7uNdQMS6uCrp0enkFUzrqQ@mail.gmail.com>
Message-ID: <CAMuHMdXZx+J8=MDni+QzqiXCO61ThBQAdCxETm9p74nkc0f+hw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus,

On Mon, Feb 24, 2014 at 9:44 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>>> Another question: How about "bus_num" and the platform device id
>>> mapping? I'd like them to be the same if possible, but you are having
>>> this "(idx+1)" bit in your code which I assume is to add offset for
>>> the QSPI bus.
>>
>> "bus_num" is the SPI-specific numbering of SPI masters, which is filled
>> in by spi-sh-msiof.c based on platform_device.id (i.e. the numeric suffix
>> of e.g. "spi_r8a7790_msiof.1").
>> It's used for matching SPI slaves in spi_board_info with SPI masters.
>> As QSPI ("qspi.0") has SPI bus_num 0, the MSIOF SPI masters use
>> bus_num 1 to 4, hence the "idx+1", and the platform device names
>> "spi_r8a7790_msiof.1" to "spi_r8a7790_msiof.4".
>>
>> (Can't spi-sh-msiof.c use "bus_num = pdev->id + 1", so we can have
>>  MSIOF0 as "spi_r8a7790_msiof.0"? No, as that would impact numbering
>>  on all SoCs with MSIOF.)
>
> Yeah, the bus number that is commonly used for SPI and I2C behaves
> like that so I agree with what you're saying. I guess historically we
> usually only have one I2C master and one SPI master which makes it
> easy to use direct mapping between bus num and pdev->id.
>
> Now on Lager we have multiple SPI masters (both QSPI and MSIOF unless
> I'm mistaken), so the question is how to allocate the ranges of
> bus_num for each SPI master. I believe your current allocation works
> well but I'm a bit confused by it I must confess.
>
> I'm used to one of the two schemes:
> 1) single master with pdev->id equals bus_num
> 2) compact board specific bus allocation
>
> I believe you introduce something similar to 1) but for two SPI
> masters which is totally fine! For some unknown reason I expected 2)
> with bus_num 0 for QSPI and bus_num 1 for MSIOF1, but I think your
> allocation scheme is reusable across multiple boards with the same SoC
> so I think your current code is better when I think about it a bit
> more.

On our specific boards, we now have a sparse SPI bus numbering,
but that's just because some MSIOF channels are not used. On other
boards with the same SoC that may be different.

> Right. I was just confused seeing the pdev->id set to 2 on MSIOF1, but
> I now understand that it is your intentional design to have bus_num 0
> as QSPI, bus_num1 as unused MSIOF0 and bus_num 2 as MSIOF1.

Actually that's too much credit for me: the bus numbering came from the
BSP through Yoshii-san.

> It just takes some time for me to grasp. =)

Yes, we're too used to having one single type of each hardware type :-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
