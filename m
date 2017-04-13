From: tyler.baker@linaro.org (Tyler Baker)
Date: Thu, 13 Apr 2017 13:13:24 -0700
Subject: [PATCH 4/8] ARM: dts: imx7s: Add node for GPC
In-Reply-To: <CAOMZO5BaKBsXean8-560HUuZbhjef9dpMNku0SRUVtkv+XsZ6w@mail.gmail.com>
References: <20170413133242.5068-1-andrew.smirnov@gmail.com>
 <20170413133242.5068-5-andrew.smirnov@gmail.com>
 <CANMBJr5sFeVxVq2w2uUd-ehXi9SpaJ7W9S_PTS_VN25YZEdXvQ@mail.gmail.com>
 <CAOMZO5CgLP7P+Q2Mvzpnx6u5ryb1TjAvaj9xDKXpD+8fMmn7MQ@mail.gmail.com>
 <CANMBJr4BWtU7SXEa0-4LFLx+ydVWas0Cx18kRn-=-Bz8pPZ=fg@mail.gmail.com>
 <CAOMZO5BaKBsXean8-560HUuZbhjef9dpMNku0SRUVtkv+XsZ6w@mail.gmail.com>
Message-ID: <CANMBJr7We9uOyE6=BCWoe9L7xRKjOG6ScgtDGEgQ-hPawPeppg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 April 2017 at 12:55, Fabio Estevam <festevam@gmail.com> wrote:
> On Thu, Apr 13, 2017 at 4:24 PM, Tyler Baker <tyler.baker@linaro.org> wrote:
>
>
>> Are you referring to the following patches?
>>
>> "dt-bindings: Add GPCv2 power gating driver"
>> "soc: imx: Add GPCv2 power gating driver"
>>
>> I've pulled these patches from Shawn's tree to test with, but still
>> not able to get anything functional. Is there another series I should
>> be looking at?
>
> Yes, these are the ones I was thinking about. Maybe Andrey can help to
> clarify then.

I've rebased this series on the next-20170413 for sanity sake, and
realized there doesn't appear to be a way to select CONFIG_IMX_GPCV2.
I forced it using 'default y' and configured with imx_v6_v7_defconfig.
Now my board is booting. Before this series is applied, it may be good
to have CONFIG_IMX_GPCV2 selected specifically for iMX7 platform,
otherwise there will be boot regressions.

I'd encounter a backtrace with next-20170413 +  imx_v6_v7_defconfig +
CONFIG_IMX_GPCV2=y

Backtrace:
[<c010c364>] (dump_backtrace) from [<c010c610>] (show_stack+0x18/0x1c)
  r7:00000000 r6:600000d3 r5:00000000 r4:c0e273dc
[<c010c5f8>] (show_stack) from [<c04070a4>] (dump_stack+0xb4/0xe8)
[<c0406ff0>] (dump_stack) from [<c0169e04>] (register_lock_class+0x208/0x5ec)
 r9:ef00d010 r8:ef00d010 r7:c1606448 r6:00000000 r5:00000000 r4:ffffe000
[<c0169bfc>] (register_lock_class) from [<c016da48>]
(__lock_acquire+0x7c/0x18d0)
 r10:c0e0af40 r9:ef00d010 r8:c0e274cc r7:00000001 r6:600000d3 r5:c1606448
 r4:ffffe000
[<c016d9cc>] (__lock_acquire) from [<c016fa4c>] (lock_acquire+0x70/0x90)
 r10:00000000 r9:ef007e38 r8:00000001 r7:00000001 r6:600000d3 r5:00000000
 r4:ffffe000
[<c016f9dc>] (lock_acquire) from [<c09accc8>] (_raw_spin_lock+0x30/0x40)
 r8:600000d3 r7:ef007e10 r6:00000001 r5:ef007e10 r4:ef00d000
[<c09acc98>] (_raw_spin_lock) from [<c04403a4>] (imx_gpcv2_irq_unmask+0x1c/0x5c)
 r4:ef00d000
[<c0440388>] (imx_gpcv2_irq_unmask) from [<c017e838>] (irq_enable+0x38/0x4c)
 r5:00000000 r4:ef007e00
[<c017e800>] (irq_enable) from [<c017e8d0>] (irq_startup+0x84/0x88)
 r5:00000000 r4:ef007e00
[<c017e84c>] (irq_startup) from [<c017cd7c>] (__setup_irq+0x538/0x5f4)
 r7:ef007e60 r6:00000015 r5:ef007e00 r4:ef007d00
[<c017c844>] (__setup_irq) from [<c017ce98>] (setup_irq+0x60/0xd0)
 r10:c0d5fa48 r9:efffcbc0 r8:ef007d00 r7:00000015 r6:ef007e10 r5:00000000
 r4:ef007e00
[<c017ce38>] (setup_irq) from [<c0d4dfdc>] (_mxc_timer_init+0x1f8/0x248)
 r9:efffcbc0 r8:00000003 r7:016e3600 r6:c0c69bbc r5:ef007c40 r4:ef007c00
[<c0d4dde4>] (_mxc_timer_init) from [<c0d4e0dc>] (mxc_timer_init_dt+0xb0/0xf8)
 r7:00000000 r6:c1669e48 r5:ef7ebf7c r4:ef007c00
[<c0d4e02c>] (mxc_timer_init_dt) from [<c0d4e168>]
(imx6dl_timer_init_dt+0x14/0x18)
 r9:efffcbc0 r8:c0e7b000 r7:c0c695c0 r6:c0d6fe18 r5:00000001 r4:ef7ebf7c
[<c0d4e154>] (imx6dl_timer_init_dt) from [<c0d4d158>]
(clocksource_probe+0x54/0xb0)
[<c0d4d104>] (clocksource_probe) from [<c0d04a2c>] (time_init+0x30/0x38)
 r7:c0e07900 r6:c0e7b000 r5:ffffffff r4:00000000
[<c0d049fc>] (time_init) from [<c0d00bc8>] (start_kernel+0x220/0x3a0)
[<c0d009a8>] (start_kernel) from [<8000807c>] (0x8000807c)
 r10:00000000 r9:410fc075 r8:8000406a r7:c0e0c958 r6:c0d5fa44 r5:c0e07918
 r4:c0e7b294


Cheers,

Tyler
