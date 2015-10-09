From: m-karicheri2@ti.com (Karicheri, Muralidharan)
Date: Fri, 9 Oct 2015 18:54:43 +0000
Subject: [GIT PULL 1/3] Keystone SOC driver updates for 4.4
In-Reply-To: <6169821.dc6khqc2PX@wuerfel>
References: <1444151960-4941-1-git-send-email-ssantosh@kernel.org>
 <5673608.IRgyBTXroY@wuerfel>
 <3E54258959B69E4282D79E01AB1F32B704B94055@DFLE11.ent.ti.com>
 <6169821.dc6khqc2PX@wuerfel>
Message-ID: <3E54258959B69E4282D79E01AB1F32B704B94686@DFLE11.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>-----Original Message-----
>From: Arnd Bergmann [mailto:arnd at arndb.de]
>Sent: Friday, October 09, 2015 11:21 AM
>To: Karicheri, Muralidharan
>Cc: Santosh Shilimkar; olof at lixom.net; arm at kernel.org; linux-arm-
>kernel at lists.infradead.org; khilman at kernel.org
>Subject: Re: [GIT PULL 1/3] Keystone SOC driver updates for 4.4
>
>On Friday 09 October 2015 15:09:56 Karicheri, Muralidharan wrote:
>> >Normally, the firmware name is fixed in the driver. If the API
>> >changes in order to support a new feature, the driver of course needs
>> >to be aware of that, but it should not require a device tree change to update the file
>name.
>> >
>> >Conversely, if you get a new chip that needs a slightly different
>> >blob but has an identical API, the driver should ideally not need to be changed, but still
>see  a new file name.
>> >
>> >The first can be done once you need it, e.g. by appending the number
>> >of the API version to the file name inside of the driver, and trying
>> >the highest version supported by the driver first, before falling
>> >back to older version in reverse order until the oldest version that is supported by the
>driver.
>> >
>> What I gather is the firmware file name is to be part of the driver
>> itself instead of adding the same to DT. This way as firmware API
>> change, additional filename strings can be added and handled as needed. As API is not
>expected to change that often, this change will be needed very rarely.
>
>Right.
>
>> But how to deal with the case where firmware blob changes, but no API
>> changes which is mostly the case for keystone. For example currently
>> we have 2.0.0, and 2.0.1 is available, but no API change. Probably I
>> could name the file as file_2.0.x in driver and as long as there is no API change, one could
>provide a soft link in file system to point to different minor versions.
>>
>> ln -s /lib/firmware/file_2.0.1 /lib/firmware/file_2.0.x
>>
>> In the case of qmss firmware, it will be named as
>> ks2_qmss_pdsp_acc48_k2_le_1_0_0_x.bin in the driver source code as per
>> the above suggestion. In the file system, there will be a soft link to
>ks2_qmss_pdsp_acc48_k2_le_1_0_0_9.bin.
>> ln -s /lib/firmware/ks2_qmss_pdsp_acc48_k2_le_1_0_0_9.bin
>> /lib/firmware/ ks2_qmss_pdsp_acc48_k2_le_1_0_0_x.bin
>>
>> Is this acceptable? or do you see any issue with this approach?
>
>I don't know what the policy is for the linux-firmware repository. My first thought would have
>been that you only ever put the latest version into that tree and never change the name.
>Symlinks can obviously work as well, and I see some cases of this in my /lib/firmware
>directory:

A quick grep under linux-firmware.git provided my some firmware names with multiple versions.

