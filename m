From: mfuzzey@gmail.com (Martin Fuzzey)
Date: Thu, 23 Jun 2016 17:14:14 +0200
Subject: i.MX53 restart via watchdog does not work
In-Reply-To: <CAOMZO5AUWDwdui+zkAxUu=m2XcOcrrtFEpib0oj+p_QokSR-bw@mail.gmail.com>
References: <57111429.6040802@nxtcontrol.com>
 <CAOMZO5DHTm2iSyGF1CcwuWxzmwbadttKmtVJQePd60A6a0jsgA@mail.gmail.com>
 <571654B0.6040203@nxtcontrol.com>
 <CAOMZO5AxUcjDLo6afdFTkZJv9QnsUvHWwcJmsno3o52DqipN-Q@mail.gmail.com>
 <571678B6.4010203@nxtcontrol.com>
 <CAOMZO5AUWDwdui+zkAxUu=m2XcOcrrtFEpib0oj+p_QokSR-bw@mail.gmail.com>
Message-ID: <CALBypN7T9zvN7w6KeO2MG__Gwif-Xbs_Nrryb_KsQ7kE1fvmbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I'm running into this same issue on a custom i.MX53 based board with a
4.4 kernel.

Bootloader (u-boot) is loaded from eMMC with the reset (kernel + root
filesystem) netbooted.

When booting from SD instead of eMMC on same board problem does not occur.

However mmc_sleep() is called on both reboot and normal suspend to RAM.
However the problem *only* occurs on reboot, not on suspend to ram.
So applying Stanislav's patch above will also increase suspend power
consumption.

The reboot sequence is:

1) suspend eMMC (CMD 5)
2) Switch off 3V3 to eMMC
3) Toggle reset line by emmc_reset
4) Reset CPU via watchdog
5) 3V3 to eMMC comes on due to board wiring
6) [BOOTROM] send CMD0
7) [BOOTROM] load u-boot

Removing step 1 makes it reboot OK
Removing step 2 makes no change
Removing step 3 makes no change

I haven't been able to probe the signals to know what's hapenning in
steps 5 or 6 and step 5 is from the flow chart in the i.MX53 reference
manual.

On my eMMC device the reset line is actually ignored by default - it
has to be enabled by a once only, non reversible write to the extcsd.
I think that's a true for all eMMC devices.
There are three ways of getting the eMMC device out of suspend:
*) CMD 0
*) CMD 5
*) Hardware reset signal

Since CMD 0 is always sent (linux only uses CMD 5 for suspend, not for
resume) that explains why disabling step 3 makes no difference

The linux suspend / resume sequence (which works) is:

1) suspend eMMC (CMD 5) (mmc_sleep())
2) Switch off 3V3 to eMMC
..
3) Switch on 3V3 to eMMC
4) Send CMD0 to get out of reset (mmc_init_card())

I'm having difficulty seeing why the reboot case doesn't work whilst
the suspend / resume case does work.
There are some differences concerning the power supply but since it
leaving it enabled doesn't fix the problem that would seem to be
eliminated.

Regards,

Martin


On Tue, Apr 19, 2016 at 8:43 PM, Fabio Estevam <festevam@gmail.com> wrote:
> On Tue, Apr 19, 2016 at 3:28 PM, Stanislav Meduna
> <stanislav.meduna@nxtcontrol.com> wrote:
>> On 4/19/2016 8:18 PM, Fabio Estevam wrote:
>>
>>> I am booting via NFS, so not eMMC related.
>>
>> Where are you bootstrapping the bootloader from?
>>
>> I am also not using the eMMC at all, I was tftp-booting
>> a minimal initramfs image with just rdinit=/bin/sh (the fastest
>> way to play with reboots).
>>
>> In my case the bootloader (U-Boot) itself is loaded from
>> the eMMC. To me it looks the shutdown code somehow brings
>> the board to a state where the processor itself can't
>> boot the bootloader.
>
> imx53-qsb boots from a SD card. Issuing a 'reboot' command works fine
> on 4.6-rc4.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
