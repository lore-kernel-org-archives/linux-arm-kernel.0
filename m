From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 09 Oct 2015 17:21:09 +0200
Subject: [GIT PULL 1/3] Keystone SOC driver updates for 4.4
In-Reply-To: <3E54258959B69E4282D79E01AB1F32B704B94055@DFLE11.ent.ti.com>
References: <1444151960-4941-1-git-send-email-ssantosh@kernel.org>
 <5673608.IRgyBTXroY@wuerfel>
 <3E54258959B69E4282D79E01AB1F32B704B94055@DFLE11.ent.ti.com>
Message-ID: <6169821.dc6khqc2PX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 09 October 2015 15:09:56 Karicheri, Muralidharan wrote:
> >Normally, the firmware name is fixed in the driver. If the API changes in order to support a
> >new feature, the driver of course needs to be aware of that, but it should not require a device
> >tree change to update the file name.
> >
> >Conversely, if you get a new chip that needs a slightly different blob but has an identical API,
> >the driver should ideally not need to be changed, but still see  a new file name.
> >
> >The first can be done once you need it, e.g. by appending the number of the API version to
> >the file name inside of the driver, and trying the highest version supported by the driver first,
> >before falling back to older version in reverse order until the oldest version that is supported
> >by the driver.
> >
> What I gather is the firmware file name is to be part of the driver itself instead of adding the
> same to DT. This way as firmware API change, additional filename strings can be added and handled
> as needed. As API is not expected to change that often, this change will be needed very rarely.

Right.

> But how to deal with the case where firmware blob changes, but no API changes which is mostly
> the case for keystone. For example currently we have 2.0.0, and 2.0.1 is available, but no API
> change. Probably I could name the file as file_2.0.x in driver and as long as there is no API change,
> one could provide a soft link in file system to point to different minor versions.
> 
> ln -s /lib/firmware/file_2.0.1 /lib/firmware/file_2.0.x
> 
> In the case of qmss firmware, it will be named as ks2_qmss_pdsp_acc48_k2_le_1_0_0_x.bin in the
> driver source code as per the above suggestion. In the file system, there will be a soft link to 
> ks2_qmss_pdsp_acc48_k2_le_1_0_0_9.bin.
> ln -s /lib/firmware/ks2_qmss_pdsp_acc48_k2_le_1_0_0_9.bin /lib/firmware/ ks2_qmss_pdsp_acc48_k2_le_1_0_0_x.bin
> 
> Is this acceptable? or do you see any issue with this approach?

I don't know what the policy is for the linux-firmware repository. My
first thought would have been that you only ever put the latest version
into that tree and never change the name. Symlinks can obviously work
as well, and I see some cases of this in my /lib/firmware directory:

$ find /lib/firmware/ -type l | xargs ls -l
find: `/lib/firmware/b43': Permission denied
lrwxrwxrwx 1 root root 16 Jan 31  2014 /lib/firmware/cxgb4/t4fw.bin -> t4fw-1.6.2.0.bin
lrwxrwxrwx 1 root root 18 Jan 31  2014 /lib/firmware/libertas/sd8688.bin -> ../mrvl/sd8688.bin
lrwxrwxrwx 1 root root 25 Jan 31  2014 /lib/firmware/libertas/sd8688_helper.bin -> ../mrvl/sd8688_helper.bin
lrwxrwxrwx 1 root root 10 Jan 31  2014 /lib/firmware/rt3070.bin -> rt2870.bin
lrwxrwxrwx 1 root root 10 Jan 31  2014 /lib/firmware/rt3090.bin -> rt2860.bin
lrwxrwxrwx 1 root root 17 Jan 31  2014 /lib/firmware/s2250.fw -> go7007/s2250-2.fw
lrwxrwxrwx 1 root root 17 Jan 31  2014 /lib/firmware/s2250_loader.fw -> go7007/s2250-1.fw
lrwxrwxrwx 1 root root 14 Jan 31  2014 /lib/firmware/ti-connectivity/wl1271-nvs.bin -> wl127x-nvs.bin
lrwxrwxrwx 1 root root 14 Jan 31  2014 /lib/firmware/ti-connectivity/wl12xx-nvs.bin -> wl127x-nvs.bin

> >The second one basically depends on the "compatible" string of the device, which identifies
> >which device you have. The driver can then look up the file name for each device it supports
> >based on this string, and by using multiple compatible strings in DT, you can provide the
> >specific version of the hardware that is used for the file name without having to match that
> >hardware name in the driver
> >
> 
> This make sense. 
> 
> >> W.r.t to the patch for documentation update, can I send an incremental
> >> patch to the update the linux-firmware.git reference as well?
> >
> >I'd rather skip that documentation change until we have decided on how to handle the
> >firmware loading in the future.
> 
> So if the above is acceptable, I will add the ks2_qmss_pdsp_acc48_k2_le_1_0_0_x.bin name to
> the Kconfig description as you have proposed.

Maybe something shorter for the symlink? I don't know what all the parts of the
name mean, but I assume that the _1_0_0_x can go, and the _le presumably refers
to little-endian and can be removed as well, as the kernel expects the firmware
to have a fixed endianess, independent of how the kernel is built.

	Arnd
