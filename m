From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 19 Jun 2017 13:50:39 +0200
Subject: [RFC 2/2] mmc: meson-mx-sdio: Add a driver for the Amlogic Meson8
 and Meson8b SoCs
In-Reply-To: <CAFBinCD=uH=oQmWAcsMpxtbJCnJZernZx3XoNaPixUUQ7pk76w@mail.gmail.com>
References: <20170506171857.16492-1-martin.blumenstingl@googlemail.com>
 <20170506171857.16492-3-martin.blumenstingl@googlemail.com>
 <CAPDyKFrrSLCjbXO9R4VqPpabiFsbE6_RqR=U7otVF4Ncv0jHjQ@mail.gmail.com>
 <CAFBinCD3modyyOpi3OY5XLhjX0UCuV+WPY2Z=mdvwdMCyeGoqg@mail.gmail.com>
 <CAPDyKFptXRPk7mVUiRHf=hECDbeyhTxuf3K1M6NkZcVEF0Enww@mail.gmail.com>
 <CAFBinCD=uH=oQmWAcsMpxtbJCnJZernZx3XoNaPixUUQ7pk76w@mail.gmail.com>
Message-ID: <CAPDyKFrbxMpgDrZXKmrN4fyJWJ_ZML3jPxBs+YDEz=L1kA-BaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
>> [...]
>>
>>>>> +       if (!(cmd->flags & MMC_RSP_CRC))
>>>>> +               send |= MESON_MX_SDIO_SEND_RESP_WITHOUT_CRC7;
>>>>> +
>>>>> +       if (cmd->flags & MMC_RSP_BUSY)
>>>>> +               send |= MESON_MX_SDIO_SEND_CHECK_DAT0_BUSY;
>>>>
>>>> In case the controller has HW support of busy detection, please
>>>> consider to enable MMC_CAP_WAIT_WHILE_BUSY for this driver. Then also
>>>> assign host->max_busy_timeout a good value.
>>> the IRQS register has bit 4 (CMD_BUSY) - but apart from that there is
>>> no other documentation (about timeout values, etc.). the vendor driver
>>> also neither uses MMC_CAP_WAIT_WHILE_BUSY nor host->max_busy_timeout
>>> should I leave this as it is?
>>
>> Please don't just leave it as is. This is an important thing to get right.
>>
>> You should be able to explore this area and see how the controller
>> behaves without too much of documentation. Regarding timeouts, it may
>> very well be that the controller don't have a timeout, which is why
>> you need a software timeout. That's not so uncommon actually.
> during my experiments I've never seen an interrupt when a command
> timed out (nor could I find information about a timeout register in
> the documentation). do you have any pointers (like a previous mail
> where you've explained) how I can "explore the controller's timeout
> behavior"?

Sorry, I don't have an pointers.

Anyway. If you do a big erase operation on an SD card, the card should
signal busy on DAT0 for a rather long time.

You could probably explore how long it takes for the card to respond
under those circumstances, and try both with and without
MESON_MX_SDIO_SEND_CHECK_DAT0_BUSY.

Of course you also need to try with and without
MMC_CAP_WAIT_WHILE_BUSY, as the core may sometimes convert R1B to R1
responses depending on that cap.

[...]

>>
>> It shouldn't be that hard to implement, although I strongly recommend
>> you to address this in a second step. In other words, I suggest you to
>> drop the entire multiple slot support in the first step, then we can
>> deal with that on top instead.
> many thanks for the detailed explanation again!
> I would be fine with dropping multiple slot support for the moment
> *if* we can agree on the fact that the devicetree binding can support
> multiple slots in theory (my idea here is: keep the child-nodes with
> compatible = "mmc-slot" mandatory - but only allow one such child node
> for now). I don't want to break DT compatibility after a few
> weeks/months for a new driver. is that OK for you as well?

That's fine! We already have such a binding available for some other
mmc controllers. We could even consider to make that binding a generic
mmc binding.

[...]

Kind regards
Uffe
