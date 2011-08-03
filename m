From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 3 Aug 2011 11:09:23 +0100
Subject: [PATCH 2/4] serial: s5pv210: Add device tree support
In-Reply-To: <20110803091249.GB28651@trinity.fluff.org>
References: <1312326509-2723-1-git-send-email-thomas.abraham@linaro.org>
	<1312326509-2723-3-git-send-email-thomas.abraham@linaro.org>
	<20110803091249.GB28651@trinity.fluff.org>
Message-ID: <CAJuYYwSg8XcdRqD1VHzsL4oGtJkCdhAM9mpSX_jQnGr0BKz2PQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,

On 3 August 2011 10:12, Ben Dooks <ben-linux@fluff.org> wrote:
> On Wed, Aug 03, 2011 at 12:08:27AM +0100, Thomas Abraham wrote:
>> For device tree based probe, the dependecy on pdev->id to attach a
>> corresponding default port info to the driver's private data is
>> removed. The fifosize parameter is obtained from the device tree
>> node and the next available instance of port info is updated
>> with the fifosize value and attached to the driver's private data.
>> The default platform data is selected based on the compatible property.
>>
>> CC: Ben Dooks <ben-linux@fluff.org>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> ---
>> ?.../devicetree/bindings/serial/samsung_uart.txt ? ?| ? 16 +++++++
>> ?drivers/tty/serial/s5pv210.c ? ? ? ? ? ? ? ? ? ? ? | ? 43 +++++++++++++++++++-
>> ?drivers/tty/serial/samsung.c ? ? ? ? ? ? ? ? ? ? ? | ? ?5 ++-
>> ?3 files changed, 62 insertions(+), 2 deletions(-)
>> ?create mode 100644 Documentation/devicetree/bindings/serial/samsung_uart.txt

[...]

>>
>> +
>> + ? ? if (pdev->dev.of_node) {
>> + ? ? ? ? ? ? if (of_property_read_u32(pdev->dev.of_node,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? "samsung,uart-fifosize",
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? &s5p_uart_inf[probe_index]->fifosize))
>> + ? ? ? ? ? ? ? ? ? ? return -EINVAL;
>
> I'd rather see the fifo size either being a property of the soc itself
> or being inferred by the compatible field.

Ok. I missed that. I will make it part of the SoC data.

>
>> ? ? ? .driver ? ? ? ? = {
>> ? ? ? ? ? ? ? .name ? = "s5pv210-uart",
>> ? ? ? ? ? ? ? .owner ?= THIS_MODULE,
>> + ? ? ? ? ? ? .of_match_table = s5pv210_uart_dt_match,
>
> I think maybe doing something like
>
> ? ? ? ? ? ? ? ?.of_match_table = of_match_ptr(5pv210_uart_dt_match),
>
> so we can avoid having the #else and #define 5pv210_uart_dt_match NULL
> in a number of places.

Ok. I will change it.

Thanks,
Thomas.

>
>> ? ? ? },
>> ?};
>
> --
> Ben Dooks, ben at fluff.org, http://www.fluff.org/ben/
>
> Large Hadron Colada: A large Pina Colada that makes the universe disappear.
>
>
