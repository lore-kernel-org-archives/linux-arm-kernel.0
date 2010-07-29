From: vitalywool@gmail.com (Vitaly Wool)
Date: Thu, 29 Jul 2010 18:16:19 +0200
Subject: [PATCH v2 03/20] mmc: support embedded data field in mmc_host
In-Reply-To: <AANLkTi=Oy8X1xMOwWL_cKBB1LWULT6=p+adUgB+AuSJS@mail.gmail.com>
References: <1279733634-21974-1-git-send-email-ohad@wizery.com>
	<1279733634-21974-4-git-send-email-ohad@wizery.com>
	<AANLkTimzA_JJ-byTDWznbL3YzeJ8LAP4M50onf2_3fBF@mail.gmail.com>
	<AANLkTi=Oy8X1xMOwWL_cKBB1LWULT6=p+adUgB+AuSJS@mail.gmail.com>
Message-ID: <AANLkTi=BUX59heXAW2Uf4wZo2dSS19Je54dkQ5u2YGAW@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ohad,

On Thu, Jul 29, 2010 at 8:00 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
>> To my understanding, this data doesn't belong to mmc_host. It's not a
>> host data at all. E. g. imagine a GPIO IRQ for some SDIO chip -- it's
>> totally unrelated to host.
>>
>> I think a cleaner way would be to introduce something similar to what
>> we have for SPI, e. g. struct sdio_board_info. This board info will
>> contain platform-specific stuff and vendor id/chip id for each onboard
>> SDIO device. Then the SDIO core will pick up the appropriate data
>> basing on vendor id/chip id.
>
> Can you please elaborate some more about your proposal (specifically
> where does this sdio_board_info get set and how do function drivers
> access it) ?
>
> If I understand you correctly, you suggest to have a global,
> board-specific table of sdio_board_info structures, which would be
> accessible to the SDIO core (through the host driver ?). When a new
> SDIO device is found the core would search this table for the
> appropriate sdio_board_info struct and make it accessible to the SDIO
> function driver ?

Well, let's look at how it's implemented for SPI. There is the
function spi_register_board_info in the SPI core which copies the
board info into the local data structure (a linked list, actually).
Whenever needed, the core walks through the list to find the
appropriate board_info basing on some search key.

I think this may be the way to go for SDIO as well.

~Vitaly
