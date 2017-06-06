From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 6 Jun 2017 12:08:59 +0200
Subject: [PATCH 8/8] arm64: dts: hikey: Fix WiFi support
In-Reply-To: <CABGGisxWS2uT6xCATaZbeaDxsEfPz_BSW7Cr=52OwkdFdrV=_Q@mail.gmail.com>
References: <1494260477-25163-1-git-send-email-ulf.hansson@linaro.org>
 <1494260477-25163-9-git-send-email-ulf.hansson@linaro.org>
 <CALAqxLX4HwbVm8G4Ch2uYKAy6C9vYAZEcRUdCLDePT55oGz6hw@mail.gmail.com>
 <d7988293-853f-fb3a-ae29-d1dff4e4d732@linaro.org>
 <CALAqxLU2zz17sHMFKOe4p248Bu4fRiU_dKoBBPbY38gDrpb_mw@mail.gmail.com>
 <CAPDyKFrtE1nKrc1Zk_n=rZTrMVT=Vb=cpk-7AEFWZRmVhFi+4w@mail.gmail.com>
 <CALAqxLWEsQK4g_AM7cPzJSrF_jiTSZpxvLPy_D4HUgdrgf=KuA@mail.gmail.com>
 <CABGGisxWS2uT6xCATaZbeaDxsEfPz_BSW7Cr=52OwkdFdrV=_Q@mail.gmail.com>
Message-ID: <CAPDyKFrAwntQsK_Rxs0Hzthv6TkbofE7LwgVimo60zVKruJHBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

>>>
>>> John, thanks for the report!
>>>
>>> After a some investigation, I realized that the mmc pwrseq_simple
>>> driver returns -EPROBE_DEFER as it's not able to get the "ext" clock.
>>> Hence the SDIO card will not be detected.
>>>
>>> To fix the problem, you need to enable CONFIG_COMMON_CLK_HI655X in the
>>> kernel config. This is actually also the case when using the arm64
>>> defconfig for a plain 4.12 rc3 and later. We should probably make this
>>> driver enabled per default when building the arm64 defconfig.
>>>
>>> Can you run a re-test at your side with the CONFIG_COMMON_CLK_HI655X
>>> set? Just to make sure it works also with those boot binaries you are
>>> using...
>>
>> So unfortunately, now I'm seeing a side-effect from enabling
>> CONFIG_COMMON_CLK_HI655X.
>>
>> Using the serial-dev driver for the TI bluetooth, it seems I'm seeing
>> failures when CONFIG_COMMON_CLK_HI655X is enabled, but configuring it
>> out, bluetooth works (and wifi then fails).
>>
>> Looking through the dmesg logs, the bluetooth driver seems to
>> initialize up properly and load the firmware, but with CLK_HI655X
>> enabled, we see:
>>
>> Bluetooth: hci0 command 0xff05 tx timeout
>> Bluetooth: hci0: send command failed\x0a
>> Bluetooth: hci0 command 0xff36 tx timeout
>> Bluetooth: hci0 command 0x1003 tx timeout
>> Bluetooth: hci0 command 0x1001 tx timeout
>> Bluetooth: hci0 command 0x1009 tx timeout
>> ...

As Rob said below, this is because the blue-tooth driver doesn't
properly deal with the power on/off sequence.

I guess it works for you because your versions of the boot binaries
turns all needed resources on. That isn't the case for me, blue-tooth
is neither working before or after this change, but wifi is.

>>
>> This effectively seems to make bluetooth an wifi functionality
>> exclusive.  So I don't think this is a sufficient solution (over
>> reverting the original patch that changes the dts - which allows both
>> to function).

Since the issues you are reporting about is depending on the
boot-binaries and not a really bugs in the kernel, may I suggest that
we invest our efforts in fixing the blue-tooth driver instead, as it's
there the real problem is!?

>
> If the clock to the TI chip is described in DT for WiFi, then the BT
> side needs it as well (as does the driver) for proper refcounting. The
> same would apply to regulators as well. I looked at the regulators for
> HiKey and the 2 supplies (Vbat and i/o) appear to both be always on.
>
> Rob

Correct.

I am working on patch, I keep you on cc.

Kind regards
Uffe
