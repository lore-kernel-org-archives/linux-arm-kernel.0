From: jiri.prchal@aksignal.cz (=?UTF-8?B?SmnFmcOtIFByY2hhbA==?=)
Date: Tue, 11 Mar 2014 10:45:58 +0100
Subject: [BUG] atmel: spi: scheduling while atomic
In-Reply-To: <B256D81BAE5131468A838E5D7A24364172FF9685@penmbx01>
References: <5315E33C.5000205@aksignal.cz> <20140304214039.GA4441@piout.net>
 <5316CA84.4080907@aksignal.cz> <20140307225810.GB2918@piout.net>
 <CAH+eYFCT-VSP0Ej8jOYVGNgf=ONUjcFs1M8O0HOGNRNX23SW6A@mail.gmail.com>
 <531D73CB.7040402@aksignal.cz>
 <B256D81BAE5131468A838E5D7A24364172FF9685@penmbx01>
Message-ID: <531EDB56.20008@aksignal.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
patch applied, it helps.
Is this final solution?
Thanks

Dne 10.3.2014 10:08, Yang, Wenyou napsal(a):
>
>
>> -----Original Message-----
>> From: Ji?? Prchal [mailto:jiri.prchal at aksignal.cz]
>> Sent: Monday, March 10, 2014 4:12 PM
>> To: Rabin Vincent; Alexandre Belloni; Yang, Wenyou
>> Cc: Ferre, Nicolas; linux-arm-kernel at lists.infradead.org;
>> sboyd at codeaurora.org
>> Subject: Re: [BUG] atmel: spi: scheduling while atomic
>>
>> Hi all,
>> at first: warning is on all spi devices.
>> at second: its with CONFIG_PREEMPT=y, without (# CONFIG_PREEMPT_RCU is
>> not set) is OK, but I wonder if this config will be fast enough for our
>> usage (nearly RT)?
>>
>>
>> Dne 8.3.2014 01:41, Rabin Vincent napsal(a):
>>> 2014-03-07 23:58 GMT+01:00 Alexandre Belloni
>>> <alexandre.belloni@free-electrons.com>:
>>>> On 05/03/2014 at 07:56:04 +0100, Ji?? Prchal wrote :
>>>>> [    0.902343] BUG: scheduling while atomic: spi0/383/0x00000002
>>>>> [    0.906250] Modules linked in:
>>>>> [    0.906250] CPU: 0 PID: 383 Comm: spi0 Not tainted 3.14.0-
>> rc4_cpm9g25+ #1
>>>>> [    0.906250] [<c000d9f4>] (unwind_backtrace) from [<c000bdc0>]
>> (show_stack+0x10/0x14)
>>>>> [    0.906250] [<c000bdc0>] (show_stack) from [<c003a224>]
>> (__schedule_bug+0x48/0x60)
>>>>> [    0.906250] [<c003a224>] (__schedule_bug) from [<c0390294>]
>> (__schedule+0x60/0x484)
>>>>> [    0.906250] [<c0390294>] (__schedule) from [<c038feac>]
>> (schedule_timeout+0x17c/0x1ac)
>>>>> [    0.906250] [<c038feac>] (schedule_timeout) from [<c039111c>]
>> (wait_for_common+0x10c/0x1f0)
>>>>> [    0.906250] [<c039111c>] (wait_for_common) from [<c0249228>]
>> (atmel_spi_transfer_one_message+0x71c/0xa48)
>>>>> [    0.906250] [<c0249228>] (atmel_spi_transfer_one_message) from
>> [<c0246624>] (spi_pump_messages+0x210/0x238)
>>>>> [    0.906250] [<c0246624>] (spi_pump_messages) from [<c00343d0>]
>> (kthread_worker_fn+0x15c/0x1b4)
>>>>> [    0.906250] [<c00343d0>] (kthread_worker_fn) from [<c0034534>]
>> (kthread+0xb8/0xcc)
>>>>> [    0.906250] [<c0034534>] (kthread) from [<c0009510>]
>> (ret_from_fork+0x14/0x24)
>>>>> [    0.906250] at25 spi0.0: 128 KByte at25 eeprom, pagesize 512
>>>>
>>>> Actually, I'm not quite sure how spi_pump_messages can be called from
>> an
>>>> atomic context.
>>>
>>> spi_pump_messages() is not called from atomic context.  Rather,
>>> atmel_spi_transfer_one_message() does a spin_lock_irqsave() (via
>>> atmel_spi_lock()) and then calls atmel_spi_one_transfer(), which calls
>>> wait_for_completion_timeout().  That's why schedule is being called
>>> from atomic context.  This was introduced by 8090d6d1a4 ("spi: atmel:
>>> Refactor spi-atmel to use SPI framework queue"). I think you should
>>> see the warning with CONFIG_PREEMPT=y.
>>>
>
> Thanks a lot for the report and analysis.
>
> --->8--------
>  From ba2dd7aee12cb09b9ef159251859443e1b055669 Mon Sep 17 00:00:00 2001
> From: Wenyou Yang <wenyou.yang@atmel.com>
> Date: Mon, 10 Mar 2014 16:44:33 +0800
> Subject: [PATCH] spi: atmel: fix BUG: scheduling while atomic with
>   CONFIG_PREEMPT=y
>
> introduced by 8090d6d1a415d3ae1a7208995decfab8f60f4f36
> ("spi: atmel: Refactor spi-atmel to use SPI framework queue")
>
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> ---
>   drivers/spi/spi-atmel.c |    4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index b0842f7..e05c3f2 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -1130,8 +1130,12 @@ static int atmel_spi_one_transfer(struct spi_master *master,
>   			atmel_spi_next_xfer_pio(master, xfer);
>   		}
>
> +		atmel_spi_unlock(as);
> +
>   		ret = wait_for_completion_timeout(&as->xfer_completion,
>   							SPI_DMA_TIMEOUT);
> +		atmel_spi_lock(as);
> +
>   		if (WARN_ON(ret == 0)) {
>   			dev_err(&spi->dev,
>   				"spi trasfer timeout, err %d\n", ret);
>
