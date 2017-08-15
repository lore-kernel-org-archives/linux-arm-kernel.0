From: xuwei5@hisilicon.com (Wei Xu)
Date: Tue, 15 Aug 2017 14:34:57 +0100
Subject: [PATCH] arm64: dts: hi6220: improve g-tx-fifo-size setting for
 usb device
In-Reply-To: <CALAqxLU2FzNwETSVggbdW1Yb01ZcNgRHp5vgYNNDh9tjNukZTw@mail.gmail.com>
References: <1502082090-22017-1-git-send-email-shawnguo@kernel.org>
 <CALAqxLU2FzNwETSVggbdW1Yb01ZcNgRHp5vgYNNDh9tjNukZTw@mail.gmail.com>
Message-ID: <5992F881.902@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn, John,

On 2017/8/7 22:18, John Stultz wrote:
> On Sun, Aug 6, 2017 at 10:01 PM, Shawn Guo <shawnguo@kernel.org> wrote:
>> From: Shawn Guo <shawn.guo@linaro.org>
>>
>> The current usb device g-tx-fifo-size setting in DT causes two problems
>> for kernel driver.
>>
>> 1. On hi6220, there are 15 tx_fifo dedicated for all EPs except EP0,
>>    while DT only provides tx_fifo settings for 6 EPs.  It results in the
>>    following annoying complaints from kernel.
>>
>> [    4.451623] dwc2 f72c0000.usb: dwc2_check_param_tx_fifo_sizes: Invalid parameter g_tx_fifo_size[7]=0
>> [    4.461303] dwc2 f72c0000.usb: dwc2_check_param_tx_fifo_sizes: Invalid parameter g_tx_fifo_size[8]=0
>> [    4.470969] dwc2 f72c0000.usb: dwc2_check_param_tx_fifo_sizes: Invalid parameter g_tx_fifo_size[9]=0
>> [    4.480632] dwc2 f72c0000.usb: dwc2_check_param_tx_fifo_sizes: Invalid parameter g_tx_fifo_size[10]=0
>> [    4.490385] dwc2 f72c0000.usb: dwc2_check_param_tx_fifo_sizes: Invalid parameter g_tx_fifo_size[11]=0
>> [    4.500140] dwc2 f72c0000.usb: dwc2_check_param_tx_fifo_sizes: Invalid parameter g_tx_fifo_size[12]=0
>> [    4.509892] dwc2 f72c0000.usb: dwc2_check_param_tx_fifo_sizes: Invalid parameter g_tx_fifo_size[13]=0
>> [    4.519646] dwc2 f72c0000.usb: dwc2_check_param_tx_fifo_sizes: Invalid parameter g_tx_fifo_size[14]=0
>> [    4.529399] dwc2 f72c0000.usb: dwc2_check_param_tx_fifo_sizes: Invalid parameter g_tx_fifo_size[15]=0
>> [    4.539244] dwc2 f72c0000.usb: EPs: 16, dedicated fifos, 1920 entries in SPRAM
>>
>>    Besides of that, the total 1920 fifo entries isn't fully utilized.
>>    Endpoint Info Control block consumes 128 entries, g-rx-fifo-size
>>    is 512, and g-np-tx-fifo-size is 128.  So the fifi entries available
>>    for tx_fifo is: 1920 - 128 - 512 - 128 = 1152.  Considering that
>>    the minimal valid tx_fifo size for each EP is 16, it should be
>>    reasonable to allocate 1152 entries as: 128 x 8 + 16 x 7 = 1136 (only
>>    16 entries unused).  With this new setting, we can get more EPs to
>>    use while removing the above warning messages in the meantime.
>>
>> 2. Another consequence of above invalid g_tx_fifo_size parameter is that
>>    kernel driver will use values read from hardware register as the
>>    fall-back.  The value is 2048 for each EP fifo.  That's obviously
>>    invalid either, because even fifo entries for one EP exceeds the
>>    total entries 1920.  That's why we see the following fat warning from
>>    function dwc2_hsotg_init_fifo().  The new g-tx-fifo-size settings
>>    help to remove the warning as well.
> 
> 
> Nice! This has been bothering me for awhile, and your fix seems to
> resolve it well! I can now remove one of the hack patches I've been
> carrying.
> 
> Tested-by: John Stultz <john.stultz@linaro.org>
> (if its useful: Acked-by: John Stultz <john.stultz@linaro.org>)
> 
> Wei: Can we be sure to get this queued for 4.14?

Thanks!
Applied to the hisilicon dt tree.

Best Regards,
Wei

> 
> thanks
> -john
> 
> .
> 
