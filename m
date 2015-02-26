From: robh@kernel.org (Rob Herring)
Date: Thu, 26 Feb 2015 09:43:26 -0600
Subject: [PATCH v3] drivers/tty: amba: defer probing DMA availability
 until hw_init
In-Reply-To: <54EF3889.40008@linaro.org>
References: <1424910661-26474-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <CAL_JsqJvFsMesJqNi+Kwg_Xnu7oanyEzrFfk+w9msQ_XOiBGPQ@mail.gmail.com>
 <54EF3889.40008@linaro.org>
Message-ID: <CAL_JsqJ8M-HcTo6ydkXUT2BVLG_2-qx_ZKEa+QcwG-QMusJhhA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 26, 2015 at 9:15 AM, Jorge Ramirez-Ortiz
<jorge.ramirez-ortiz@linaro.org> wrote:
> On 02/26/2015 09:12 AM, Rob Herring wrote:
>> On Wed, Feb 25, 2015 at 6:31 PM, Jorge Ramirez-Ortiz
>> <jorge.ramirez-ortiz@linaro.org> wrote:
>>> Fix a race condition that happens when device_initcall(pl011_dma_initicall)
>>> is executed before all the devices have been probed - this issue was observed on
>>> an hisi_6220 SoC (HiKey board from Linaro).
>>>
>>> The deferred driver probing framework relies on late_initcall to trigger
>>> deferred probes so it is just possible that, even with a valid DMA driver ready
>>> to be loaded, we fail to synchronize with it.
>>>
>>> The proposed implementation delays probing of the DMA until the uart device is
>>> opened. As hw_init is invoked on port startup and port resume - but the DMA
>>> probe is only required once - we avoid calling multiple times using a new field
>>> in uart_amba_port to track this scenario.
>>>
>>> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
>>> ---
>>>  drivers/tty/serial/amba-pl011.c | 66 ++++++++++-------------------------------
>>>  1 file changed, 16 insertions(+), 50 deletions(-)
>>>
>>> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
>>> index 8d94c19..3501ccc 100644
>>> --- a/drivers/tty/serial/amba-pl011.c
>>> +++ b/drivers/tty/serial/amba-pl011.c
>>> @@ -29,6 +29,7 @@
>>>   * and hooked into this driver.
>>>   */
>>>
>>> +#define pr_fmt(fmt) "amba-pl011: "fmt
>> You can drop this I think.
>
> why not keep it? it makes the trace more readable (if debug is enabled only)

There's only 1 call and it should be converted to dev_ variant
instead. It is also unrelated to this patch.

Rob
