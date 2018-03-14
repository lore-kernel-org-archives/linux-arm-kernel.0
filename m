From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Wed, 14 Mar 2018 09:42:26 +0000
Subject: [PATCH 0/2] Introduce STM32MP1 Reset driver
In-Reply-To: <1521018722.4490.1.camel@pengutronix.de>
References: <1520958859-27911-1-git-send-email-gabriel.fernandez@st.com>
 <1521018722.4490.1.camel@pengutronix.de>
Message-ID: <12ba9cee-f703-8fc7-75da-de213f5c8aa2@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

Okay, i too support the idea to add custom? reset driver.

Many Thanks Philipp.

Best regards

Gabriel


On 03/14/2018 10:12 AM, Philipp Zabel wrote:
> Hi Gabriel,
>
> On Tue, 2018-03-13 at 17:34 +0100, gabriel.fernandez at st.com wrote:
>> From: Gabriel Fernandez <gabriel.fernandez@st.com>
>>
>> This patch-set enables the reset of STM32MP1.
>> It uses the reset simple driver by introducing the clear register offset
>> parameter.
>> STM32MP1 reset IP has a register to assert by writing '1' and another
>> register to de-assert by writing '1'.
>> The offset between this two registers is '0x4'.
> I worry a bit about feature creep in the simple-reset driver.
> Your patch on its own is simple enough, and I'm not opposed to add a
> SET/CLR feature on principle, but there are a few issues:
>
> The RESET_SIMPLE Kconfig description currently says:
>  ??"This enables a simple reset controller driver for reset lines that
>  ???that can be asserted and deasserted by toggling bits in a contiguous,
>  ???exclusive register space."
> That would have to be extended to mention SET/CLR register pairs as an
> alternative.
>
> What about status (reset_simple_status)? Can current reset line status
> be read back from the SET register, as is currently tried? If not, is
> there a way to read current reset line status back at all?
>
> The data->lock spinlock is only needed to protect the read-modify-write
> cycle on a toggle register, for separate SET/CLR register access the
> locking is not necessary.
>
> At this point, it may or may not be easier to add a custom reset driver.
> Either way you go, this is missing binding documentation for the
> st,stm32mp1-rcc compatible in Documentation/devicetree/bindings/reset.
>
>> The patch 'dt-bindings: reset: add STM32MP1 resets' could be squashed
>> with the patch:
>> 'dt-bindings: Document STM32MP1 Reset Clock Controller (RCC) bindings'
>> commit 3830681d354f
>>
>> Gabriel Fernandez (2):
>>    dt-bindings: reset: add STM32MP1 resets
>>    reset: simple: Enable stm32mp1 reset driver
>>
>>   drivers/reset/reset-simple.c                |  27 +++++--
>>   drivers/reset/reset-simple.h                |   1 +
>>   include/dt-bindings/reset/stm32mp1-resets.h | 108 ++++++++++++++++++++++++++++
>>   3 files changed, 130 insertions(+), 6 deletions(-)
>>   create mode 100644 include/dt-bindings/reset/stm32mp1-resets.h
> regards
> Philipp