./bnx2x/bnx2x-e2-7.8.17.0.fw
./bnx2x/bnx2x-e2-7.2.16.0.fw
./bnx2x/bnx2x-e1h-7.0.29.0.fw
./bnx2x/bnx2x-e2-7.12.30.0.fw
./bnx2x/bnx2x-e2-7.2.51.0.fw
./bnx2x/bnx2x-e1h-7.8.17.0.fw
./bnx2x/bnx2x-e1h-7.2.16.0.fw
./bnx2x/bnx2x-e2-7.0.29.0.fw
./bnx2x/bnx2x-e2-7.8.2.0.fw
./bnx2x/bnx2x-e1-6.2.5.0.fw
./bnx2x/bnx2x-e1-7.8.2.0.fw
./bnx2x/bnx2x-e1h-7.8.2.0.fw
./bnx2x/bnx2x-e1-7.0.20.0.fw
./bnx2x/bnx2x-e1-7.10.51.0.fw
./bnx2x/bnx2x-e2-7.0.20.0.fw
./bnx2x/bnx2x-e1h-6.0.34.0.fw
./bnx2x/bnx2x-e1-7.8.19.0.fw
./bnx2x/bnx2x-e2-6.0.34.0.fw
./bnx2x/bnx2x-e1-7.2.51.0.fw
./bnx2x/bnx2x-e2-6.2.9.0.fw
./bnx2x/bnx2x-e1-7.8.17.0.fw
./bnx2x/bnx2x-e2-7.0.23.0.fw
./bnx2x/bnx2x-e1h-6.2.9.0.fw
./bnx2x/bnx2x-e1-7.0.29.0.fw
./bnx2x/bnx2x-e2-7.10.51.0.fw
./bnx2x/bnx2x-e1-6.0.34.0.fw
./bnx2x/bnx2x-e2-7.8.19.0.fw
./bnx2x/bnx2x-e1h-7.0.23.0.fw
./bnx2x/bnx2x-e1-7.2.16.0.fw
./bnx2x/bnx2x-e1-7.0.23.0.fw
./bnx2x/bnx2x-e1h-7.2.51.0.fw
./bnx2x/bnx2x-e1-6.2.9.0.fw
./bnx2x/bnx2x-e1h-6.2.5.0.fw
./bnx2x/bnx2x-e1h-7.8.19.0.fw
./bnx2x/bnx2x-e1h-7.12.30.0.fw
./bnx2x/bnx2x-e2-6.2.5.0.fw
./bnx2x/bnx2x-e1h-7.0.20.0.fw
./bnx2x/bnx2x-e1h-7.10.51.0.fw
./bnx2x/bnx2x-e1-7.12.30.0.fw

And then

./bnx2/bnx2-rv2p-09ax-5.0.0.j10.fw
./bnx2/bnx2-rv2p-09ax-5.0.0.j3.fw
./bnx2/bnx2-rv2p-09-6.0.17.fw
./bnx2/bnx2-rv2p-06-5.0.0.j3.fw
./bnx2/bnx2-rv2p-09ax-6.0.17.fw
./bnx2/bnx2-mips-09-6.2.1.fw
./bnx2/bnx2-mips-06-6.2.1.fw
./bnx2/bnx2-mips-09-5.0.0.j3.fw
./bnx2/bnx2-rv2p-09-5.0.0.j10.fw
./bnx2/bnx2-mips-09-6.2.1b.fw
./bnx2/bnx2-mips-09-5.0.0.j9.fw
./bnx2/bnx2-mips-09-6.0.17.fw
./bnx2/bnx2-mips-09-6.2.1a.fw
./bnx2/bnx2-mips-06-6.0.15.fw
./bnx2/bnx2-mips-06-4.6.16.fw
./bnx2/bnx2-mips-06-5.0.0.j6.fw
./bnx2/bnx2-mips-09-5.0.0.j15.fw
./bnx2/bnx2-mips-09-4.6.17.fw
./bnx2/bnx2-rv2p-09-5.0.0.j3.fw
./bnx2/bnx2-mips-06-6.2.3.fw
./bnx2/bnx2-rv2p-09-4.6.15.fw
./bnx2/bnx2-mips-06-5.0.0.j3.fw
./bnx2/bnx2-rv2p-06-6.0.15.fw
./bnx2/bnx2-rv2p-06-4.6.16.fw

So multiple versions are possible in the repo.

>
>$ find /lib/firmware/ -type l | xargs ls -l
>find: `/lib/firmware/b43': Permission denied lrwxrwxrwx 1 root root 16 Jan 31  2014
>/lib/firmware/cxgb4/t4fw.bin -> t4fw-1.6.2.0.bin lrwxrwxrwx 1 root root 18 Jan 31  2014
>/lib/firmware/libertas/sd8688.bin -> ../mrvl/sd8688.bin lrwxrwxrwx 1 root root 25 Jan 31
>2014 /lib/firmware/libertas/sd8688_helper.bin -> ../mrvl/sd8688_helper.bin lrwxrwxrwx 1
>root root 10 Jan 31  2014 /lib/firmware/rt3070.bin -> rt2870.bin lrwxrwxrwx 1 root root 10
>Jan 31  2014 /lib/firmware/rt3090.bin -> rt2860.bin lrwxrwxrwx 1 root root 17 Jan 31  2014
>/lib/firmware/s2250.fw -> go7007/s2250-2.fw lrwxrwxrwx 1 root root 17 Jan 31  2014
>/lib/firmware/s2250_loader.fw -> go7007/s2250-1.fw lrwxrwxrwx 1 root root 14 Jan 31
>2014 /lib/firmware/ti-connectivity/wl1271-nvs.bin -> wl127x-nvs.bin lrwxrwxrwx 1 root root
>14 Jan 31  2014 /lib/firmware/ti-connectivity/wl12xx-nvs.bin -> wl127x-nvs.bin
>
>> >The second one basically depends on the "compatible" string of the
>> >device, which identifies which device you have. The driver can then
>> >look up the file name for each device it supports based on this
>> >string, and by using multiple compatible strings in DT, you can
>> >provide the specific version of the hardware that is used for the
>> >file name without having to match that hardware name in the driver
>> >
>>
>> This make sense.
>>
>> >> W.r.t to the patch for documentation update, can I send an
>> >> incremental patch to the update the linux-firmware.git reference as well?
>> >
>> >I'd rather skip that documentation change until we have decided on
>> >how to handle the firmware loading in the future.
>>
>> So if the above is acceptable, I will add the
>> ks2_qmss_pdsp_acc48_k2_le_1_0_0_x.bin name to the Kconfig description as you have
>proposed.
>
>Maybe something shorter for the symlink? I don't know what all the parts of the name mean,
>but I assume that the _1_0_0_x can go, and the _le presumably refers to little-endian and
>can be removed as well, as the kernel expects the firmware to have a fixed endianess,
>independent of how the kernel is built.

A generic name I can suggest is ks2_qmss_pdsp_acc48.bin in the code. It describes, soc (ks2),
sub system (qmss), pdsp (CPU running the firmware), channel configuration (acc48). Since there
can be other configuration (acc32) or firmware can be on a dsp as well, this doesn't cause any
conflict in the future. I will go with this name if no one has objections.

In the file system, this can be a symbolic link which can point to the actual firmware which is
obtained from the linux-firmware.git repo.

If API change in future, then a new file name can be added at that point and driver may be modified
to work with this new firmware. So this would accommodate future upgrades as well.

const char *qmss_acc_firmware[] = "ks2_qmss_pdsp_acc48.bin";

This can be expanded in future if API change. The driver can start searching for the firmware starting
with latest to oldest. If specific firmware requires customization of the interface, this can be handled
by using additional firmware specific data in a struct instead of char ptr array.

In the file system, we could add a link to the real firmware file.

ln -s /lib/firmware/ks2_qmss_pdsp_acc48.bin /lib/firmware/ks2_qmss_pdsp_acc48_k2_le_1_0_0_x.bin

Another thing I have noticed is that some of the firmware are named as *.fw, while others are *.bin. Not sure
what the difference is and both suffixes are currently in use. I just picked a bin suffix as this a binary blob for
the software.

W.r.t documentation, Santosh has reservation on adding firmware name to Kconfig description.
IMO, a better option is to add a Documentation for driver. Currently driver design is also captured as part of the
DT bindings. We could just keep the DT bindings description in the DT documentation and move the Design to Documentation/arm/keystone/qmss.txt and provide a link to refer each other. The firmware detail can be added
to this. Does it work?

Murali

>
>	Arnd
